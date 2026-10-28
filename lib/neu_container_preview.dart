import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:neumorphism_widgets/src/core/neu_decoration.dart';
import 'package:neumorphism_widgets/src/core/neu_container.dart';

const surfaceColor = Color.fromARGB(255, 179, 156, 216);

@Preview(
  name: 'SETO | Shadow Laboratory',
  group: 'SETO / Foundation',
  size: Size(420, 620),
)
Widget neuContainerPreview() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: surfaceColor,
      body: ShadowLab(),
    ),
  );
}

class ShadowLab extends StatefulWidget {
  const ShadowLab({super.key});

  @override
  State<ShadowLab> createState() => _ShadowLabState();
}

class _ShadowLabState extends State<ShadowLab> {
  double depth = 8.2;
  double softness = 1.9;
  double spread = 0.8;
  double contrast = 0.2;
  bool inset = false;

  @override
  Widget build(BuildContext context) {
    final blur = depth * softness;
    final maxSpread = math.max(-depth, depth - blur * 0.5);
    final actualSpread = spread.clamp(-depth, maxSpread);

    return Padding(
      // Your existing code continues here...
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'SETO Shadow Laboratory',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: SizedBox(
                  width: 150,
                  height: 160,
                  child: NeuContainer(
                    color: surfaceColor,
                    inset: inset,
                    depth: depth,
                    softness: softness,
                    spread: spread,
                    contrast: contrast,
                    child: const Text(
                      'SETO',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SwitchListTile(
            title: const Text(
              'Inset',
              style: TextStyle(color: Colors.white),
            ),
            value: inset,
            onChanged: (value) {
              setState(() => inset = value);
            },
          ),
          _slider(
            'Depth',
            depth,
            0,
            30,
            (value) => setState(() => depth = value),
          ),
          _slider(
            'Softness',
            softness,
            0,
            5,
            (value) => setState(() => softness = value),
          ),
          _slider(
            'Spread',
            spread,
            -10,
            20,
            (value) => setState(() => spread = value),
          ),
          Text(
            'Blur: ${blur.toStringAsFixed(1)}  '
            'Applied spread: ${actualSpread.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
          _slider(
            'Contrast',
            contrast,
            0,
            1,
            (value) => setState(() => contrast = value),
          ),
          Text(
            'Contrast: ${contrast.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              setState(() {
                inset = false;
                depth = 8.2;
                softness = 1.9;
                spread = 0.8;
                contrast = 0.2;
              });
            },
            child: const Text(
              'Reset shadows',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _slider(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              value.toStringAsFixed(1),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
