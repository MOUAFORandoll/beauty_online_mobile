import 'package:beauty/common/widgets/custom_icon_button.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';

class ShopHeader extends StatelessWidget {
  const ShopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
            image: context
                .read<AppCacheManager>()
                .getImage('https://picsum.photos/200/300'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 320),
        Positioned(
            top: 16,
            left: 8,
            child: CustomIconButton(
                icon: Icons.arrow_back,
                onPressed: () => Navigator.pop(context))),
        Positioned(
          bottom: 16,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('FOR WOMEN', style: TextStyle(color: Colors.white70)),
              Text('Style Lounge Salon',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text('Ranchview · 3.6 Kms · \$\$',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        Positioned(
            bottom: 16,
            right: 16,
            child: Icon(Icons.favorite_border, color: Colors.white)),
      ],
    );
  }
}
