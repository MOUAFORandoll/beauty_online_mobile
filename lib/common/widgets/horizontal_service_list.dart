import 'package:beauty/common/models/service_model.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:beauty/common/widgets/service_item.dart';
import 'package:flutter/material.dart';
class HorizontalServiceList extends StatelessWidget {
  const HorizontalServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    final services = ServiceModel.mockList();
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, i) => ServiceItem(service: services[i]),
      ),
    );
  }
}
