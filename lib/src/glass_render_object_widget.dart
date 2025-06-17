// Copyright (c) 2025, Renan Araujo
// Use of this source code is governed by a MPL-2.0 license that can be
// found in the LICENSE file.

// This file is mostly internal, I am not documenting this.
// ignore_for_file: public_member_api_docs

import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:liquido/src/glass.dart';

import 'package:liquido/src/glass_options.dart';

/// The [RenderObjectWidget] used by [Glass] to glassify its child.
///
/// Most people will not need to use this class directly, but if you really need
/// it, good luck.
class GlassRenderObjectWidget extends MultiChildRenderObjectWidget {
  GlassRenderObjectWidget({
    required this.shader,
    required Widget mask,
    required Widget child,
    required this.options,
    super.key,
    this.pixelRatio = 1.0,
  }) : super(children: [mask, child]);

  final ui.FragmentShader shader;
  final double pixelRatio;
  final GlassOptions options;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderGlass(
      shader: shader,
      pixelRatio: pixelRatio,
      blurSigma: options.blurSigma,
      contrastBoost: options.contrastBoost,
      saturationBoost: options.saturationBoost,
      grainIntensity: options.grainIntensity,
      brightnessCompensation: options.brightnessCompensation,
      edgeScale: options.edgeScale,
      centerScale: options.centerScale,
      glassTint: options.glassTint,
      refractionBorder: options.refractionBorder,
      boxShadow: options.boxShadow,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderGlass renderObject) {
    renderObject
      ..shader = shader
      ..pixelRatio = pixelRatio
      ..blurSigma = options.blurSigma
      ..contrastBoost = options.contrastBoost
      ..saturationBoost = options.saturationBoost
      ..grainIntensity = options.grainIntensity
      ..brightnessCompensation = options.brightnessCompensation
      ..edgeScale = options.edgeScale
      ..centerScale = options.centerScale
      ..glassTint = options.glassTint
      ..refractionBorder = options.refractionBorder
      ..boxShadow = options.boxShadow;
  }
}

class GlassRenderObjectParentData extends ContainerBoxParentData<RenderBox> {}

class RenderGlass extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, GlassRenderObjectParentData>,
        RenderBoxContainerDefaultsMixin<
          RenderBox,
          GlassRenderObjectParentData
        > {
  RenderGlass({
    required ui.FragmentShader shader,
    required double pixelRatio,
    required double blurSigma,
    required double contrastBoost,
    required double saturationBoost,
    required double grainIntensity,
    required double brightnessCompensation,
    required double edgeScale,
    required double centerScale,
    required Color? glassTint,
    required double refractionBorder,
    required BoxShadow? boxShadow,
  }) : _shader = shader,
       _pixelRatio = pixelRatio,
       _blurSigma = blurSigma,
       _contrastBoost = contrastBoost,
       _saturationBoost = saturationBoost,
       _grainIntensity = grainIntensity,
       _brightnessCompensation = brightnessCompensation,
       _edgeScale = edgeScale,
       _centerScale = centerScale,
       _glassTint = glassTint,
       _refractionBorder = refractionBorder,
       _boxShadow = boxShadow;

  ui.FragmentShader get shader => _shader;
  ui.FragmentShader _shader;
  set shader(ui.FragmentShader value) {
    if (_shader == value) return;
    _shader = value;
    markNeedsPaint();
  }

  double get pixelRatio => _pixelRatio;
  double _pixelRatio;
  set pixelRatio(double value) {
    if (_pixelRatio == value) return;
    _pixelRatio = value;
    markNeedsPaint();
  }

  double get blurSigma => _blurSigma;
  double _blurSigma;
  set blurSigma(double value) {
    if (_blurSigma == value) return;
    _blurSigma = value;
    markNeedsPaint();
  }

  double get contrastBoost => _contrastBoost;
  double _contrastBoost;
  set contrastBoost(double value) {
    if (_contrastBoost == value) return;
    _contrastBoost = value;
    markNeedsPaint();
  }

  double get saturationBoost => _saturationBoost;
  double _saturationBoost;
  set saturationBoost(double value) {
    if (_saturationBoost == value) return;
    _saturationBoost = value;
    markNeedsPaint();
  }

  double get grainIntensity => _grainIntensity;
  double _grainIntensity;
  set grainIntensity(double value) {
    if (_grainIntensity == value) return;
    _grainIntensity = value;
    markNeedsPaint();
  }

  double get brightnessCompensation => _brightnessCompensation;
  double _brightnessCompensation;
  set brightnessCompensation(double value) {
    if (_brightnessCompensation == value) return;
    _brightnessCompensation = value;
    markNeedsPaint();
  }

  double get edgeScale => _edgeScale;
  double _edgeScale;
  set edgeScale(double value) {
    if (_edgeScale == value) return;
    _edgeScale = value;
    markNeedsPaint();
  }

  double get centerScale => _centerScale;
  double _centerScale;
  set centerScale(double value) {
    if (_centerScale == value) return;
    _centerScale = value;
    markNeedsPaint();
  }

  Color? get glassTint => _glassTint;
  Color? _glassTint;
  set glassTint(Color? value) {
    if (_glassTint == value) return;
    _glassTint = value;
    markNeedsPaint();
  }

  double get refractionBorder => _refractionBorder;
  double _refractionBorder;
  set refractionBorder(double value) {
    if (_refractionBorder == value) return;
    _refractionBorder = value;
    markNeedsPaint();
  }

  BoxShadow? get boxShadow => _boxShadow;
  BoxShadow? _boxShadow;
  set boxShadow(BoxShadow? value) {
    if (_boxShadow == value) return;
    _boxShadow = value;
    markNeedsPaint();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! GlassRenderObjectParentData) {
      child.parentData = GlassRenderObjectParentData();
    }
  }

  RenderBox? get mask => firstChild;
  RenderBox? get actualChild => lastChild;

  @override
  bool get alwaysNeedsCompositing => true;

  @override
  bool get isRepaintBoundary => true;

  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.biggest;
      return;
    }

    final maskBox = mask;
    final childBox = actualChild;

    if (childBox != null) {
      childBox.layout(constraints, parentUsesSize: true);
      size = childBox.size;
      (childBox.parentData! as GlassRenderObjectParentData).offset =
          Offset.zero;
    } else {
      size = constraints.smallest;
    }

    if (maskBox != null) {
      maskBox.layout(BoxConstraints.tight(size));
      (maskBox.parentData! as GlassRenderObjectParentData).offset = Offset.zero;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final childBox = actualChild;

    if (childBox != null) {
      final childParentData =
          childBox.parentData! as GlassRenderObjectParentData;
      return result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(
            transformed == position - childParentData.offset,
            'Hit test position does not match expected offset: '
            '$transformed != ${position - childParentData.offset}',
          );
          return childBox.hitTest(result, position: transformed);
        },
      );
    }

    return false;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (childCount == 0 || size.isEmpty) return;
    assert(offset == Offset.zero, 'RenderGlass should not be offset');
    context
      // Add mask to the composited layer tree, it will be the first child
      ..pushLayer(
        ContainerLayer(),
        (PaintingContext context, Offset offset) {
          if (size.isEmpty) return;

          final maskBox = mask;
          if (maskBox != null) {
            final childParentData =
                maskBox.parentData! as GlassRenderObjectParentData;
            context.paintChild(maskBox, offset + childParentData.offset);
          }
        },
        offset,
      )
      // Add the actual child to the composited layer tree, it will be the
      // second child
      ..pushLayer(
        ContainerLayer(),
        (PaintingContext context, Offset offset) {
          if (size.isEmpty) return;

          final childBox = actualChild;
          if (childBox != null) {
            final childParentData =
                childBox.parentData! as GlassRenderObjectParentData;
            context.paintChild(childBox, offset + childParentData.offset);

            final shadow = _boxShadow;
            if (shadow != null) {
              context.canvas.saveLayer(
                null,
                Paint()..blendMode = BlendMode.dstIn,
              );
              context.paintChild(mask!, offset + childParentData.offset);
              context.canvas.restore();

              context.canvas.saveLayer(null, Paint());

              context.canvas.saveLayer(
                null,
                Paint()
                  ..imageFilter = ui.ImageFilter.blur(
                    sigmaX: shadow.blurRadius,
                    sigmaY: shadow.blurRadius,
                  ),
              );

              context.canvas.translate(shadow.offset.dx, shadow.offset.dy);
              context.paintChild(mask!, offset + childParentData.offset);

              context.canvas.saveLayer(
                null,
                Paint()..blendMode = BlendMode.srcIn,
              );
              context.canvas.drawRect(
                Rect.fromLTWH(
                  offset.dx + childParentData.offset.dx,
                  offset.dy + childParentData.offset.dy,
                  size.width,
                  size.height,
                ),
                Paint()..color = shadow.color,
              );
              context.canvas.restore();
              context.canvas.restore();

              context.canvas.saveLayer(
                null,
                Paint()..blendMode = BlendMode.dstOut,
              );
              context.paintChild(mask!, offset + childParentData.offset);
              context.canvas.restore();
            }
          }
        },
        offset,
      );
  }

  @override
  OffsetLayer updateCompositedLayer({OffsetLayer? oldLayer}) {
    _GlassFilterLayer layer;

    if (oldLayer is _GlassFilterLayer) {
      layer = oldLayer
        ..shader = _shader
        ..pixelRatio = _pixelRatio
        ..size = size
        ..blurSigma = _blurSigma
        ..contrastBoost = _contrastBoost
        ..saturationBoost = _saturationBoost
        ..grainIntensity = _grainIntensity
        ..brightnessCompensation = _brightnessCompensation
        ..edgeScale = _edgeScale
        ..centerScale = _centerScale
        ..glassTint = _glassTint
        ..refractionBorder = _refractionBorder;
    } else {
      layer = _GlassFilterLayer(
        shader: _shader,
        pixelRatio: _pixelRatio,
        size: size,
        blurSigma: _blurSigma,
        contrastBoost: _contrastBoost,
        saturationBoost: _saturationBoost,
        grainIntensity: _grainIntensity,
        brightnessCompensation: _brightnessCompensation,
        edgeScale: _edgeScale,
        centerScale: _centerScale,
        glassTint: _glassTint,
        refractionBorder: _refractionBorder,
      );
    }

    return layer;
  }

  @override
  void dispose() {
    _shader.dispose();
    super.dispose();
  }
}

class _GlassFilterLayer extends OffsetLayer {
  _GlassFilterLayer({
    required ui.FragmentShader shader,
    required double pixelRatio,
    required Size size,
    required double blurSigma,
    required double contrastBoost,
    required double saturationBoost,
    required double grainIntensity,
    required double brightnessCompensation,
    required double edgeScale,
    required double centerScale,
    required Color? glassTint,
    required double refractionBorder,
  }) : _shader = shader,
       _pixelRatio = pixelRatio,
       _size = size,
       _blurSigma = blurSigma,
       _contrastBoost = contrastBoost,
       _saturationBoost = saturationBoost,
       _grainIntensity = grainIntensity,
       _brightnessCompensation = brightnessCompensation,
       _edgeScale = edgeScale,
       _centerScale = centerScale,
       _glassTint = glassTint,
       _refractionBorder = refractionBorder,
       super();

  ui.FragmentShader _shader;
  set shader(ui.FragmentShader value) {
    if (_shader == value) return;
    _shader = value;
    _clearLastImages();
    markNeedsAddToScene();
  }

  double _pixelRatio;
  set pixelRatio(double value) {
    if (_pixelRatio == value) return;
    _pixelRatio = value;
    _clearLastImages();
    markNeedsAddToScene();
  }

  Size _size;
  set size(Size value) {
    if (value == _size) return;
    _size = value;
    _clearLastImages();
    markNeedsAddToScene();
  }

  double _blurSigma;
  set blurSigma(double value) {
    if (_blurSigma == value) return;
    _blurSigma = value;
    markNeedsAddToScene();
  }

  double _contrastBoost;
  set contrastBoost(double value) {
    if (_contrastBoost == value) return;
    _contrastBoost = value;
    markNeedsAddToScene();
  }

  double _saturationBoost;
  set saturationBoost(double value) {
    if (_saturationBoost == value) return;
    _saturationBoost = value;
    markNeedsAddToScene();
  }

  double _grainIntensity;
  set grainIntensity(double value) {
    if (_grainIntensity == value) return;
    _grainIntensity = value;
    markNeedsAddToScene();
  }

  double _brightnessCompensation;
  set brightnessCompensation(double value) {
    if (_brightnessCompensation == value) return;
    _brightnessCompensation = value;
    markNeedsAddToScene();
  }

  double _edgeScale;
  set edgeScale(double value) {
    if (_edgeScale == value) return;
    _edgeScale = value;
    markNeedsAddToScene();
  }

  double _centerScale;
  set centerScale(double value) {
    if (_centerScale == value) return;
    _centerScale = value;
    markNeedsAddToScene();
  }

  Color? _glassTint;
  set glassTint(Color? value) {
    if (_glassTint == value) return;
    _glassTint = value;
    markNeedsAddToScene();
  }

  double _refractionBorder;
  set refractionBorder(double value) {
    if (_refractionBorder == value) return;
    _refractionBorder = value;
    markNeedsAddToScene();
  }

  ui.BackdropFilterEngineLayer? _backdropFilterLayer;
  ui.ImageFilterEngineLayer? _imageFilterLayer;
  ui.Image? _lastMaskImage;
  ui.Image? _lastBlurredMaskImage;
  ui.Image? _lastSecondaryBlurredMaskImage;

  void _clearLastImages() {
    _lastMaskImage?.dispose();
    _lastMaskImage = null;

    _lastBlurredMaskImage?.dispose();
    _lastBlurredMaskImage = null;

    _lastSecondaryBlurredMaskImage?.dispose();
    _lastSecondaryBlurredMaskImage = null;
  }

  @override
  void addToScene(ui.SceneBuilder builder) {
    final offsetLayer = builder.pushOffset(
      offset.dx,
      offset.dy,
      oldLayer: engineLayer as ui.OffsetEngineLayer?,
    );
    engineLayer = offsetLayer;
    {
      _shader.setFloatUniforms(initialIndex: 2, (uniforms) {
        final rect = Rect.fromLTWH(
          offset.dx,
          offset.dy,
          _size.width,
          _size.height,
        );
        uniforms
          ..setFloat(rect.left * _pixelRatio)
          ..setFloat(rect.top * _pixelRatio)
          ..setFloat(rect.width * _pixelRatio)
          ..setFloat(rect.height * _pixelRatio)
          ..setFloat(_blurSigma)
          ..setFloat(_contrastBoost)
          ..setFloat(_saturationBoost)
          ..setFloat(_grainIntensity)
          ..setFloat(_brightnessCompensation)
          ..setFloat(_edgeScale)
          ..setFloat(_centerScale)
          ..setColor(_glassTint ?? const ui.Color(0x00000000));
      });

      final mask = _buildMaskImage();
      _lastMaskImage?.dispose();
      _lastMaskImage = mask;

      final blurMask = _buildMaskImage(_refractionBorder);
      _lastBlurredMaskImage?.dispose();
      _lastBlurredMaskImage = blurMask;

      final secondaryBlurMask = _buildMaskImage(5);
      _lastSecondaryBlurredMaskImage?.dispose();
      _lastSecondaryBlurredMaskImage = secondaryBlurMask;

      _shader
        ..setImageSampler(1, mask)
        ..setImageSampler(2, blurMask)
        ..setImageSampler(3, secondaryBlurMask);

      _backdropFilterLayer = builder.pushBackdropFilter(
        ui.ImageFilter.shader(_shader),
        oldLayer: _backdropFilterLayer,
      );
      {
        addActualChildToScene(builder);
      }
      builder.pop();
    }
    builder.pop();
  }

  ui.Image _buildMaskImage([double? refractionBorder]) {
    final builder = ui.SceneBuilder();
    final transform = Matrix4.diagonal3Values(_pixelRatio, _pixelRatio, 1);
    final bounds = offset & _size;
   

    builder.pushTransform(transform.storage);
    addMaskToScene(builder, refractionBorder);
    builder.pop();

    return builder.build().toImageSync(
      (_pixelRatio * bounds.width).floor(),
      (_pixelRatio * bounds.height).floor(),
    );
  }

  void addMaskToScene(ui.SceneBuilder builder, [double? refractionBorder]) {
    final mask = firstChild;

    if (refractionBorder != null) {
      _imageFilterLayer = builder.pushImageFilter(
        ui.ImageFilter.blur(sigmaX: refractionBorder, sigmaY: refractionBorder),
        oldLayer: _imageFilterLayer,
      );
    }


    mask?.addToScene(builder);

    if (refractionBorder != null) {
      builder.pop();
    }
  }

  void addActualChildToScene(ui.SceneBuilder builder) {
    firstChild?.nextSibling?.addToScene(builder);
  }

  @override
  void detach() {
    _clearLastImages();
    super.detach();
  }

  @override
  void dispose() {
    _clearLastImages();
    _backdropFilterLayer = null;
    _imageFilterLayer = null;
    super.dispose();
  }
}
