import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';

RichText parseTextWithWidgets(BuildContext context, String inputText,
    [bool isResponse = false]) {
  final spans = <InlineSpan>[];

  final regex = RegExp(r'@(\w+)\((\{.*?\})\)', dotAll: true);
  int lastMatchEnd = 0;

  final matches = regex.allMatches(inputText);

  for (final match in matches) {
    if (match.start > lastMatchEnd) {
      spans.add(isResponse
          ? TextSpan(
              text: inputText.substring(lastMatchEnd, match.start),
              style: Theme.of(context).textTheme.bodyMedium)
          : TextSpan(
              text: inputText.substring(lastMatchEnd, match.start),
            ));
    }

    final type = match.group(1);
    final jsonString = match.group(2);

    try {
      final data = json.decode(jsonString!);
      final name = data['name'] ?? 'Inconnu';

      var icon = Assets.iconsbeauty;

      switch (type) {
        case 'catalogue':
          icon = Assets.iconsTrending;

          break;
        case 'quiz':
          icon = Assets.iconsQuiz;
          break;
        case 'user':
        default:
          icon = Assets.iconsFollow;
          break;
      }

      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                toSvgIcon(
                    icon: icon,
                    size: 16.0,
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(name,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      // Si parsing échoue, on garde le texte brut
      spans.add(TextSpan(
        text: match.group(0),
        style: const TextStyle(color: Colors.red),
      ));
    }

    lastMatchEnd = match.end;
  }

  // Texte restant après le dernier tag
  if (lastMatchEnd < inputText.length) {
    spans.add(TextSpan(
      text: inputText.substring(lastMatchEnd),
      style: const TextStyle(color: Colors.black),
    ));
  }

  return RichText(text: TextSpan(children: spans));
}
