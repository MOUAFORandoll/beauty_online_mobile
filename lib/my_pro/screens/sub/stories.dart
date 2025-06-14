import 'package:beauty/common/models/service_model.dart'; 
import 'package:beauty/common/utils/themes.dart';
import 'package:flutter/material.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    final services = ServiceModel.mockList();
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length.clamp(0, 6), // max 6 services
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1,
      ),

      itemBuilder: (_, i) => Container(
        color: AppTheme.disabledText,
      ),
    );
  }
}
