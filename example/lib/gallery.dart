import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neumorphism_widgets/neumorphism_widgets.dart';

// Dedicated web gallery. The original example/lib/example.dart is preserved.
void main() => runApp(const WidgetLaboratory());

class WidgetLaboratory extends StatefulWidget {
  const WidgetLaboratory({super.key});
  @override
  State<WidgetLaboratory> createState() => _WidgetLaboratoryState();
}

class _WidgetLaboratoryState extends State<WidgetLaboratory> {
  static const names = ['Button', 'Container', 'Slider', 'Switch', 'Checkbox', 'App bar'];
  static const accents = [
    Color(0xFF8FB19D), Color(0xFFCBA6F7), Color(0xFF86B2CE), Color(0xFFD6A17E),
  ];
  static const accentNames = ['Sage', 'Mauve', 'Blue', 'Peach'];
  static const accentLiterals = [
    'const Color(0xFF8FB19D)', 'const Color(0xFFCBA6F7)',
    'const Color(0xFF86B2CE)', 'const Color(0xFFD6A17E)',
  ];
  bool dark = false;
  bool enabled = true;
  bool switchOn = false;
  bool buttonValue = false;
  double sliderValue = 52;
  double radius = 20;
  int selected = 0;
  int accentIndex = 0;
  TapMode tapMode = TapMode.dynamic;

  Color get background => dark ? const Color(0xFF20252A) : const Color(0xFFE8E9E2);
  Color get surface => dark ? const Color(0xFF2B3135) : const Color(0xFFE8E9E2);
  Color get ink => dark ? const Color(0xFFE5E9E8) : const Color(0xFF38443D);
  Color get muted => dark ? const Color(0xFF9BA9A2) : const Color(0xFF68786F);
  Color get accent => accents[accentIndex];
  String get baseDart => dark ? 'const Color(0xFF2B3135)' : 'const Color(0xFFE8E9E2)';
  String get accentDart => accentLiterals[accentIndex];

  String get snippet {
    final base = baseDart;
    final color = accentDart;
    switch (selected) {
      case 0:
        return '''NeuButton(
  boxShadowColor: $base,
  tapMode: TapMode.${tapMode.name},
  enabled: $enabled,
  onPressed: (pressed) => debugPrint('Pressed: \$pressed'),
  child: const Text('Press me'),
)''';
      case 1:
        return '''NeuContainer(
  boxShadowColor: $base,
  radius: ${radius.round()},
  padding: const EdgeInsets.all(24),
  child: const Text('Soft surface'),
)''';
      case 2:
        return '''NeuSlider(
  boxShadowColor: $base,
  color: $color,
  value: ${sliderValue.round()},
  enabled: $enabled,
  length: 230,
  width: 28,
  onChanged: (value) => debugPrint('\$value'),
)''';
      case 3:
        return '''NeuSwitch(
  boxShadowColor: $base,
  activeColor: $color,
  value: $switchOn,
  enabled: $enabled,
  onChanged: (on) => debugPrint('\$on'),
)''';
      case 4:
        return '''NeuCheckbox(
  boxShadowColor: $base,
  activeColor: $color,
  enable: $enabled,
)''';
      default:
        return '''NeuAppBar(
  boxShadowColor: $base,
  title: const Text('Neumorphic Widgets'),
  centerTitle: true,
)''';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neumorphic Widgets · Laboratory',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: dark ? Brightness.dark : Brightness.light,
        ),
        scaffoldBackgroundColor: background,
      ),
      home: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: LayoutBuilder(builder: (context, box) {
              final wide = box.maxWidth >= 850;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: wide ? 36 : 16, vertical: 28),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1150),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('NEUMORPHIC / LABORATORY',
                          style: TextStyle(color: muted, letterSpacing: 2.1,
                            fontWeight: FontWeight.w700, fontSize: 11)),
                        const SizedBox(height: 8),
                        Text('Make it feel real.',
                          style: TextStyle(color: ink, fontWeight: FontWeight.w700,
                            fontSize: 33)),
                        Text('Real Flutter widgets. Live controls. Copyable Dart.',
                          style: TextStyle(color: muted)),
                        const SizedBox(height: 26),
                        Wrap(spacing: 8, runSpacing: 8, children: [
                          for (var i = 0; i < names.length; i++)
                            ChoiceChip(
                              label: Text(names[i]),
                              selected: selected == i,
                              selectedColor: accent.withAlpha(90),
                              onSelected: (_) => setState(() => selected = i),
                            ),
                        ]),
                        const SizedBox(height: 22),
                        if (wide)
                          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Expanded(flex: 6, child: preview()),
                            const SizedBox(width: 22),
                            Expanded(flex: 4, child: controls()),
                          ])
                        else ...[preview(), const SizedBox(height: 22), controls()],
                        const SizedBox(height: 22),
                        codePanel(context),
                        const SizedBox(height: 18),
                        Text('Built using neumorphism_widgets v0.0.8. '
                          'The original example.dart remains available.',
                          style: TextStyle(color: muted, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  Widget preview() => panel(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      eyebrow('LIVE COMPONENT'),
      const SizedBox(height: 10),
      Text('Neu${names[selected].replaceAll(' ', '')}',
        style: TextStyle(color: ink, fontSize: 20, fontWeight: FontWeight.w700)),
      const SizedBox(height: 6),
      Text('Interact with the real widget below.',
        style: TextStyle(color: muted, fontSize: 13)),
      const SizedBox(height: 20),
      SizedBox(height: 190, width: double.infinity,
        child: Center(child: actualWidget())),
      const SizedBox(height: 8),
      Text(
        selected == 0 ? 'Button callback: $buttonValue' :
        selected == 2 ? 'Value: ${sliderValue.round()} / 100' :
        selected == 3 ? 'Switch: $switchOn' :
        selected == 4 ? 'Checkbox owns its state in v0.0.8.' :
        'Try changing the appearance.',
        style: TextStyle(color: muted, fontSize: 12),
      ),
    ]),
  );

  Widget actualWidget() {
    switch (selected) {
      case 0:
        return NeuButton(
          key: ValueKey('button-$dark-$accentIndex'),
          boxShadowColor: surface,
          tapMode: tapMode,
          enabled: enabled,
          onPressed: (pressed) => setState(() => buttonValue = pressed),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 13),
            child: Text('Press me'),
          ),
        );
      case 1:
        return NeuContainer(
          boxShadowColor: surface,
          radius: radius,
          padding: const EdgeInsets.all(24),
          child: const Text('Soft surface'),
        );
      case 2:
        return NeuSlider(
          key: ValueKey('slider-$dark-$accentIndex'),
          boxShadowColor: surface,
          color: accent,
          handleColor: surface,
          value: sliderValue,
          length: 230,
          width: 28,
          enabled: enabled,
          onChanged: (value) => setState(() => sliderValue = value),
        );
      case 3:
        return NeuSwitch(
          key: ValueKey('switch-$dark-$accentIndex'),
          boxShadowColor: surface,
          activeColor: accent,
          value: switchOn,
          enabled: enabled,
          onChanged: (value) => setState(() => switchOn = value),
        );
      case 4:
        return NeuCheckbox(
          key: ValueKey('checkbox-$dark-$accentIndex'),
          boxShadowColor: surface,
          activeColor: accent,
          enable: enabled,
        );
      default:
        return SizedBox(
          width: 320, height: 85,
          child: NeuAppBar(
            boxShadowColor: surface,
            title: const Text('Neumorphic Widgets'),
            centerTitle: true,
          ),
        );
    }
  }

  Widget controls() => panel(child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      eyebrow('CONTROLS'),
      const SizedBox(height: 12),
      SwitchListTile.adaptive(
        contentPadding: EdgeInsets.zero,
        title: const Text('Dark mode'),
        value: dark,
        onChanged: (value) => setState(() => dark = value),
      ),
      const Text('Accent'),
      const SizedBox(height: 10),
      Wrap(spacing: 7, runSpacing: 8, children: [
        for (var i = 0; i < accents.length; i++)
          ChoiceChip(
            label: Text(accentNames[i]),
            selected: accentIndex == i,
            selectedColor: accents[i].withAlpha(90),
            onSelected: (_) => setState(() => accentIndex = i),
          ),
      ]),
      const SizedBox(height: 18),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('Corner radius'),
        Text('${radius.round()} px', style: TextStyle(color: muted)),
      ]),
      Slider(
        min: 6, max: 36, divisions: 15, value: radius,
        onChanged: (value) => setState(() => radius = value),
      ),
      SwitchListTile.adaptive(
        contentPadding: EdgeInsets.zero,
        title: const Text('Enable input'),
        value: enabled,
        onChanged: (value) => setState(() => enabled = value),
      ),
      const Text('Button tap behaviour'),
      const SizedBox(height: 8),
      DropdownButtonFormField<TapMode>(
        value: tapMode,
        decoration: const InputDecoration(
          border: OutlineInputBorder(), isDense: true),
        items: [
          for (final mode in TapMode.values)
            DropdownMenuItem(
              value: mode, child: Text('TapMode.${mode.name}')),
        ],
        onChanged: (mode) {
          if (mode != null) setState(() => tapMode = mode);
        },
      ),
      const SizedBox(height: 14),
      Text('The published checkbox owns its state; sliders and switches '
        'have their own interaction logic.',
        style: TextStyle(color: muted, fontSize: 12)),
    ],
  ));

  Widget codePanel(BuildContext context) => panel(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      eyebrow('COPY & CUSTOMISE'),
      const SizedBox(height: 9),
      Wrap(
        spacing: 12, runSpacing: 10,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('Your Dart configuration',
            style: TextStyle(color: ink, fontSize: 19,
              fontWeight: FontWeight.w600)),
          FilledButton.tonalIcon(
            icon: const Icon(Icons.copy),
            label: const Text('Copy Dart'),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: snippet));
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dart copied to clipboard')),
              );
            },
          ),
        ],
      ),
      const SizedBox(height: 14),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: dark ? const Color(0xFF171C20) :
            const Color(0xFFDCE1DA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: SelectableText(snippet,
          style: TextStyle(fontFamily: 'monospace', height: 1.6,
            fontSize: 12, color: ink)),
      ),
      const SizedBox(height: 7),
      Text('Add state handling and imports in your Flutter application.',
        style: TextStyle(fontSize: 12, color: muted)),
    ]),
  );

  Widget panel({required Widget child}) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: surface,
      borderRadius: BorderRadius.circular(26),
      border: Border.all(color: dark ?
        const Color(0xFF3B4244) : const Color(0xFFF5F7F2)),
      boxShadow: [
        BoxShadow(
          color: dark ? const Color(0x990A1012) :
            const Color(0x445D6A60),
          offset: const Offset(6, 8), blurRadius: 20),
        BoxShadow(
          color: dark ? const Color(0x174F6168) :
            const Color(0xD9FFFFFF),
          offset: const Offset(-5, -5), blurRadius: 16),
      ],
    ),
    child: child,
  );

  Widget eyebrow(String label) => Text(label,
    style: TextStyle(color: muted, letterSpacing: 1.8,
      fontSize: 10, fontWeight: FontWeight.w700));
}
