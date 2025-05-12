import 'package:flutter/material.dart';
import 'content_card.dart';

class ContentGrid extends StatelessWidget {
  const ContentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(8.0),
      crossAxisCount: 2,
      childAspectRatio: 0.85,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: [
        // Top row
        ContentCard(
          imageUrl: 'https://randomuser.me/api/portraits/men/73.jpg',
          title: '',
          showMoreButton: true,
          onTap: () {},
        ),
        ContentCard(
          imageUrl: 'https://randomuser.me/api/portraits/men/73.jpg',
          title: '',
          showMoreButton: true,
          onTap: () {},
        ),

        // Middle row
        ContentCard(
          imageUrl: 'https://randomuser.me/api/portraits/men/73.jpg',
          title: 'Shopease - eCommerce Fa...',
          showMoreButton: true,
          isMultiImage: true,
          onTap: () {},
        ),
        ContentCard(
          imageUrl: 'https://randomuser.me/api/portraits/men/73.jpg',
          title: 'Booking.com: Hôtels & Voyage',
          showInstallButton: true,
          showMoreButton: true,
          sponsoredTag: 'Sponsorisé',
          sponsorLogo: '/placeholder.svg?height=40&width=40',
          onTap: () {},
        ),

        // Bottom row
        ContentCard(
          imageUrl: 'https://randomuser.me/api/portraits/men/73.jpg',
          title: '',
          showMoreButton: true,
          isOutfitCard: true,
          onTap: () {},
        ),
        ContentCard(
          imageUrl: 'https://randomuser.me/api/portraits/men/73.jpg',
          title: '',
          showMoreButton: true,
          onTap: () {},
        ),
        ContentCard(
          imageUrl: 'https://randomuser.me/api/portraits/men/73.jpg',
          title: '',
          showMoreButton: true,
          onTap: () {},
        ),
        ContentCard(
          imageUrl: 'https://randomuser.me/api/portraits/men/73.jpg',
          title: '',
          showMoreButton: true,
          onTap: () {},
        ),
        ContentCard(
          imageUrl: 'https://randomuser.me/api/portraits/men/73.jpg',
          title: '',
          showMoreButton: true,
          onTap: () {},
        ),
        ContentCard(
          imageUrl: 'https://randomuser.me/api/portraits/men/73.jpg',
          title: '',
          showMoreButton: true,
          onTap: () {},
        ),
      ],
    );
  }
}
