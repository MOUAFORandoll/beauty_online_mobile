import 'package:beauty/common/models/service_model.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:beauty/common/widgets/service_item.dart';
import 'package:flutter/material.dart';

class HorizontalServiceList extends StatelessWidget {
  const HorizontalServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    final services = ServiceModel.mockList();
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length.clamp(0, 6), // max 6 services
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 colonnes
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemBuilder: (_, i) => ServiceItem(service: services[i]),
    );
  }
}
