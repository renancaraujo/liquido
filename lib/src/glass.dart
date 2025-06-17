// Copyright (c) 2025, Renan Araujo
// Use of this source code is governed by a MPL-2.0 license that can be
// found in the LICENSE file.

import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:liquido/src/glass_options.dart';
import 'package:liquido/src/glass_render_object_widget.dart';

const String _kGlassShaderAssetKey =
    'packages/liquido/shaders/liquido_impeller.frag';

/// A widget that creates a glass effect.
///
/// See the construtors for different ways to create a glass effect:
/// [Glass], [Glass.text], and [Glass.custom].
///
/// See also:
/// - [GlassOptionsInterface] for the parameters that can be used to customize
///  the glass effect.
/// - [GlassOptions.defaultOptions], the default values for these
///  parameters.
abstract class Glass implements Widget, GlassOptionsInterface {
  /// Creates a glass effect container.
  ///
  /// If [child] is not provided, the behavior is similar to a
  /// [Container].
  ///
  /// For [shape], if not provided, a rounded superellipse border
  /// with a radius of 30 is used.
  ///
  /// Any subclass of [ShapeBorder] can be used here, but it is recommended
  /// to use a shape that is compatible with the glass effect, such as:
  /// - [RoundedSuperellipseBorder]
  /// - [RoundedRectangleBorder]
  /// - [CircleBorder]
  /// - [StadiumBorder]
  /// - [BeveledRectangleBorder]
  /// - [ContinuousRectangleBorder]
  ///
  /// If not provided, the default [shape] is a
  /// [RoundedSuperellipseBorder] with a radius of 30.
  ///
  /// Glass effect parameters:
  /// {@macro glass_options}
  ///
  /// See also:
  /// - [GlassOptionsInterface] for the parameters that can be used to customize
  ///  the glass effect.
  /// - [GlassOptions.defaultOptions], the default values for these
  /// parameters.
  /// - [Glass.text] for a convenience constructor that creates a glass effect
  /// with a [Text] widget.
  /// - [Glass.custom] for a convenience constructor that creates a glass effect
  /// with a custom mask widget.
  const factory Glass({
    Key? key,
    ShapeBorder? shape,

    //
    double? blurSigma,
    double? contrastBoost,
    double? saturationBoost,
    double? grainIntensity,
    double? brightnessCompensation,
    double? centerScale,
    double? edgeScale,
    Color? glassTint,
    double? refractionBorder,
    BoxShadow? boxShadow,
    Widget? child,
  }) = _GlassContainer;

  /// Creates a glass effect with a text widget.
  ///
  /// This constructor provides a convenient way to create text with a glass
  /// effect. It supports all standard text parameters from the [Text] widget
  /// for precise text styling and layout control.
  ///
  /// The text will automatically be used as both the glass shape mask and the
  /// content, creating a glass effect that perfectly follows the text shape.
  ///
  /// Example:
  /// ```dart
  /// Glass.text(
  ///   'Hello World',
  ///   style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
  ///   blurSigma: 15.0,
  ///   glassTint: Colors.blue.withOpacity(0.1),
  /// )
  /// ```
  ///
  /// Note: The text color, background color, decoration color, and shadows will
  /// be overridden to ensure compatibility with the glass effect.
  ///
  /// Glass effect parameters:
  /// {@macro glass_options}
  ///
  /// See also:
  /// - [Glass] for a container with a glass effect.
  /// - [Glass.custom] for a glass effect with a custom mask.
  /// - [GlassOptionsInterface] for details about the glass effect parameters.
  const factory Glass.text(
    String data, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    String? semanticsIdentifier,
    TextWidthBasis? textWidthBasis,
    ui.TextHeightBehavior? textHeightBehavior,

    //
    double? blurSigma,
    double? contrastBoost,
    double? saturationBoost,
    double? grainIntensity,
    double? brightnessCompensation,
    double? centerScale,
    double? edgeScale,
    Color? glassTint,
    double? refractionBorder,
    BoxShadow? boxShadow,
  }) = _GlassText;

  /// Creates a glass effect with a custom mask widget.
  ///
  /// This constructor provides the most flexibility by allowing you to specify
  /// both the mask widget that defines the shape of the glass effect and the
  /// child widget that will be displayed through the glass.
  ///
  /// The [mask] widget should use solid colors (nothing but 1.0 or 0.0 in the
  /// alpha channel) for areas where the
  /// glass effect should be applied, and transparent for areas where it should
  /// not.
  ///
  /// ⚠️ Warning! Dont use shadows, blurs or any other shenanigan thay may
  /// result in semi transparent pixels in the mask widget, as this may lead to
  /// unexpected results. The mask should be a solid shape with no transparency.
  ///
  /// This allows for complex glass effects like custom-shaped windows, cutouts,
  /// or applying glass effects to specific regions of a widget.
  ///
  /// Glass effect parameters:
  /// {@macro glass_options}
  ///
  /// See also:
  /// - [Glass] for a container with a glass effect.
  /// - [Glass.text] for a glass effect with text.
  /// - [GlassOptionsInterface] for details about the glass effect parameters.
  const factory Glass.custom({
    required Widget mask,
    required Widget child,
    Key? key,

    //
    double? blurSigma,
    double? contrastBoost,
    double? saturationBoost,
    double? grainIntensity,
    double? brightnessCompensation,
    double? centerScale,
    double? edgeScale,
    Color? glassTint,
    double? refractionBorder,
    BoxShadow? boxShadow,
  }) = _CustomGlass;
}

class _GlassContainer extends StatelessWidget implements Glass {
  const _GlassContainer({
    super.key,
    this.shape,
    this.child,
    this.blurSigma,
    this.contrastBoost,
    this.saturationBoost,
    this.grainIntensity,
    this.brightnessCompensation,
    this.centerScale,
    this.edgeScale,
    this.glassTint,
    this.refractionBorder,
    this.boxShadow,
  });

  final Widget? child;
  final ShapeBorder? shape;

  @override
  final double? blurSigma;
  @override
  final BoxShadow? boxShadow;
  @override
  final double? brightnessCompensation;
  @override
  final double? centerScale;
  @override
  final double? contrastBoost;
  @override
  final double? edgeScale;
  @override
  final ui.Color? glassTint;
  @override
  final double? grainIntensity;
  @override
  final double? refractionBorder;
  @override
  final double? saturationBoost;

  @override
  Widget build(BuildContext context) {
    return _Glass(
      options: this,
      mask: DecoratedBox(
        decoration: ShapeDecoration(
          color: const Color(0xFF000000),
          shape:
              shape ??
              RoundedSuperellipseBorder(
                borderRadius: BorderRadius.circular(30),
              ),
        ),
      ),
      child: Container(child: child),
    );
  }
}

class _GlassText extends StatelessWidget implements Glass {
  const _GlassText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.semanticsIdentifier,
    this.textWidthBasis,
    this.textHeightBehavior,

    this.blurSigma,
    this.contrastBoost,
    this.saturationBoost,
    this.grainIntensity,
    this.brightnessCompensation,
    this.centerScale,
    this.edgeScale,
    this.glassTint,
    this.refractionBorder,
    this.boxShadow,
  });

  @override
  final double? blurSigma;
  @override
  final BoxShadow? boxShadow;
  @override
  final double? brightnessCompensation;
  @override
  final double? centerScale;
  @override
  final double? contrastBoost;
  @override
  final double? edgeScale;
  @override
  final ui.Color? glassTint;
  @override
  final double? grainIntensity;
  @override
  final double? refractionBorder;
  @override
  final double? saturationBoost;

  final String data;

  final TextStyle? style;

  final StrutStyle? strutStyle;

  final TextAlign? textAlign;

  final TextDirection? textDirection;

  final Locale? locale;

  final bool? softWrap;

  final TextOverflow? overflow;

  final TextScaler? textScaler;

  final int? maxLines;

  final String? semanticsLabel;

  final String? semanticsIdentifier;

  final TextWidthBasis? textWidthBasis;

  final ui.TextHeightBehavior? textHeightBehavior;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    var effectiveTextStyle = style;
    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }
    if (MediaQuery.boldTextOf(context)) {
      effectiveTextStyle = effectiveTextStyle!.merge(
        const TextStyle(fontWeight: FontWeight.bold),
      );
    }

    // Prevent user from doing anything stupid
    effectiveTextStyle = effectiveTextStyle!.copyWith(
      color: const Color(0xFF000000),
      decorationColor: const Color(0xFF000000),
      backgroundColor: const Color(0xFF000000),
      shadows: [],
    );

    final text = Text(
      data,
      style: effectiveTextStyle,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      semanticsIdentifier: semanticsIdentifier,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: const Color(0x00000000),
    );

    return _Glass(
      options: this,
      mask: text,
      child: text,
    );
  }
}

class _CustomGlass extends StatelessWidget implements Glass {
  const _CustomGlass({
    required this.mask,
    required this.child,
    super.key,
    this.blurSigma,
    this.contrastBoost,
    this.saturationBoost,
    this.grainIntensity,
    this.brightnessCompensation,
    this.centerScale,
    this.edgeScale,
    this.glassTint,
    this.refractionBorder,
    this.boxShadow,
  });

  @override
  final double? blurSigma;
  @override
  final BoxShadow? boxShadow;
  @override
  final double? brightnessCompensation;
  @override
  final double? centerScale;
  @override
  final double? contrastBoost;
  @override
  final double? edgeScale;
  @override
  final ui.Color? glassTint;
  @override
  final double? grainIntensity;
  @override
  final double? refractionBorder;
  @override
  final double? saturationBoost;

  final Widget child;
  final Widget mask;

  @override
  Widget build(BuildContext context) {
    return _Glass(
      options: this,
      mask: mask,
      child: child,
    );
  }
}

class _Glass extends StatelessWidget {
  const _Glass({
    required this.options,
    required this.child,
    required this.mask,
  });

  final GlassOptionsInterface options;
  final Widget child;
  final Widget mask;

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      assetKey: _kGlassShaderAssetKey,
      (context, shader, childWidget) {
        return GlassRenderObjectWidget(
          shader: shader,
          pixelRatio: MediaQuery.of(context).devicePixelRatio,
          mask: mask,
          options: GlassOptions.fromInterface(options),
          child: childWidget!,
        );
      },
      child: child,
    );
  }
}
