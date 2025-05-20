import 'dart:math';

import 'package:beauty/common/widgets/empty_builder.dart';
import 'package:beauty/common/widgets/error_builder.dart';
import 'package:beauty/common/widgets/loader_builder.dart';
import 'package:beauty/home/bloc/load_actu_cubit.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/widgets/item_actu.dart';
import 'package:flutter/material.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import 'package:potatoes/auto_list/widgets/auto_list_view.dart';
import 'package:potatoes/libs.dart';
import '../widgets/status_bar.dart';
import '../widgets/search_tabs.dart';
import '../widgets/content_grid.dart';
import '../widgets/bottom_navigation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FilActuScreen extends StatefulWidget {
  const FilActuScreen({super.key});

  @override
  State<FilActuScreen> createState() => _FilActuScreenState();
}

class _FilActuScreenState extends State<FilActuScreen> {
  late final cubit = context.read<LoadActuCubit>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          cubit.reset();
        },
        child: Column(
          children: [
            SizedBox(
              height: kToolbarHeight,
            ),
            // SizedBox(height: 80, child: StoriesLoaderBuilder()),

            Expanded(
                child: AutoListView.get<Actu>(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom),
              autoManage: false,
              cubit: cubit,
              viewType: ViewType.custom,
              customBuilder: (context, actus) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MasonryGridView.count(
                    crossAxisCount: 2, // 📌 Deux colonnes
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    shrinkWrap: true,
                    physics: PageScrollPhysics(),
                    itemCount: actus.length,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          height: 150 + Random().nextInt(250).toDouble(),
                          child: ActuItem(actus[index]));
                    },
                  )),
              emptyBuilder: (ctx) => const EmptyBuilder(),
              errorBuilder: (context, retry) => ErrorBuilder(retry: retry),
              loadingBuilder: (_) => ActuLoaderBuilder(count: 12),
            )

                //  PinterestGridPage(),
                ),
            // Expanded(
            //   child: ContentGrid(),
            // ),
          ],
        ));
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
