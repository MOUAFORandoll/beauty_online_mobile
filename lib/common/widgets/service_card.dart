import 'package:beauty/common/services/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import '../models/service_second_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceSecondModel service;
  const ServiceCard({required this.service, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image(
          image: context.read<AppCacheManager>().getImage(
                service.image,
              ),
        ),
        title: Text(service.name),
        subtitle: Text('${service.price} · ${service.duration}'),
        trailing: OutlinedButton(
          onPressed: () {},
          child: const Text('Select +'),
        ),
      ),
    );
  }
}
