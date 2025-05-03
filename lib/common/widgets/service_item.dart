import 'package:beauty/common/models/service_model.dart';
import 'package:flutter/material.dart';
class ServiceItem extends StatelessWidget {
  final ServiceModel service;

  const ServiceItem({required this.service, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(service.image),
        ),
        const SizedBox(height: 8),
        Text(
          service.title,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
