import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        _buildFilterButton('Gender'),
        _buildFilterButton('Price'),
        _buildFilterButton('Offers', icon: Icons.local_offer_outlined),
        _buildFilterButton('Rating', icon: Icons.swap_vert),
      ],
    );
  }

  Widget _buildFilterButton(String text, {IconData? icon}) {
    return Chip(
      label: Text(text),
      avatar: icon != null ? Icon(icon, size: 16, color: Colors.grey) : null,
      labelStyle: const TextStyle(color: Colors.black),
    );
  }
}
