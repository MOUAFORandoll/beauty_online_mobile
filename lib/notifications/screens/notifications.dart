import 'package:beauty/common/widgets/filter_buttons.dart';
import 'package:beauty/common/widgets/horizontal_service_list.dart';
import 'package:beauty/common/widgets/location_selector.dart';
import 'package:beauty/common/widgets/post_list.dart';
import 'package:beauty/common/widgets/salon_card_list.dart';
import 'package:beauty/common/widgets/search_bar.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:flutter/material.dart' hide SearchBar;

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum:
          EdgeInsets.symmetric(horizontal: 16).copyWith(top: kToolbarHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
//Tout , Non Lu  , Lu
        ],
      ),
    );
  }
}
