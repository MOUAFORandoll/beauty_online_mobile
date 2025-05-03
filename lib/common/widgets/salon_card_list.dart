import 'package:beauty/common/models/salon_model.dart';
import 'package:flutter/material.dart';
import 'salon_card.dart';

class SalonCardList extends StatelessWidget {
  const SalonCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final salons = SalonModel.mockPopular();
    return SizedBox(
      height: 290,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: salons.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, i) => SalonCard(salon: salons[i]),
      ),
    );
  }
}
