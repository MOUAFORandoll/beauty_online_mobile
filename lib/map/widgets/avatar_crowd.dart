import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AvatarCrowd extends StatelessWidget {
  final LatLng position;
  final double size;

  const AvatarCrowd({
    super.key,
    required this.position,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: position,
          width: size,
          height: size,
          child: _buildAvatarCluster(),
        ),
      ],
    );
  }

  Widget _buildAvatarCluster() {
    // This is a simplified representation of the avatar crowd
    // In a real app, you would load actual avatar images and position them
    return Stack(
      children: [
        // Base layer of avatars
        for (int i = 0; i < 40; i++)
          Positioned(
            left: (i % 8) * 20.0,
            top: (i ~/ 8) * 20.0,
            child: _buildRandomAvatar(),
          ),

        // Add some umbrellas
        Positioned(
          top: 30,
          left: 50,
          child: Icon(Icons.umbrella, size: 24, color: Colors.green.shade700),
        ),
        Positioned(
          top: 70,
          left: 120,
          child: Icon(Icons.umbrella, size: 24, color: Colors.yellow.shade700),
        ),

        // Add a purple avatar that stands out (as seen in the image)
        Positioned(
          bottom: 20,
          right: 30,
          child: Container(
            width: 24,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRandomAvatar() {
    // Generate random avatar colors to simulate the crowd
    final List<Color> skinTones = [
      Colors.brown.shade300,
      Colors.brown.shade400,
      Colors.brown.shade500,
      Colors.brown.shade600,
      Colors.brown.shade700,
      Colors.brown.shade800,
    ];

    final List<Color> clothingColors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.white,
      Colors.black,
    ];

    final skinTone = skinTones[DateTime.now().millisecond % skinTones.length];
    final clothingColor =
        clothingColors[DateTime.now().microsecond % clothingColors.length];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Head
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: skinTone,
            shape: BoxShape.circle,
          ),
        ),
        // Body
        Container(
          width: 10,
          height: 15,
          decoration: BoxDecoration(
            color: clothingColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(3),
              bottomRight: Radius.circular(3),
            ),
          ),
        ),
      ],
    );
  }
}
