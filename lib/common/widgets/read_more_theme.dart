import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ReadMoreThemeData {
  final TextStyle? style;
  final TextStyle? lessStyle;
  final TextStyle? moreStyle;
  final TrimMode? trimMode;
  final int? trimLines;
  final String? trimCollapsedText;
  final String? trimExpandedText;
  final TextAlign? textAlign;

  const ReadMoreThemeData({
    this.style,
    this.lessStyle,
    this.moreStyle,
    this.trimMode,
    this.trimLines,
    this.trimCollapsedText,
    this.trimExpandedText,
    this.textAlign = TextAlign.center,
  });
}

class ReadMoreTheme extends InheritedWidget {
  final ReadMoreThemeData themeData;

  const ReadMoreTheme({
    super.key,
    required this.themeData,
    required super.child,
  });

  static ReadMoreTheme of(BuildContext context) {
    final ReadMoreTheme? result =
        context.dependOnInheritedWidgetOfExactType<ReadMoreTheme>();
    assert(result != null, 'No ReadMoreTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ReadMoreTheme old) {
    return false;
  }
}

class ThemedReadMoreText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextStyle? lessStyle;
  final TextStyle? moreStyle;
  final TextAlign? textAlign;
  final TrimMode trimMode;
  final int trimLines;
  final String trimCollapsedText;
  final String trimExpandedText;
  final ValueNotifier<bool>? isCollapsed;

  const ThemedReadMoreText(this.data,
      {super.key,
      this.isCollapsed,
      this.style,
      this.lessStyle,
      this.moreStyle,
      this.trimMode = TrimMode.Line,
      this.textAlign = TextAlign.left,
      this.trimLines = 2,
      this.trimCollapsedText = '',
      this.trimExpandedText = ''});

  @override
  Widget build(BuildContext context) {
    final theme = ReadMoreTheme.of(context).themeData;
    return ReadMoreText(
      data,
      isCollapsed: isCollapsed,
      style: theme.style ?? style,
      trimCollapsedText: theme.trimCollapsedText ?? trimCollapsedText,
      trimExpandedText: theme.trimExpandedText ?? trimExpandedText,
      lessStyle: theme.lessStyle ?? lessStyle,
      moreStyle: theme.moreStyle ?? moreStyle,
      trimMode: theme.trimMode ?? trimMode,
      trimLines: theme.trimLines ?? trimLines,
      textAlign: textAlign,
    );
  }
}
