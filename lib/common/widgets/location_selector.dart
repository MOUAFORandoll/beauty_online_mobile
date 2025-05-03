import 'package:flutter/material.dart';

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, size: 20),
        SizedBox(width: 6),
        Text('Munich Center',
            style: Theme.of(context)
                .textTheme
                .labelLarge // style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),

            ),
        Icon(Icons.keyboard_arrow_down),
      ],
    );
  }
}
