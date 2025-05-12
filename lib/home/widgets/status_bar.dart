import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  final String time;
  final int batteryPercentage;
  final bool isLTE;

  const StatusBar({
    super.key,
    required this.time,
    required this.batteryPercentage,
    required this.isLTE,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              // Network Signal Icon
              const Icon(
                Icons.signal_cellular_4_bar,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 4),
              // LTE Text
              Text(
                isLTE ? "LTE" : "4G",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              // Battery Icon with Percentage
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 28,
                    height: 14,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  Positioned(
                    right: 2,
                    child: Container(
                      width: batteryPercentage * 0.24, // Scale to fit
                      height: 10,
                      decoration: BoxDecoration(
                        color: batteryPercentage > 20 ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -4,
                    child: Container(
                      width: 2,
                      height: 6,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "$batteryPercentage%",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
