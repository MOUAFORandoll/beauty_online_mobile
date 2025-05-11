import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  final int temperature;
  final String unit;
  final IconData icon;
  
  const WeatherWidget({
    super.key,
    required this.temperature,
    required this.unit,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 6),
          Text(
            "$temperature$unit",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
