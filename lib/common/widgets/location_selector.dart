import 'package:flutter/material.dart';

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.location_on_outlined, size: 20),
        SizedBox(width: 6),
        Text('Munich Center', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Icon(Icons.keyboard_arrow_down),
      ],
    );
  }
}
