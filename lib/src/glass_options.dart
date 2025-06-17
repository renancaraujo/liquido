// Copyright (c) 2025, Renan Araujo
// Use of this source code is governed by a MPL-2.0 license that can be
// found in the LICENSE file.

import 'dart:ui' as ui;

import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

/// A common interface for the parameters used in the glass effect.
///
/// This interface defines the properties that can be used to customize the
/// glass effect, such as blur, contrast, saturation, grain intensity,
///
/// Properties:
/// {@template glass_options}
/// Things you may want to change most often are:
/// [blurSigma], [refractionBorder], [brightnessCompensation],
/// [glassTint], and [boxShadow].
/// {@endtemplate}
///
/// See also;
/// - [GlassOptions.defaultOptions], the default values for these
///   properties.
/// - [GlassOptions], a concrete, lerpable implementation of this interface.
abstract interface class GlassOptionsInterface {
  /// The amount of blur applied to the glass effect.
  /// The recommended value is between 0 and 40. 0 means no blur. Higher values
  /// may result in artifacts.
  /// See default on [GlassOptions.defaultOptions].
  double? get blurSigma;

  /// The amount of contrast applied to the glass effect.
  /// The recommended value is between 1 and 1.3. 1 means no contrast boost.
  /// Higher values may result in artifacts.
  /// See default on [GlassOptions.defaultOptions].
  double? get contrastBoost;

  /// The amount of saturation applied to the glass effect.
  /// The recommended value is between 1 and 1.3. 1 means no saturation boost.
  /// Higher values may result in artifacts.
  /// See default on [GlassOptions.defaultOptions].
  double? get saturationBoost;

  /// The amount of grain applied to the glass effect.
  /// The recommended value is between 0 and 1. 0 means no grain.
  /// See default on [GlassOptions.defaultOptions].
  double? get grainIntensity;

  /// The amount of brightness compensation applied to the glass effect.
  /// The recommended value is between -1.0 and 1.0. 0 means no brightness
  /// compensation, -1 means full dark glass, 1 means full bright glass.
  /// Higher or lower values may result in artifacts.
  /// See default on [GlassOptions.defaultOptions].
  double? get brightnessCompensation;

  /// The amount of scaling applied to the center of the glass effect.
  /// 1.0 means no scaling, 2.0 means double the size of the center.
  /// The recommended value is between 0.1 and 1.5.
  /// See default on [GlassOptions.defaultOptions].
  double? get centerScale;

  /// The amount of scaling applied to the edges of the glass effect.
  /// 1.0 means no scaling, 2.0 means double the size of the edges.
  /// The recommended value is between 0.1 and 1.5.
  /// See default on [GlassOptions.defaultOptions].
  double? get edgeScale;

  /// The color tint applied to the glass effect.
  /// The recommended value is a color with an alpha value between 0 and 1.
  /// 0 means no tint, 1 means full tint.
  /// See default on [GlassOptions.defaultOptions].
  Color? get glassTint;

  /// The width of the refraction border applied to the edges of the glass
  /// effect in pixels.
  /// The recommended value is to never exceed half the size (width or height)
  /// of the glassed surface.
  /// 0 means no refraction border.
  /// See default on [GlassOptions.defaultOptions].
  double? get refractionBorder;

  /// The shadow applied around the glass effect.
  /// Null means no shadow. See [BoxShadow] for more information.
  /// See default on [GlassOptions.defaultOptions].
  BoxShadow? get boxShadow;
}

/// A concrete implementation of [GlassOptionsInterface] that provides default
/// values for the glass effect parameters.
///
/// See also:
/// - [GlassOptionsInterface] for more information on the
/// properties.
/// - [GlassOptions.defaultOptions] for the default values of these
/// properties.
class GlassOptions with EquatableMixin implements GlassOptionsInterface {
  /// Creates a new instance of [GlassOptions] with the specified parameters.
  ///
  /// All parameters are required to ensure a fully configured glass effect.
  /// For default values, see [GlassOptions.defaultOptions].
  ///
  /// Example:
  /// ```dart
  /// final customGlass = GlassOptions(
  ///   blurSigma: 15.0,
  ///   contrastBoost: 1.1,
  ///   saturationBoost: 1.1,
  ///   grainIntensity: 0.2,
  ///   brightnessCompensation: 0.5,
  ///   centerScale: 1.0,
  ///   edgeScale: 1.0,
  ///   glassTint: Colors.blue.withOpacity(0.1),
  ///   refractionBorder: 10.0,
  ///   boxShadow: BoxShadow(
  ///     color: Colors.black.withOpacity(0.2),
  ///     blurRadius: 10,
  ///     spreadRadius: 2,
  ///   ),
  /// );
  /// ```
  const GlassOptions({
    required this.blurSigma,
    required this.contrastBoost,
    required this.saturationBoost,
    required this.grainIntensity,
    required this.brightnessCompensation,
    required this.centerScale,
    required this.edgeScale,
    required this.glassTint,
    required this.refractionBorder,
    required this.boxShadow,
  });

  /// Creates a new instance of [GlassOptions] from an existing
  ///  [GlassOptionsInterface].
  ///
  /// This constructor provides a convenient way to convert any implementation
  /// of [GlassOptionsInterface] into a concrete [GlassOptions] instance.
  /// It fills in any null values with the corresponding values from
  /// [defaultOptions].
  ///
  /// This is useful when you want to ensure all properties have non-null
  /// values, or when you want to convert a partial configuration into a
  /// complete one.
  ///
  /// Example:
  /// ```dart
  /// // Some partial implementation of GlassOptionsInterface
  /// final partialOptions = MyCustomGlassOptions();
  ///
  /// // Convert to a complete GlassOptions instance
  /// final completeOptions = GlassOptions.fromInterface(partialOptions);
  /// ```
  GlassOptions.fromInterface(
    GlassOptionsInterface options,
  ) : this(
        blurSigma: options.blurSigma ?? defaultOptions.blurSigma,
        contrastBoost: options.contrastBoost ?? defaultOptions.contrastBoost,
        saturationBoost:
            options.saturationBoost ?? defaultOptions.saturationBoost,
        grainIntensity: options.grainIntensity ?? defaultOptions.grainIntensity,
        brightnessCompensation:
            options.brightnessCompensation ??
            defaultOptions.brightnessCompensation,
        centerScale: options.centerScale ?? defaultOptions.centerScale,
        edgeScale: options.edgeScale ?? defaultOptions.edgeScale,
        glassTint: options.glassTint ?? defaultOptions.glassTint,
        refractionBorder:
            options.refractionBorder ?? defaultOptions.refractionBorder,
        boxShadow: options.boxShadow ?? defaultOptions.boxShadow,
      );

  /// The default options for the glass effect.
  ///
  /// These values are recommended for most use cases and provide a good
  /// starting point for customizing the glass effect.
  ///
  /// Things you may want to change most often are:
  /// [blurSigma], [refractionBorder], [brightnessCompensation],
  /// [glassTint], and [boxShadow].
  static const GlassOptions defaultOptions = GlassOptions(
    blurSigma: 10,
    contrastBoost: 1,
    saturationBoost: 1,
    grainIntensity: 0,
    brightnessCompensation: 0,
    centerScale: 1,
    edgeScale: 1,
    glassTint: null,
    refractionBorder: 0,
    boxShadow: null,
  );

  @override
  final double blurSigma;
  @override
  final double contrastBoost;
  @override
  final double saturationBoost;
  @override
  final double grainIntensity;
  @override
  final double brightnessCompensation;
  @override
  final double centerScale;
  @override
  final double edgeScale;
  @override
  final Color? glassTint;
  @override
  final double refractionBorder;
  @override
  final BoxShadow? boxShadow;

  /// Creates a new [GlassOptions] by linearly interpolating between
  /// two instances.
  ///
  /// If either `a` or `b` is null, this function returns the non-null instance.
  /// If both  are null, it returns null.
  ///
  /// The `t` argument represents the position on the timeline, with 0.0 meaning
  /// this function returns `a`, and 1.0 meaning this function returns `b`.
  static GlassOptionsInterface? lerp(
    GlassOptionsInterface? a,
    GlassOptionsInterface? b,
    double t,
  ) {
    if (a == null && b == null) return null;
    if (a == null) return b;
    if (b == null) return a;
    if (t == 0.0) return a;
    if (t == 1.0) return b;

    return GlassOptions(
      blurSigma: ui.lerpDouble(a.blurSigma, b.blurSigma, t)!,
      contrastBoost: ui.lerpDouble(a.contrastBoost, b.contrastBoost, t)!,
      saturationBoost: ui.lerpDouble(a.saturationBoost, b.saturationBoost, t)!,
      grainIntensity: ui.lerpDouble(a.grainIntensity, b.grainIntensity, t)!,
      brightnessCompensation: ui.lerpDouble(
        a.brightnessCompensation,
        b.brightnessCompensation,
        t,
      )!,
      centerScale: ui.lerpDouble(a.centerScale, b.centerScale, t)!,
      edgeScale: ui.lerpDouble(a.edgeScale, b.edgeScale, t)!,
      glassTint: Color.lerp(a.glassTint, b.glassTint, t),
      refractionBorder: ui.lerpDouble(
        a.refractionBorder,
        b.refractionBorder,
        t,
      )!,
      boxShadow: BoxShadow.lerp(a.boxShadow, b.boxShadow, t),
    );
  }

  @override
  List<Object?> get props => [
    blurSigma,
    contrastBoost,
    saturationBoost,
    grainIntensity,
    brightnessCompensation,
    centerScale,
    edgeScale,
    glassTint,
    refractionBorder,
    boxShadow,
  ];
}

/// Extension that provides convenient linear interpolation methods for
/// [GlassOptionsInterface] instances.
///
/// This extension adds methods for interpolating between two
/// [GlassOptionsInterface] instances, making it easier to create animations
/// or transitions between different glass effect configurations.
///
/// See also:
/// - [GlassOptionsInterface] for the interface that this extension applies to.
/// - [GlassOptions.lerp] for the static method used internally by this
///   extension.
extension GlassOptionsLerp on GlassOptionsInterface {
  /// Creates a new [GlassOptions] that is a copy of this instance but with the
  /// given fields replaced with the values interpolated between this instance
  /// and another.
  ///
  /// The `t` argument represents the position on the timeline, with 0.0 meaning
  /// this function returns `this`, and 1.0 meaning this function returns
  /// `other`.
  GlassOptionsInterface? lerpTo(GlassOptionsInterface? other, double t) {
    if (other == null) return this;
    return GlassOptions.lerp(this, other, t);
  }

  /// Creates a new [GlassOptions] that is a copy of the given instance but with
  /// the given fields replaced with the values interpolated between the given
  /// instance and this instance.
  ///
  /// The `t` argument represents the position on the timeline, with 0.0 meaning
  /// this function returns `other`, and 1.0 meaning this function returns
  /// `this`.
  GlassOptionsInterface? lerpFrom(GlassOptionsInterface? other, double t) {
    if (other == null) return this;
    return GlassOptions.lerp(other, this, t);
  }
}
