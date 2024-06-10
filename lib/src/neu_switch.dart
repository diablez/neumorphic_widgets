import 'package:flutter/material.dart';
import 'package:neumorphism_widgets/neumorphism_widgets.dart';

class NeuSwitch extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool value;
  final bool onStart;
  final Color boxShadowColor;
  final bool enabled;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool vertical;
  const NeuSwitch(
      {super.key,
      this.activeColor = const Color.fromRGBO(77, 255, 82, 1),
      this.inactiveColor,
      this.vertical = false,
      required this.onChanged,
      required this.value,
      required this.boxShadowColor,
      this.enabled = true,
      this.onStart = false});

  @override
  State<NeuSwitch> createState() => _NeuSwitchState();
}

class _NeuSwitchState extends State<NeuSwitch>
    with SingleTickerProviderStateMixin {
  late bool isSwitched;
  double butsize = 20.0;

  void handleDragUpdate(DragUpdateDetails details) {
    if (widget.enabled) {
      if (details.delta.dx > 0 || details.delta.dy > 0) {
        if (!isSwitched) {
          toggleSwitch(true);
          widget.onChanged(isSwitched);
        }
      } else if (details.delta.dx < 0 || details.delta.dy < 0) {
        if (isSwitched) {
          toggleSwitch(false);
          widget.onChanged(isSwitched);
        }
      }
    }
  }

  void handleDragEnd() {
    if (widget.enabled) {
      setState(() {
        butsize = isSwitched
            ? 30.0
            : 20.0; // Reset the size of the button when it's released
      });
    }
  }

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
        boxShadowColor: widget.boxShadowColor,
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
          width: widget.vertical ? 30 : size,
          height: widget.vertical ? size : 30,
          child: AnimatedAlign(
            alignment: widget.vertical
                ? isSwitched
                    ? Alignment.topCenter
                    : Alignment.bottomCenter
                : isSwitched
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: Padding(
              padding: widget.vertical
                  ? const EdgeInsets.only(bottom: 5)
                  : const EdgeInsets.only(left: 5.0),
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
                  handleDragUpdate(details);
                },
                onPanEnd: (details) {
                  handleDragEnd();
                },
                onVerticalDragUpdate: (details) {
                  handleDragUpdate(details);
                },
                onVerticalDragEnd: (details) {
                  handleDragEnd();
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
                    boxShadowColor: widget.boxShadowColor,
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
                        : widget.inactiveColor?.withOpacity(0.6),
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
