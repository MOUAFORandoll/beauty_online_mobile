import 'dart:math';

import 'package:beauty/Professionnal/bloc/professional_cubit.dart';
import 'package:beauty/Professionnal/widgets/catalogue.dart';
import 'package:beauty/Professionnal/widgets/stories.dart';
import 'package:beauty/account/widgets/btn_account.dart';
import 'package:beauty/account/widgets/primary_info.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/widgets/read_more_theme.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:beauty/account/screens/edit_profile.dart';
import 'package:beauty/account/screens/settings/edit_profile_picture_screen.dart';
import 'package:beauty/account/screens/settings/settings_screen.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/widgets/action_widget.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/profile_picture.dart';
import 'package:beauty/utils/assets.dart';
import 'package:beauty/utils/dialogs.dart';
import 'package:beauty/utils/svg_utils.dart';
import 'package:beauty/utils/themes.dart';

class MyProfessionalBoard extends StatefulWidget {
  const MyProfessionalBoard({super.key});

  @override
  State<MyProfessionalBoard> createState() => _MyProfessionalBoardState();
}

class _MyProfessionalBoardState extends State<MyProfessionalBoard>
    with SingleTickerProviderStateMixin, CompletableMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  late final userCubit = context.read<UserCubit>();
  late final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfessionalCubit, ProfessionalState>(
      listener: onEventReceived,
      builder: (context, state) {
        return Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: DefaultTabController(
                length: 3,
                child: Column(children: [
                  _TabBarGap(controller: _scrollController),
                  TabBar(
                    isScrollable: true,
                    splashBorderRadius: BorderRadius.circular(64.0),
                    tabs: const [
                      Tab(text: "Catalogues"),
                      Tab(text: "Stories"),
                      Tab(text: "Reservations"),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Catalogue(),
                        Stories(),
                        // EpisodeTab.get(context: context, anime: anime),
                        // SimilarAnimeTab.get(context: context, anime: anime),
                        // QuizAnimeTab.get(context: context, anime: anime),
                      ],
                    ),
                  )
                ])));
      },
    );
  }

  void onEventReceived(BuildContext context, ProfessionalState state) async {
    await waitForDialog();

    // if (state is ShareAnimeLoadingState) {
    //   loadingDialogCompleter = showLoadingBarrier(
    //     context: context,
    //   );
    // } else if (state is ShareAnimeSuccesState) {
    //   await Share.share(state.link);
    // } else if (state is AnimeManipErrorState) {
    //   showErrorToast(content: state.error, context: context);
    // }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _TabBarGap extends StatefulWidget {
  final ScrollController controller;

  const _TabBarGap({required this.controller});

  @override
  State<_TabBarGap> createState() => _TabBarGapState();
}

class _TabBarGapState extends State<_TabBarGap> {
  double gap = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (!widget.controller.hasClients) return;

      // calcule la distance entre le début du body (du NestedScrollView) et
      // le haut de l'écran, et en fait un SizedBox. L'écart s'adapte en
      // fonction de la distance entre les deux, ce qui donne l'effet sticky.
      setState(() {
        gap = max(
            widget.controller.position.pixels -
                (widget.controller.position.maxScrollExtent -
                    MediaQuery.of(context).viewPadding.top -
                    kToolbarHeight),
            0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: gap);
  }
}
