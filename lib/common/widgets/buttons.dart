import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:beauty/utils/themes.dart';

enum _ButtonStyle { primary, secondary, black, white }

class BeautyButton extends StatelessWidget {
  final _ButtonStyle _hierarchy;
  final VoidCallback? onPressed;
  final String text;
  final bool large;
  final Widget? icon;

  const BeautyButton.primary({
    super.key,
    required this.onPressed,
    required this.text,
    this.large = true,
    this.icon,
  }) : _hierarchy = _ButtonStyle.primary;

  const BeautyButton.secondary({
    super.key,
    required this.onPressed,
    required this.text,
    this.large = true,
    this.icon,
  }) : _hierarchy = _ButtonStyle.secondary;

  const BeautyButton.black({
    super.key,
    required this.onPressed,
    required this.text,
    this.large = true,
    this.icon,
  }) : _hierarchy = _ButtonStyle.black;

  const BeautyButton.white({
    super.key,
    required this.onPressed,
    required this.text,
    this.large = true,
    this.icon,
  }) : _hierarchy = _ButtonStyle.white;

  Color _backgroundColor(BuildContext context) {
    switch (_hierarchy) {
      case _ButtonStyle.primary:
        return Theme.of(context).colorScheme.primary;
      case _ButtonStyle.secondary:
        return Theme.of(context).colorScheme.tertiaryContainer;
      case _ButtonStyle.black:
        return AppTheme.black;
      case _ButtonStyle.white:
        return AppTheme.white;
    }
  }

  Color _foregroundColor(BuildContext context) {
    switch (_hierarchy) {
      case _ButtonStyle.primary:
        return AppTheme.black;
      case _ButtonStyle.secondary:
        return Theme.of(context).colorScheme.onTertiaryContainer;
      case _ButtonStyle.black:
        return AppTheme.white;
      case _ButtonStyle.white:
        return AppTheme.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AutoSizeText(
      text,
      maxLines: 1,
      minFontSize: 6,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: _backgroundColor(context),
        foregroundColor: _foregroundColor(context),
        minimumSize: large ? null : const Size(0, 40.0),
      ),
      child: icon == null
          ? t
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[icon!, const SizedBox(width: 8.0)],
                Expanded(child: t),
              ],
            ),
    );
  }
}
