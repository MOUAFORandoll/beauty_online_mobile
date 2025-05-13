import 'dart:math';

import 'package:beauty/common/widgets/loader_builder.dart';
import 'package:flutter/material.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import '../widgets/status_bar.dart';
import '../widgets/search_tabs.dart';
import '../widgets/content_grid.dart';
import '../widgets/bottom_navigation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FilActuScreen extends StatelessWidget {
  const FilActuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kToolbarHeight,
        ),
        SizedBox(height: 80, child: StoriesLoaderBuilder()),

        Expanded(
          child: PinterestGridPage(),
        ),
        // Expanded(
        //   child: ContentGrid(),
        // ),
      ],
    );
  }
}

class PinterestGridPage extends StatelessWidget {
  final List<Color> colors = List.generate(30, (_) => getRandomColor());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MasonryGridView.count(
        crossAxisCount: 2, // 📌 Deux colonnes
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: colors[index],
              borderRadius: BorderRadius.circular(12),
            ),
            // 📐 Hauteur variable
            height: 150 + Random().nextInt(250).toDouble(),
            child: Center(
              child: Text(
                "Item $index",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}

Color getRandomColor() {
  final random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(200),
    random.nextInt(200),
    random.nextInt(200),
  );
}
