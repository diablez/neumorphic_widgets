# Neumorphic Widgets

[![Pub Version](https://img.shields.io/pub/v/neumorphism_widgets)](https://pub.dev/packages/neumorphism_widgets)
[![Pub Likes](https://img.shields.io/pub/likes/neumorphism_widgets)](https://pub.dev/packages/neumorphism_widgets)
[![Pub Points](https://img.shields.io/pub/points/neumorphism_widgets)](https://pub.dev/packages/neumorphism_widgets/score)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A collection of reusable **neumorphic widgets for Flutter**, featuring customisable surfaces, shadows, colours, shapes and interactive controls.

Neumorphism combines soft highlights and shadows to give user interface elements a tactile, raised or recessed appearance.

Build interfaces with buttons, containers, switches, sliders, checkboxes and app bars that share a consistent design language.

**[pub.dev](https://pub.dev/packages/neumorphism_widgets) · [API Documentation](https://pub.dev/documentation/neumorphism_widgets/latest/) · [GitHub Repository](https://github.com/diablez/neumorphic_widgets) · [Example Application](https://github.com/diablez/neumorphic_widgets/tree/main/example)**

---

## Features

| Widget | Description |
|---|---|
| `NeuContainer` | Customisable surfaces with configurable shadows, shapes, padding and tap animations |
| `NeuButton` | Interactive buttons with multiple tap behaviours |
| `NeuSwitch` | Horizontal or vertical animated switches |
| `NeuSlider` | Horizontal or vertical sliders with customisable colours and dimensions |
| `NeuCheckbox` | Toggleable checkboxes with customisable appearance |
| `NeuAppBar` | An app bar with neumorphic styling |

### Customisation

- Light and dark neumorphic surfaces
- Raised and inset visual effects
- Custom background and shadow colours
- Rounded rectangular and circular shapes
- Optional gradients
- Configurable padding and corner radius
- Animated tap interactions
- Horizontal and vertical controls
- Enabled and disabled states

---

## Widget Gallery

### App Bar

A custom app bar using a neumorphic container.

![NeuAppBar preview](https://raw.githubusercontent.com/diablez/neumorphic_widgets/main/assets/appbar.png)

### Buttons and Checkboxes

Interactive controls with customisable visual states.

![NeuButton and NeuCheckbox preview](https://raw.githubusercontent.com/diablez/neumorphic_widgets/main/assets/buttons.png)

### Containers

Raised and inset surfaces for building custom layouts.

![NeuContainer preview](https://raw.githubusercontent.com/diablez/neumorphic_widgets/main/assets/containers.png)

### Sliders

Customisable slider controls with horizontal and vertical orientations.

![NeuSlider preview](https://raw.githubusercontent.com/diablez/neumorphic_widgets/main/assets/sliders.png)

### Switches

Animated toggle switches with custom colours.

![NeuSwitch preview](https://raw.githubusercontent.com/diablez/neumorphic_widgets/main/assets/switches.png)

---

## Installation

Add the package to your Flutter project:

```bash
flutter pub add neumorphism_widgets
```

Alternatively, add it manually to `pubspec.yaml`:

```yaml
dependencies:
  neumorphism_widgets: ^0.0.8
```

Import the widget library:

```dart
import 'package:neumorphism_widgets/neumorphism_widgets.dart';
```

The examples below also use Flutter's Material library:

```dart
import 'package:flutter/material.dart';
```

---

## Usage

### NeuButton

A button with configurable tap animation and appearance.

```dart
NeuButton(
  boxShadowColor: Colors.grey.shade200,
  tapMode: TapMode.dynamic,
  enabled: true,
  onPressed: (isPressed) {
    debugPrint('Button state: $isPressed');
  },
  child: const Text('Press me'),
)
```

### NeuContainer

A reusable neumorphic surface supporting custom content, shape, padding, colour and tap behaviour.

```dart
NeuContainer(
  boxShadowColor: Colors.grey.shade200,
  radius: 16,
  padding: const EdgeInsets.all(20),
  shape: BoxShape.rectangle,
  tapMode: TapMode.dynamic,
  onPressed: () {
    debugPrint('Container tapped');
  },
  child: const Text('Neumorphic surface'),
)
```

To create an inset-style container, set `inset: true`.

### NeuSwitch

An animated switch with customisable colours and orientation.

```dart
NeuSwitch(
  boxShadowColor: Colors.grey.shade200,
  activeColor: Colors.green,
  value: false,
  enabled: true,
  onChanged: (value) {
    debugPrint('Switch: $value');
  },
)
```

Set `vertical: true` to change the switch orientation.

### NeuSlider

A slider with configurable dimensions, orientation and colours.

```dart
NeuSlider(
  boxShadowColor: Colors.grey.shade200,
  color: Colors.green,
  value: 50,
  enabled: true,
  length: 200,
  width: 30,
  onChanged: (value) {
    debugPrint('Slider: $value');
  },
)
```

Set `vertical: true` to use a vertical slider.

The slider reports values between `0` and `100`.

### NeuCheckbox

A customisable checkbox with its own internal checked state.

```dart
NeuCheckbox(
  boxShadowColor: Colors.grey.shade200,
  isChecked: false,
  activeColor: Colors.green,
  enable: true,
)
```

**Note:** In version `0.0.8`, `NeuCheckbox` uses the argument `enable`, rather than `enabled`, and doesn't expose an `onChanged` callback.

### NeuAppBar

A neumorphic app bar supporting leading widgets, titles, actions and an optional bottom widget.

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
        onPressed: () {
          debugPrint('Search pressed');
        },
      ),
    ],
  ),
  body: const Center(
    child: Text('Hello, neumorphism!'),
  ),
)
```

---

## Tap Modes

`NeuContainer` and `NeuButton` support several interaction modes:

| Mode | Behaviour |
|---|---|
| `TapMode.none` | No animated pressed state |
| `TapMode.static` | Toggles the pressed state with each tap |
| `TapMode.dynamic` | Briefly activates the pressed state, then releases |
| `TapMode.flat` | Switches to and remains in the flat state |

Use `tapMode` to select the interaction behaviour appropriate for your UI.

---

## Example Application

An example Flutter application is included in the [`example`](https://github.com/diablez/neumorphic_widgets/tree/main/example) directory.

It demonstrates the included widgets and different configuration options.

To run the example locally with Flutter installed:

```bash
cd example
flutter pub get
flutter run
```

---

## Documentation and Resources

- [Published package on pub.dev](https://pub.dev/packages/neumorphism_widgets)
- [API reference](https://pub.dev/documentation/neumorphism_widgets/latest/)
- [Source code](https://github.com/diablez/neumorphic_widgets)
- [Example application](https://github.com/diablez/neumorphic_widgets/tree/main/example)
- [Report an issue](https://github.com/diablez/neumorphic_widgets/issues)

## Contributing

Bug reports, suggestions and contributions are welcome.

If you encounter an issue, please open a GitHub issue with a description and a reproducible example.

## License

Distributed under the [MIT License](LICENSE).
