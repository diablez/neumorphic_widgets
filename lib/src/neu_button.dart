import 'package:flutter/material.dart';
import 'package:neumorphism_widgets/neumorphism_widgets.dart';

class NeuButton extends StatefulWidget {
  final Color boxShadowColor;
  final Function(bool)? onPressed;
  final Widget? child;
  final bool onStart;
  final Color? color;
  final TapMode tapMode;
  final bool enabled;
  const NeuButton({
    super.key,
    required this.boxShadowColor,
    required this.onPressed,
    required this.child,
    this.onStart = false,
    this.color,
    this.enabled = true,
    this.tapMode = TapMode.dynamic,
  });

  @override
  State<NeuButton> createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton> {
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return NeuContainer(
      tapMode: widget.enabled == true ? widget.tapMode : TapMode.flat,
      enabled: widget.enabled,
      color: widget.color,
      onStart: widget.onStart,
      boxShadowColor: widget.boxShadowColor,
      onPressed: widget.enabled == true
          ? () {
              // Check if the button is enabled
              isTap = !isTap;
              if (widget.onPressed != null) {
                widget.onPressed!(isTap);
              }
            }
          : null,
      child: widget.child,
    );
  }
}
