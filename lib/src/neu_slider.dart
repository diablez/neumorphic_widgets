import 'package:flutter/material.dart';
import 'package:neumorphics/neumorphics.dart';

class NeuSlider extends StatefulWidget {
  final ValueChanged<double> onChanged;
  final bool vertical;
  final double value;
  final dynamic color;
  final bool withOpacity;
  final Gradient? gradient;
  final dynamic handleColor;
  final bool onStart;
  final Color boxShadowColor;
  final bool enabled;
  final double length;
  final double width;
  const NeuSlider(
      {super.key,
      required this.boxShadowColor,
      required this.onChanged,
      this.vertical = false,
      this.value = 0,
      this.color = const Color.fromRGBO(77, 255, 82, 1),
      this.withOpacity = true,
      this.gradient,
      this.handleColor,
      this.length = 150,
      this.width = 25,
      this.enabled = true,
      this.onStart = false});

  @override
  State<NeuSlider> createState() => _NeuSliderState();
}

class _NeuSliderState extends State<NeuSlider> {
  late double _currentSliderValue;

  @override
  void initState() {
    super.initState();
    _currentSliderValue = widget.value; // Add this line
  }

  @override
  Widget build(BuildContext context) {
    double width = widget.length;
    double height = widget.width;
    double size = height;
    double upperlimit = width - height;
    if (widget.vertical) {
      width = widget.width;
      height = widget.length;
      size = width;
      upperlimit = height - width;
    }
    double offset = widget.width / 7.5;
    return SizedBox(
      width: width,
      height: height,
      child: NeuContainer(
        tapMode: widget.enabled == true ? TapMode.none : TapMode.flat,
        enabled: widget.enabled,
        boxShadowColor: widget.boxShadowColor,
        onStart: widget.onStart,
        color: widget.color.withOpacity(widget.withOpacity
            ? ((_currentSliderValue.clamp(0, 100) / 100) - 0.4).clamp(0.0, 1.0)
            : 1.0),
        inset: true,
        padding: const EdgeInsets.all(0),
        shape: BoxShape.rectangle,
        gradient: widget.gradient,
        radius: widget.width / 2,
        child: GestureDetector(
          // Add this
          behavior: HitTestBehavior.translucent,
          onTapDown: (TapDownDetails details) {
            RenderBox box = context.findRenderObject() as RenderBox;
            Offset localOffset = box.globalToLocal(details.globalPosition);
            if (widget.enabled) {
              setState(() {
                if (widget.vertical) {
                  _currentSliderValue =
                      (1 - localOffset.dy / box.size.height) * 100;
                } else {
                  _currentSliderValue = (localOffset.dx / box.size.width) * 100;
                }
                _currentSliderValue = _currentSliderValue.clamp(0.0, 100.0);
              });
            }
            widget.onChanged(_currentSliderValue);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Handle
              Positioned(
                left: widget.vertical
                    ? -size / offset
                    : (_currentSliderValue / 100) * upperlimit - size / offset,
                bottom: widget.vertical
                    ? (_currentSliderValue / 100) * upperlimit - size / offset
                    : -size / offset,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onPanUpdate: (details) {
                    if (widget.enabled) {
                      setState(() {
                        if (widget.vertical) {
                          if (upperlimit != 0) {
                            _currentSliderValue -=
                                details.delta.dy / upperlimit * 100;
                          }
                        } else {
                          if (upperlimit != 0) {
                            _currentSliderValue +=
                                details.delta.dx / upperlimit * 100;
                          }
                        }
                        _currentSliderValue =
                            _currentSliderValue.clamp(0.0, 100.0);
                      });
                    }
                    widget.onChanged(_currentSliderValue);
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: widget.width - 3,
                        height: widget.width - 3,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: widget.enabled
                                ? lightenColor(widget.boxShadowColor, 0.17)
                                : darkenColor(widget.boxShadowColor, 0.1),
                          ),
                          shape: BoxShape.circle,
                          gradient: widget.enabled
                              ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    lightenColor(
                                        widget.handleColor ??
                                            widget.boxShadowColor,
                                        0.17),
                                    darkenColor(
                                        widget.handleColor ??
                                            widget.boxShadowColor,
                                        0.1)
                                  ],
                                )
                              : null,
                          color: widget.enabled ? null : widget.boxShadowColor,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
