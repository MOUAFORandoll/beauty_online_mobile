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
    return OutlinedButton.icon(
      onPressed: () {},
      icon: icon != null ? Icon(icon, size: 16) : const SizedBox.shrink(),
      label: Text(text),
    );
  }
}
