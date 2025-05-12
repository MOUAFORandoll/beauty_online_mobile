import 'package:beauty/common/widgets/loader_builder.dart';
import 'package:flutter/material.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import '../widgets/status_bar.dart';
import '../widgets/search_tabs.dart';
import '../widgets/content_grid.dart';
import '../widgets/bottom_navigation.dart';

class FilActuScreen extends StatelessWidget {
  const FilActuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kToolbarHeight,
        ),
        SizedBox(height: 96, child: StoriesLoaderBuilder()),
        Expanded(
          child: ContentGrid(),
        ),
      ],
    );
    // NestedScrollViewPlus(
    //   headerSliverBuilder: (context, _) => [
    //     SliverToBoxAdapter(
    //       child: SizedBox(
    //         height: kToolbarHeight,
    //       ),
    //     ),
    //     SliverToBoxAdapter(
    //         child: SizedBox(height: 96, child: StoriesLoaderBuilder())),
    //   ],
    //   body: Expanded(
    //     child: ContentGrid(),
    //   ),
    // );
  }
}
