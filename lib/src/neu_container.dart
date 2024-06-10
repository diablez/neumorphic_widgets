import 'dart:async';
import 'package:flutter/material.dart';

enum TapMode {
  none,
  static,
  dynamic,
  flat,
}

Color darkenColor(Color color, double shadeFactor) {
  return Color.fromRGBO(
    (color.red * (1 - shadeFactor)).round(),
    (color.green * (1 - shadeFactor)).round(),
    (color.blue * (1 - shadeFactor)).round(),
    color.opacity,
  );
}

Color lightenColor(Color color, double tintFactor) {
  return Color.fromRGBO(
    (color.red + (255 - color.red) * tintFactor).round(),
    (color.green + (255 - color.green) * tintFactor).round(),
    (color.blue + (255 - color.blue) * tintFactor).round(),
    color.opacity,
  );
}

class NeuContainer extends StatefulWidget {
  final void Function()? onPressed; //adds a on pressed event for container
  final Widget? child; //adds a child widget for container
  final bool inset; //changes container inset
  final double radius; //controls container radius
  final TapMode tapMode; //controls on pressed animation
  final bool onStart; //wether to go from flat to state on start
  final EdgeInsets padding; //adds padding to container
  final Color? color; //addition of color to container
  final BoxShape shape; //controls shape of container
  final Gradient? gradient; //adds gradient to container
  final Color boxShadowColor; //controls color of shadow and container
  final bool? enabled; //controls if container is enabled
  const NeuContainer(
      {super.key,
      this.onPressed,
      this.child,
      this.color,
      this.gradient,
      this.radius = 20,
      this.inset = false,
      this.tapMode = TapMode.none,
      this.padding = const EdgeInsets.all(8),
      this.shape = BoxShape.rectangle,
      required this.boxShadowColor,
      this.enabled,
      this.onStart = false});

  @override
  State<NeuContainer> createState() => _NeuContainerState();
}

class _NeuContainerState extends State<NeuContainer> {
  bool isTap = false;
  Timer? _tapTimer; // Declare a Timer for the tap
  @override
  void initState() {
    super.initState();
    if (widget.tapMode == TapMode.flat) {
      isTap = true;
    }
  }

  @override
  void didUpdateWidget(NeuContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tapMode != widget.tapMode) {
      _updateTapState();
    }
  }

  @override
  void dispose() {
    _tapTimer?.cancel(); // Cancel the tap timer when disposing the widget
    super.dispose();
  }

  void _updateTapState() {
    if (widget.onStart) {
      isTap = true;
      _tapTimer = Timer(const Duration(seconds: 1), () {
        if (mounted) {
          // Check if the widget is still in the tree
          setState(() {
            isTap = false;
          });
        }
      });
    } else if (widget.enabled == true) {
      isTap = true;
      _tapTimer = Timer(const Duration(seconds: 0), () {
        if (mounted) {
          // Check if the widget is still in the tree
          setState(() {
            isTap = false;
          });
        }
      });
    } else if (widget.tapMode == TapMode.flat) {
      if (mounted) {
        // Check if the widget is still in the tree
        setState(() {
          isTap = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (widget.tapMode) {
          case TapMode.none:
            break;
          case TapMode.static:
            setState(() {
              isTap = !isTap;
            });
            break;
          case TapMode.dynamic:
            setState(() {
              isTap = true;
            });
            _tapTimer?.cancel();
            _tapTimer = Timer(const Duration(milliseconds: 200), () {
              if (mounted) {
                setState(() {
                  isTap = false;
                });
              }
            });
            break;
          case TapMode.flat:
            setState(() {
              isTap = true;
            });
            break;
        }
        widget.onPressed?.call();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
            color: widget.color ?? widget.boxShadowColor,
            gradient: widget.gradient,
            borderRadius: widget.shape == BoxShape.circle
                ? null
                : BorderRadius.circular(widget.radius),
            border: Border.all(
              color: !isTap
                  ? lightenColor(widget.boxShadowColor, 0.17)
                  : darkenColor(widget.boxShadowColor, 0.1),
              width: 1,
            ),
            shape: widget.shape,
            boxShadow: isTap
                ? []
                : (!widget.inset
                    ? [
                        BoxShadow(
                          color: darkenColor(widget.boxShadowColor, 0.3),
                          offset: const Offset(5, 5),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: lightenColor(widget.boxShadowColor, 0.25),
                          offset: const Offset(-5, -5),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: darkenColor(widget.boxShadowColor, 0.3),
                          offset: const Offset(-5, -5),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: lightenColor(widget.boxShadowColor, 0.25),
                          offset: const Offset(5, 5),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ])),
        child: Padding(
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}
