# Liquido 🌊

[![License: MPL 2.0][license_badge]][license_link]

> **⚠️ EXPERIMENTAL - TECHNOLOGY DEMONSTRATOR ONLY**  
> This package is highly experimental and not intended for production use. It was not created with performance in mind and should be considered a technology demonstration only. Use at your own risk.
>
> **⚠️ IMPELLER ONLY**  
> This package is only compatible with Flutter's Impeller rendering engine. It will not work with the Skia backend.

Create beautiful liquid glass effects in your Flutter applications.

<img src="https://raw.githubusercontent.com/renancaraujo/liquido/refs/heads/main/doc/assets/screenshot.jpg" width="300">

## The Story Behind Liquido

This package started as a creative experiment after Apple introduced their liquid glass effects in their UI. I had some ideas about how to implement similar visuals in Flutter, and Liquido is the result of a few hours of experimentation. The goal was to see how far I could push Flutter's rendering capabilities to create realistic glass effects that respond to the content behind them.

I'll be writing a more detailed blog post about the technical challenges and solutions soon - stay tuned!

## Getting Started 🚀

Since this is an experimental package, you'll need to add it directly from GitHub to your Flutter project:

```yaml
dependencies:
  liquido:
    git:
      url: https://github.com/renancaraujo/liquido.git
      ref: main
```

Then import it in your code:

```dart
import 'package:liquido/liquido.dart';
```

### Impeller Requirement

This package relies on shader features that are only available in Flutter's Impeller rendering engine. To ensure compatibility:

1. For iOS: Impeller is enabled by default on iOS in Flutter 3.10+
2. For Android: Enable Impeller in your app by adding the following to your `AndroidManifest.xml`:
   ```xml
   <meta-data
     android:name="io.flutter.embedding.android.EnableImpeller"
     android:value="true" />
   ```
3. For macOS/desktop: Launch your app with the `--enable-impeller` flag

Attempting to use this package with Skia will result in rendering errors or crashes.

## Usage 📱

Liquido provides several ways to create glass effects in your Flutter UI. Check out the example app for comprehensive usage demonstrations.

### Basic Glass Container

Create a container with glass effect:

```dart
Glass(
  blurSigma: 20,
  refractionBorder: 2,
  saturationBoost: 1.1,
  centerScale: 0.8,
  brightnessCompensation: -0.1,
  shape: RoundedSuperellipseBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(66),
    ),
  ),
  child: SizedBox(
    width: 200,
    height: 100,
  ),
)
```

### Glass Text

Create text with a glass effect:

```dart
Glass.text(
  'Hello Glass',
  textAlign: TextAlign.center,
  style: GoogleFonts.nunito(
    fontSize: 60,
    fontWeight: FontWeight.w900,
  ),
  blurSigma: 35,
  saturationBoost: 0.7,
  brightnessCompensation: 0.2,
  refractionBorder: 3,
)
```

### Custom Glass Shape

Create a glass effect with a custom shape:

```dart
Glass.custom(
  mask: YourCustomShapeWidget(),
  child: YourContentWidget(),
  blurSigma: 15,
  refractionBorder: 4,
  glassTint: Colors.blue.withOpacity(0.1),
)
```

## Customization Options 🎨

Liquido offers many customization options to fine-tune your glass effect:

| Parameter | Description | Recommended Range |
|-----------|-------------|------------------|
| `blurSigma` | The amount of blur applied to the glass effect | 0-40 |
| `contrastBoost` | The amount of contrast applied to the glass effect | 1-1.3 |
| `saturationBoost` | The amount of saturation applied to the glass effect | 1-1.3 |
| `grainIntensity` | The amount of grain applied to the glass effect | 0-1 |
| `brightnessCompensation` | The brightness adjustment of the glass | -1.0 to 1.0 |
| `centerScale` | The scaling factor for the center of the glass effect | 0.1-1.5 |
| `edgeScale` | The scaling factor for the edges of the glass effect | 0.1-1.5 |
| `glassTint` | The color tint applied to the glass effect | Any color with alpha |
| `refractionBorder` | The width of the refraction border in pixels | 0-half of surface size |
| `boxShadow` | The shadow applied around the glass effect | Any BoxShadow |

## Example App

For a complete demonstration of Liquido's capabilities, check out the example app in the `/example` directory. It showcases various glass effects, including:

- Glass shapes with customized parameters
- Animated clock with glass effect
- Interactive glass buttons
- Animated background gradients behind glass surfaces


## Known Limitations ⚠️

This package has several limitations, and there is no guarantee that these issues will ever be addressed or resolved as this is primarily a technology demonstration:

- **Impeller only**: Does not work with Skia rendering backend
- Not optimized for performance - may cause frame drops on complex UIs
- Works best with static or slowly animating content
- High blur values can be computationally expensive
- Shader compilation may cause a brief delay on first render
- Not all platforms support Impeller equally well - iOS has the best support
- May break with future Flutter updates as it relies on implementation details

## License

This project is licensed under the Mozilla Public License 2.0 (MPL-2.0) - see the [LICENSE](LICENSE) file for details.

---

[license_badge]: https://img.shields.io/badge/license-MPL-green.svg
[license_link]: https://opensource.org/license/mpl-2-0
