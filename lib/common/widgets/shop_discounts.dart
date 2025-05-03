import 'package:flutter/material.dart';

class ShopDiscounts extends StatelessWidget {
  const ShopDiscounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _DiscountTile(
          title: '50% off',
          subtitle: 'Use code FREE50',
        ),
        SizedBox(height: 8),
        _DiscountTile(
          title: '60% off on Debit Card',
          subtitle: 'No coupon required',
        ),
      ],
    );
  }
}

class _DiscountTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const _DiscountTile({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F6FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDDD9FF)),
      ),
      child: Row(
        children: [
          const Icon(Icons.discount, color: Color(0xFF7E5EFF)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}
