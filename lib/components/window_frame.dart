import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:localbooru/utils/platform_tools.dart';

class WindowFrameAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final AppBar appBar;
  final String title;
  final Color? backgroundColor;

  const WindowFrameAppBar({super.key, this.height = 32.0, required this.appBar, this.title = "LocalBooru", this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    if (!isDestkop()) return appBar;
    return Column(
        children: [
            WindowTitleBarBox(
                child: Container(
                    color: backgroundColor,
                    child: Row(
                        children: [
                            Expanded(
                                child: MoveWindow(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6.00, horizontal: 16.00),
                                        child: Text(title)
                                    ),
                                )
                            ),
                            const WindowButtons()
                        ],
                    ),
                )
            ),
            appBar,
        ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height + (isDestkop() ? height : 0));
}

class WindowButtons extends StatelessWidget {
    const WindowButtons({super.key});

    @override
    Widget build(BuildContext context) {
        final buttonColors = WindowButtonColors(
            iconNormal: Theme.of(context).colorScheme.inverseSurface,
            mouseOver: Theme.of(context).colorScheme.primary,
            mouseDown: Theme.of(context).colorScheme.primaryContainer,
            iconMouseOver: Theme.of(context).colorScheme.onPrimary,
            iconMouseDown: Theme.of(context).colorScheme.onPrimaryContainer
        );
        final closeButtonColors = WindowButtonColors(
            iconNormal: Theme.of(context).colorScheme.inverseSurface,
            mouseOver: Theme.of(context).colorScheme.error,
            mouseDown: Theme.of(context).colorScheme.errorContainer,
            iconMouseOver: Theme.of(context).colorScheme.onError,
            iconMouseDown: Theme.of(context).colorScheme.onErrorContainer
        );
        return Wrap(
            children: [
                MinimizeWindowButton(colors: buttonColors),
                MaximizeWindowButton(colors: buttonColors),
                CloseWindowButton(colors: closeButtonColors)
            ],
        );
    }
}