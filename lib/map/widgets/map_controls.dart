import 'package:flutter/material.dart';

class MapControls extends StatelessWidget {
  const MapControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black54),
            onPressed: () {},
          ),
          const Divider(height: 1, thickness: 1, indent: 8, endIndent: 8),
          IconButton(
            icon: const Icon(Icons.language, color: Colors.blue),
            onPressed: () {},
          ),
          const Divider(height: 1, thickness: 1, indent: 8, endIndent: 8),
          IconButton(
            icon: const Icon(Icons.satellite_alt, color: Colors.black54),
            onPressed: () {},
          ),
          const Divider(height: 1, thickness: 1, indent: 8, endIndent: 8),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
