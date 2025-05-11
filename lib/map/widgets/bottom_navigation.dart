import 'package:beauty/utils/assets.dart';
import 'package:beauty/utils/svg_utils.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildAvatarButton(Icons.search, null),
          _buildAvatarButton(null, "assets/images/avatar1.png"),
          _buildAvatarButton(null, "assets/images/avatar2.png",
              showIndicator: true),
          _buildAvatarButton(null, "assets/images/avatar3.png"),
          _buildAvatarButton(Icons.person_outline, null, isPlaceholder: true),
          _buildAvatarButton(null, "assets/images/avatar4.png"),
          _buildAvatarButton(null, "assets/images/avatar5.png"),
        ],
      ),
    );
  }

  Widget _buildAvatarButton(IconData? icon, String? imagePath,
      {bool isPlaceholder = false, bool showIndicator = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: icon != null
                    ? Icon(icon, color: Colors.black54)
                    : isPlaceholder
                        ? Icon(icon, color: Colors.yellow)
                        : ClipOval(
                            child: imagePath != null
                                ? toSvgIcon(icon: Assets.iconsError, size: 16)
                                : const SizedBox(),
                          ),
              ),
              if (showIndicator)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon,
      {bool isActive = false, int? badgeCount}) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: isActive ? Colors.black : Colors.black54,
            size: 28,
          ),
          onPressed: () {},
        ),
        if (badgeCount != null)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                badgeCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
