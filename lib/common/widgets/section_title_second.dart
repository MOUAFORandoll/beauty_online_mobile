
import 'package:flutter/material.dart';

class SectionTitleSecond extends StatelessWidget {
  final String title;
  const SectionTitleSecond({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
