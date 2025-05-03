import 'package:beauty/common/models/salon_model.dart';
import 'package:flutter/material.dart'; 
import 'salon_card.dart';

class OfferCardList extends StatelessWidget {
  const OfferCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = SalonModel.mockOffers();
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: offers.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, i) => Stack(
          children: [
            SalonCard(salon: offers[i]),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '50% Off',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
