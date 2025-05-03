import 'package:beauty/common/widgets/filter_buttons.dart';
import 'package:beauty/common/widgets/horizontal_service_list.dart';
import 'package:beauty/common/widgets/location_selector.dart';
import 'package:beauty/common/widgets/offer_card_list.dart';
import 'package:beauty/common/widgets/salon_card_list.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LocationSelector(),
              const SizedBox(height: 16),
              const SearchBar(),
              const SizedBox(height: 16),
              const FilterButtons(),
              const SizedBox(height: 24),
              SectionTitle(title: 'Beauty services'),
              const HorizontalServiceList(),
              const SizedBox(height: 24),
              SectionTitle(title: 'Popular near you'),
              const SalonCardList(), // Carousel ou horizontal ListView
              const SizedBox(height: 24),
              SectionTitle(title: 'Best Offers'),
              const OfferCardList(),
            ],
          ),
        ),
      ),
    );
  }
}
