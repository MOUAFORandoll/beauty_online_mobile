import 'package:flutter/material.dart';
import 'package:beauty/utils/svg_utils.dart';
import 'package:beauty/utils/themes.dart';

class ActionWidget extends StatelessWidget {
  final String title;
  final String? icon;
  final WidgetBuilder? iconBuilder;
  final VoidCallback onTap;

  const ActionWidget(
      {super.key,
      required this.title,
      this.icon,
      this.iconBuilder,
      required this.onTap})
      : assert(icon != null || iconBuilder != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: switch (Theme.of(context).brightness) {
              Brightness.light => AppTheme.lightGrey,
              Brightness.dark =>
                Theme.of(context).colorScheme.surfaceContainerHighest,
            },
            child: iconBuilder?.call(context) ??
                toSvgIcon(
                    icon: icon!,
                    color: switch (Theme.of(context).brightness) {
                      Brightness.light => Colors.black,
                      Brightness.dark =>
                        Theme.of(context).colorScheme.onSurfaceVariant,
                    }),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
