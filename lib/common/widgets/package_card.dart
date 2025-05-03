import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import '../models/service_second_model.dart';

class PackageCard extends StatelessWidget {
  final ServiceSecondModel service;
  const PackageCard({required this.service, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: context.read<AppCacheManager>().getImage(
                            service.image,
                          ),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: Theme.of(context).textTheme.labelLarge!,
                  ),
                  Text(service.price),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    service.duration,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppTheme.disabledText),
                  ),
                ],
              )
            ]),
            Spacer(),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Reserver'),
            ),
          ],
        ));
  }
}
