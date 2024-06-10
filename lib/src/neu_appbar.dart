import 'package:flutter/material.dart';
import 'package:neumorphism_widgets/src/neu_container.dart';

class NeuAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Color boxShadowColor;
  final Widget title;
  final ValueNotifier<bool>? isScrolled;
  final Widget? leading;
  final bool centerTitle;
  final Color? color;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  const NeuAppBar(
      {super.key,
      this.isScrolled,
      this.bottom,
      this.toolbarTextStyle,
      this.titleTextStyle,
      required this.boxShadowColor,
      required this.title,
      this.leading,
      this.centerTitle = false,
      this.color,
      this.actions});

  @override
  State<NeuAppBar> createState() => _NeuAppBarState();

  @override
  Size get preferredSize => bottom != null
      ? const Size.fromHeight(kToolbarHeight * 2)
      : const Size.fromHeight(kToolbarHeight);
}

class _NeuAppBarState extends State<NeuAppBar> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isScrolled =
        widget.isScrolled ?? ValueNotifier<bool>(false);

    return ValueListenableBuilder<bool>(
      valueListenable: isScrolled,
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: NeuContainer(
            key: UniqueKey(),
            tapMode: value ? TapMode.flat : TapMode.none,
            padding: const EdgeInsets.all(0),
            color: widget.color,
            boxShadowColor: widget.boxShadowColor,
            child: AppBar(
              toolbarTextStyle: widget.toolbarTextStyle,
              titleTextStyle: widget.titleTextStyle,
              bottom: widget.bottom,
              actions: [...widget.actions ?? []],
              centerTitle: widget.centerTitle,
              leading: widget.leading,
              backgroundColor: Colors.transparent,
              title: widget.title,
            ),
          ),
        );
      },
    );
  }
}
