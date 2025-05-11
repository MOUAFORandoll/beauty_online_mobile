import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/bloc/home_bottom_navigation_cubit.dart'; 
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationCubit = context.read<HomeBottomNavigationCubit>();

    return GestureDetector(
        onTap: () =>
            onTap(context: context, index: navigationCubit.state.currentIndex),
        child: Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.tertiary),
          child: toSvgIcon(
            icon: Assets.iconsSearch,
            size: 24,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
        ));
  }

  void onTap({required BuildContext context, required int index}) {
    // if ([2, 3].contains(index)) {
    //   showSearch(
    //     context: context,
    //     delegate: HomeSearchAnimeDelegate(context),
    //   );
    // }
    // if ([0, 1].contains(index)) {
    //   showSearch(
    //     context: context,
    //     delegate: HomeSearchUserDelegate(context),
    //   );
    // }
  }
}
