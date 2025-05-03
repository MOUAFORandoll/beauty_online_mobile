import 'package:flutter/material.dart';

class ShopActionButtons extends StatelessWidget {
  const ShopActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _ActionButton(icon: Icons.call, label: 'Call'),
        _ActionButton(icon: Icons.location_on, label: 'Directions'),
        _ActionButton(icon: Icons.share, label: 'Share'),
        _ActionButton(icon: Icons.star, label: '4.1'),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.black, size: 24),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
