import 'package:flutter/material.dart';
import 'package:neumorphic_widgets/src/neu_container.dart';

class NeuCheckbox extends StatefulWidget {
  final Color boxShadowColor;
  final BoxShape shape;
  final bool isChecked;
  final Color? activeColor;
  final bool enable;
  final TapMode tapMode;
  const NeuCheckbox(
      {super.key,
      this.tapMode = TapMode.dynamic,
      required this.boxShadowColor,
      this.isChecked = false,
      this.shape = BoxShape.rectangle,
      this.activeColor = const Color.fromARGB(255, 118, 255, 3),
      this.enable = true});

  @override
  State<NeuCheckbox> createState() => _NeuCheckboxState();
}

class _NeuCheckboxState extends State<NeuCheckbox> {
  late bool checked;

  @override
  void initState() {
    super.initState();
    checked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return NeuContainer(
        enabled: widget.enable,
        padding: const EdgeInsets.all(3),
        tapMode: widget.enable ? widget.tapMode : TapMode.flat,
        color: checked ? widget.activeColor?.withOpacity(0.6) : null,
        boxShadowColor: widget.boxShadowColor,
        shape: widget.shape,
        onPressed: () {
          if (widget.enable) {
            setState(() {
              checked = !checked;
            });
          }
        },
        child: !checked
            ? Icon(
                Icons.radio_button_unchecked,
                color: darkenColor(widget.boxShadowColor, 0.25),
              )
            : Icon(Icons.close,
                color: lightenColor(
                    widget.activeColor ?? Colors.transparent, 0.5)));
  }
}
