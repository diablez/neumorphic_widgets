import 'package:flutter/material.dart';
import 'package:neumorphic_widgets/neumorphic_widgets.dart';

class NeuSwitch extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool value;
  final bool onStart;
  final Color boxShadow;
  final bool enabled;
  final Color? activeColor;
  const NeuSwitch(
      {super.key,
      this.activeColor = const Color.fromRGBO(77, 255, 82, 1),
      required this.onChanged,
      required this.value,
      required this.boxShadow,
      this.enabled = true,
      this.onStart = false});

  @override
  State<NeuSwitch> createState() => _NeuSwitchState();
}

class _NeuSwitchState extends State<NeuSwitch>
    with SingleTickerProviderStateMixin {
  late bool isSwitched;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.value; // Add this line
  }

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = !isSwitched;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double size = 50;
    double butsize = isSwitched ? 30.0 : 20.0;
    return GestureDetector(
      onPanDown: (details) {
        if (widget.enabled) {
          setState(() {
            butsize =
                30.0; // Increase the size of the button when it's held down
          });
        }
      },
      onPanUpdate: (details) {
        if (widget.enabled) {
          if (details.delta.dx > 0) {
            if (!isSwitched) {
              toggleSwitch(true);
              widget.onChanged(isSwitched);
            }
          } else if (details.delta.dx < 0) {
            if (isSwitched) {
              toggleSwitch(false);
              widget.onChanged(isSwitched);
            }
          }
        }
      },
      child: NeuContainer(
        tapMode: widget.enabled == true ? TapMode.none : TapMode.flat,
        enabled: widget.enabled,
        boxShadowColor: widget.boxShadow,
        onPressed: () {
          if (widget.enabled) {
            toggleSwitch(!isSwitched);
            widget.onChanged(isSwitched);
          }
        },
        onStart: widget.onStart,
        shape: BoxShape.rectangle,
        inset: true,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          width: size,
          height: 30,
          child: AnimatedAlign(
            alignment:
                isSwitched ? Alignment.centerRight : Alignment.centerLeft,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: GestureDetector(
                onPanDown: (details) {
                  if (widget.enabled) {
                    setState(() {
                      butsize =
                          30.0; // Increase the size of the button when it's held down
                    });
                  }
                },
                onPanUpdate: (details) {
                  if (widget.enabled) {
                    if (details.delta.dx > 0) {
                      if (!isSwitched) {
                        toggleSwitch(true);
                        widget.onChanged(isSwitched);
                      }
                    } else if (details.delta.dx < 0) {
                      if (isSwitched) {
                        toggleSwitch(false);
                        widget.onChanged(isSwitched);
                      }
                    }
                  }
                },
                onPanEnd: (details) {
                  if (widget.enabled) {
                    setState(() {
                      butsize = isSwitched
                          ? 30.0
                          : 20.0; // Reset the size of the button when it's released
                    });
                  }
                },
                child: AnimatedContainer(
                  width: butsize,
                  height: butsize,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  child: NeuContainer(
                    tapMode:
                        widget.enabled == true ? TapMode.dynamic : TapMode.flat,
                    enabled: widget.enabled,
                    boxShadowColor: widget.boxShadow,
                    onStart: widget.onStart,
                    shape: BoxShape.circle,
                    onPressed: () {
                      if (widget.enabled) {
                        toggleSwitch(!isSwitched);
                        widget.onChanged(isSwitched);
                      }
                    },
                    color: isSwitched
                        ? widget.activeColor?.withOpacity(0.6)
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
