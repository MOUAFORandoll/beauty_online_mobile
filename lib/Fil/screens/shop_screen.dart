import 'package:beauty/common/models/service_second_model.dart';
import 'package:beauty/common/widgets/filter_tabs.dart';
import 'package:beauty/common/widgets/package_card.dart';
import 'package:beauty/common/widgets/section_title_second.dart';
import 'package:beauty/common/widgets/shop_action_buttons.dart';
import 'package:beauty/common/widgets/shop_header.dart';
import 'package:flutter/material.dart'; 

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    

    List<ServiceSecondModel> packageServices = [
      ServiceSecondModel(
          name: 'Gold Wax & Glow',
          price: '\$40',
          duration: '40 Mins',
          image: 'https://picsum.photos/200/300'),
      ServiceSecondModel(
          name: 'Quick Detox',
          price: '\$40',
          duration: '40 Mins',
          image: 'https://picsum.photos/200/300'),
      ServiceSecondModel(
          name: 'Wax & Relax',
          price: '\$40',
          duration: '40 Mins',
          image: 'https://picsum.photos/200/300'),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ShopHeader(),
            const SizedBox(
              height: 8,
            ),
            const ShopActionButtons(),
            const SizedBox(
              height: 8,
            ),
            const FilterTabs(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const SectionTitleSecond(title: 'Recommended (5)'),
                  ...packageServices.map((s) => PackageCard(service: s)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
