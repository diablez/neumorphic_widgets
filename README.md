# Neumorphic Widgets

<p align="right"><sub><strong>SETO</strong> / ENGINEERING · ROBOTICS · SOFTWARE</sub></p>

[![pub.dev version](https://img.shields.io/pub/v/neumorphism_widgets?label=pub.dev)](https://pub.dev/packages/neumorphism_widgets)
[![pub.dev likes](https://img.shields.io/pub/likes/neumorphism_widgets)](https://pub.dev/packages/neumorphism_widgets)
[![pub.dev points](https://img.shields.io/pub/points/neumorphism_widgets)](https://pub.dev/packages/neumorphism_widgets/score)
[![MIT license](https://img.shields.io/badge/license-MIT-7A9E90)](LICENSE)

**Customisable, tactile Flutter controls.** A collection of widgets with soft raised and recessed surfaces, adjustable shadows, colours, shapes, and tap animations.

**[Get the package](https://pub.dev/packages/neumorphism_widgets)** · **[API reference](https://pub.dev/documentation/neumorphism_widgets/latest/)** · **[Example app source](example/)** · **[Report an issue](https://github.com/diablez/neumorphic_widgets/issues)**

> **Play with the widgets:** An [interactive Flutter Web laboratory](example/lib/gallery.dart) is included in the repository, with live previews, theme and colour controls, and copyable Dart snippets. A [GitHub Actions build](.github/workflows/gallery.yml) produces a web artifact for testing. **There is no public demo URL yet**; GitHub READMEs cannot run Flutter directly.

## Widgets

| Widget | What it does | Customisation |
| --- | --- | --- |
| `NeuContainer` | Reusable raised or inverted-elevation surface | Colours, gradients, shape, radius, padding, tap modes |
| `NeuButton` | Button with configurable tap animation | Shape, colour, enabled state, tap mode |
| `NeuSwitch` | Animated toggle | Vertical/horizontal orientation, active/inactive colours |
| `NeuSlider` | 0–100 value slider | Orientation, length, width, track/handle colour |
| `NeuCheckbox` | Self-contained checkbox control | Shape, active/inactive colours, enabled state |
| `NeuAppBar` | Neumorphic wrapper around a Flutter app bar | Title, leading widget, actions, bottom widget |

The library supports light or dark colour schemes. The visual result depends on the surface and shadow colours you supply.

## Installation

Add the published package to an existing Flutter project:

```sh
flutter pub add neumorphism_widgets
```

Or declare version `^0.0.8` in `pubspec.yaml`. Then import:

```dart
import 'package:neumorphism_widgets/neumorphism_widgets.dart';
```

## Quick start

Add the widgets inside a Flutter `build` method. To get a consistent result, match `boxShadowColor` to the surrounding surface colour:

```dart
import 'package:flutter/material.dart';
import 'package:neumorphism_widgets/neumorphism_widgets.dart';

// Inside a widget's build method:
final surface = Colors.grey.shade200;

return ColoredBox(
  color: surface,
  child: Center(
    child: NeuButton(
      boxShadowColor: surface,
      tapMode: TapMode.dynamic,
      onPressed: (value) => debugPrint('Button callback: $value'),
      child: const Text('Press me'),
    ),
  ),
);
```

### More widget examples

<details>
<summary><strong>NeuContainer</strong> — raised or inverted-elevation surfaces</summary>

```dart
NeuContainer(
  boxShadowColor: Colors.grey.shade200,
  inset: true,
  radius: 16,
  padding: const EdgeInsets.all(20),
  shape: BoxShape.rectangle,
  tapMode: TapMode.dynamic,
  onPressed: () => debugPrint('Container tapped'),
  child: const Text('A tactile surface'),
)
```

</details>

<details>
<summary><strong>NeuSwitch</strong> — animated horizontal/vertical toggle</summary>

Use this inside a `StatefulWidget` with a `bool isEnabled = false;` field.

```dart
NeuSwitch(
  boxShadowColor: Colors.grey.shade200,
  activeColor: Colors.teal,
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
)
```

Set `vertical: true` for a vertical toggle.

</details>

<details>
<summary><strong>NeuSlider</strong> — adjustable 0–100 value</summary>

Use this inside a `StatefulWidget` with a `double brightness = 50;` field.

```dart
NeuSlider(
  boxShadowColor: Colors.grey.shade200,
  color: Colors.teal,
  value: brightness,
  length: 200,
  width: 30,
  onChanged: (value) => setState(() => brightness = value),
)
```

Set `vertical: true` to rotate the control.

</details>

<details>
<summary><strong>NeuCheckbox</strong> — self-contained selection</summary>

```dart
NeuCheckbox(
  boxShadowColor: Colors.grey.shade200,
  isChecked: false,
  activeColor: Colors.teal,
  enable: true,
)
```

**v0.0.8 note:** `NeuCheckbox` maintains its checked state internally. It uses `enable` (not `enabled`) and does not expose an `onChanged` callback.

</details>

<details>
<summary><strong>NeuAppBar</strong> — tactile app bar</summary>

```dart
Scaffold(
  appBar: NeuAppBar(
    boxShadowColor: Colors.grey.shade200,
    title: const Text('Neumorphic Widgets'),
    centerTitle: true,
    leading: const Icon(Icons.menu),
    actions: [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () => debugPrint('Search tapped'),
      ),
    ],
  ),
  body: const Center(child: Text('Hello, neumorphism!')),
)
```

</details>

## Tap behaviour

The `TapMode` options available to `NeuContainer` and `NeuButton` are:

| Mode | Effect |
| --- | --- |
| `TapMode.none` | Tapping does not change the elevation state |
| `TapMode.static` | Each tap toggles the pressed state |
| `TapMode.dynamic` | Brief pressed-state animation, then release |
| `TapMode.flat` | Remains in its flat/pressed state |

Note: the `NeuButton.onPressed` callback receives the widget's internal toggled boolean, **not** a continuous pointer-down/pointer-up event.

## Interactive widget laboratory

The [new Flutter Web gallery](example/lib/gallery.dart) is an interactive demonstration of the real package widgets. Pick a component, adjust light/dark surfaces or accent colours, and copy the matching Dart snippet. The original [tabbed example application](example/lib/example.dart) is also preserved.

Run the interactive gallery locally with a Flutter environment:

```sh
cd example
flutter pub get
flutter run -d chrome -t lib/gallery.dart
```

Or produce the web build:

```sh
cd example
flutter build web --release --target lib/gallery.dart --base-href /neumorphic_widgets/
```

The [gallery GitHub Actions workflow](.github/workflows/gallery.yml) builds the web output for pull requests and saves it as a downloadable artifact. Publishing it to GitHub Pages is a **separate deployment step**; the gallery is not yet hosted publicly.

### More ways to learn

- Expand the widget snippets above for compact Markdown examples.
- Open the [API reference](https://pub.dev/documentation/neumorphism_widgets/latest/) for constructor parameters.
- Try the real [interactive gallery source](example/lib/gallery.dart) to see state changes and generated code.

## Contributing

Issues, improvements, accessibility feedback, and pull requests are welcome. Please use the [issue tracker](https://github.com/diablez/neumorphic_widgets/issues) for bug reports and feature requests.

## SETO · Support development

Neumorphic Widgets is developed under **SETO**, an identity for engineering, robotics, and software projects. If the library has been useful, you can [buy SETO a coffee](https://buymeacoffee.com/SETO) to support future work.

Support is optional; the package remains open source under the MIT License. The [SETO visual identity guide](docs/SETO_BRANDING.md) documents the project's brand colours, typography, and graphic principles.

## License

This project is available under the [MIT License](LICENSE).
