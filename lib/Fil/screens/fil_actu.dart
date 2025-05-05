import 'package:beauty/common/widgets/filter_buttons.dart';
import 'package:beauty/common/widgets/horizontal_service_list.dart';
import 'package:beauty/common/widgets/location_selector.dart';
import 'package:beauty/common/widgets/post_list.dart';
import 'package:beauty/common/widgets/salon_card_list.dart';
import 'package:beauty/common/widgets/search_bar.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:flutter/material.dart' hide SearchBar;

class FilActuScreen extends StatelessWidget {
  const FilActuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum:
          EdgeInsets.symmetric(horizontal: 16).copyWith(top: kToolbarHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LocationSelector(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const SearchBar(),
                  const SizedBox(height: 16),
                  const FilterButtons(),
                  const SizedBox(height: 16),
                  SectionTitle(title: 'Beauty services'),
                  const SizedBox(height: 16),
                  const HorizontalServiceList(),
                  const SizedBox(height: 16),
                  SectionTitle(title: 'Popular near you'),
                  const SizedBox(height: 16),

                  const SalonCardList(), // Carousel ou horizontal ListView
                  const SizedBox(height: 16),
                  SectionTitle(title: 'Best Realisations'),
                  const SizedBox(height: 16),
                  const PostList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
