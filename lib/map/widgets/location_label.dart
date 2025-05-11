import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationLabel extends StatelessWidget {
  final LatLng position;
  final String label;
  final double fontSize;
  final String? subLabel;
  final Color? subLabelColor;
  
  const LocationLabel({
    super.key,
    required this.position,
    required this.label,
    this.fontSize = 14,
    this.subLabel,
    this.subLabelColor,
  });

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: position,
          width: 200,
          height: 80,
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              if (subLabel != null)
                Text(
                  subLabel!,
                  style: TextStyle(
                    fontSize: fontSize - 2,
                    color: subLabelColor ?? Colors.black54,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
