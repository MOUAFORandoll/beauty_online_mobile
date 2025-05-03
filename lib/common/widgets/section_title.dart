import 'package:beauty/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelLarge),
        Container(
          child: Row(
            children: [
              Text('see all', style: Theme.of(context).textTheme.labelLarge),
              Icon(Icons.keyboard_arrow_right, color: AppTheme.primaryYellow)
            ],
          ),
        )
      ],
    );
  }
}
