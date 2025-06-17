// Copyright (c) 2025, Renan Araujo
// Use of this source code is governed by a MPL-2.0 license that can be
// found in the LICENSE file.

#version 460 core

precision highp float;

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform vec4 uComponentRect;
uniform float uBlurSigma;
uniform float uContrastBoost;
uniform float uSaturationBoost;
uniform float uGrainIntensity;
uniform float uBrightnessCompensation;
uniform float uEdgeScale;
uniform float uCenterScale;
uniform vec4 uGlassTint;

uniform sampler2D uTextureInput;
uniform sampler2D uMask;
uniform sampler2D uBlurMask;
uniform sampler2D uSecondaryBlurMask;

out vec4 fragColor;

#define PI 3.14159265358979323846

float hash(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(mix(hash(i), hash(i + vec2(1.0, 0.0)), u.x), mix(hash(i + vec2(0.0, 1.0)), hash(i + vec2(1.0, 1.0)), u.x), u.y);
}

vec4 blurAndOtherStuff(vec2 uv, float edgeStr) {
    float blurRadius = uBlurSigma ;

  
    const int samples = 6;
    const float gamma = 2.2;
    const float invGamma = 1.0 / gamma;
    const float grainScale = 1.2;
    const float grainSharp = 0.9;
    const float grainDistAmt = 8.4;

    vec4 origColor = texture(uTextureInput, uv);
    vec2 grainCoord = uv * uSize * grainScale;
    float grainNoise = noise(grainCoord);

    grainNoise = pow(abs(grainNoise * 2.0 - 1.0), grainSharp) * sign(grainNoise - 0.5) * 0.5 + 0.5;
    float fineGrain = noise(grainCoord * 2.0) * 0.4 + noise(grainCoord * 4.0) * 0.3;
    float grain = mix(grainNoise, fineGrain, 0.3) * uGrainIntensity;

    if(blurRadius < 0.1) {

        float grainBrightnessCompensation = 0.1;

        vec3 result = origColor.rgb + vec3(grain * 0.2 - 0.1 + grainBrightnessCompensation);

        return vec4(result, origColor.a);

    }

    vec3 blurColor = vec3(0.0);
    float totalWeight = 0.0;

    for(int y = -samples; y <= samples; ++y) {
        for(int x = -samples; x <= samples; ++x) {
            vec2 samplePos = vec2(float(x), float(y)) / float(samples);
            float localGrain = noise((samplePos + uv) * uSize * grainScale * 0.5) * uGrainIntensity;

            vec2 grainDist = vec2(noise((samplePos + uv) * uSize * 0.2), noise((samplePos + uv) * uSize * 0.2 + vec2(3.14, 2.71))) * 2.0 - 1.0;

            vec2 offset = vec2(x, y);
            offset += grainDist * grain * grainDistAmt;
            offset *= (blurRadius / float(samples)) / uSize;

            float dist = length(vec2(x, y)) / float(samples);
            float grainFactor = mix(0.8, 1.2, localGrain);
            float weight = exp(-dist * dist * grainFactor * 5.0);

            if(weight > 0.001) {
                blurColor += pow(texture(uTextureInput, uv + offset).rgb, vec3(gamma)) * weight;
                totalWeight += weight;
            }
        }
    }

    blurColor /= totalWeight;

    vec3 avgColor = vec3(0.5);
    blurColor = avgColor + (blurColor - avgColor) * uContrastBoost;

    float lum = dot(blurColor, vec3(0.299, 0.587, 0.114));
    blurColor = mix(vec3(lum), blurColor, uSaturationBoost);
    blurColor = mix(blurColor, blurColor * (1.0 + grain * 0.2), grain * 0.5);

    vec3 srgbColor = pow(blurColor, vec3(invGamma));
    float grainEffect = grain * 0.2 - 0.075 + 0.1;

    return vec4(srgbColor + vec3(grainEffect), origColor.a);
}

float softLightChannel(float base, float blend) {
    return blend < 0.5 ? base - (1.0 - 2.0 * blend) * base * (1.0 - base) : base + (2.0 * blend - 1.0) * (sqrt(base) - base);
}

vec3 softLight(vec3 base, vec3 blend) {
    return vec3(softLightChannel(base.r, blend.r), softLightChannel(base.g, blend.g), softLightChannel(base.b, blend.b));
}

void inMaskRegion(vec2 pos, inout vec4 color) {
    vec2 uv = pos / uSize;
    vec2 uvComp = (pos - uComponentRect.xy) / uComponentRect.zw;
    vec2 compCenter = (uComponentRect.xy + uComponentRect.zw * 0.5) / uSize;

    float dCenter = length(uvComp - 0.5);
    float t = smoothstep(0.0, 1.0, clamp(1.0 - dCenter, 0.0, 1.0));
    float magFactor = mix(1.0 / uEdgeScale, 1.0 / uCenterScale, t);

    vec2 magPos = (uv - compCenter) * magFactor + compCenter;

    float edgeStr = 1.0 - texture(uBlurMask, uvComp).a;

    edgeStr = pow(clamp(edgeStr, 0.0, 1.0), 0.9);
    edgeStr = clamp(edgeStr, 0.0, 0.7) * 1.42857;
    edgeStr *= pow(dCenter, .1);

    float angle = -atan(uvComp.y - 0.5, uvComp.x - 0.5);
    vec2 distUV = magPos + vec2(-cos(angle), sin(angle)) * 0.08 * edgeStr;

    color = blurAndOtherStuff(distUV, edgeStr);

    float colorIntensity = uGlassTint.a;
    colorIntensity += colorIntensity * edgeStr;

    float postEdgeStr = 1.0 - texture(uSecondaryBlurMask, uvComp).a;
    vec3 softLightBlend = softLight(color.rgb, uGlassTint.rgb);
    color.rgb = mix(color.rgb, softLightBlend, colorIntensity);

    float brightComp = uBrightnessCompensation;
    float brightBoost = PI / 9.0 * abs(brightComp);
    float brightDir = brightComp < 0.0 ? -1.0 : 1.0;

    brightBoost += brightBoost * postEdgeStr;
    color.rgb = mix(color.rgb, vec3(brightDir), brightBoost);

    float shineFactor = postEdgeStr * clamp(sin((angle + PI / 1.8) * 1.8), 0.0, 1.0) * dCenter;
    color.rgb = mix(color.rgb, vec3(1.0), shineFactor * 0.5);

    float shadowFactor = postEdgeStr * clamp(cos((angle + PI / -2.7) * 2.0), 0.0, 1.0) * dCenter;
    color.rgb = mix(color.rgb, vec3(0.0), shadowFactor * 0.5);
}

void fragment(vec2 pos, inout vec4 color) {
    vec2 uvComp = (pos - uComponentRect.xy) / uComponentRect.zw;

    if(all(greaterThanEqual(uvComp, vec2(0.0))) && all(lessThanEqual(uvComp, vec2(1.0))))
        if(texture(uMask, uvComp).a > 0.0)
            inMaskRegion(pos, color);
}

void main() {
    vec2 pos = FlutterFragCoord().xy;
    vec4 color;
    fragment(pos, color);
    fragColor = color;
}
