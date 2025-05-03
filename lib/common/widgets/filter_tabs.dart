
import 'package:flutter/material.dart';

class FilterTabs extends StatelessWidget {
  const FilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          FilterChip(label: const Text('Recommended'), onSelected: (_) {}),
          const SizedBox(width: 8),
          FilterChip(label: const Text('Packages'), onSelected: (_) {}),
          const SizedBox(width: 8),
          FilterChip(label: const Text('Face Care'), onSelected: (_) {}),
        ],
      ),
    );
  }
}
