import 'dart:math';

import 'package:beauty/Professional/bloc/professional_cubit.dart';
import 'package:beauty/Professional/screens/create_profil_pro.dart.dart';
import 'package:beauty/Professional/widgets/catalogue.dart';
import 'package:beauty/Professional/widgets/stories.dart';
import 'package:beauty/account/widgets/btn_account.dart';
import 'package:beauty/account/widgets/primary_info.dart';
import 'package:beauty/common/screens/home.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/widgets/loader_builder.dart';
import 'package:beauty/common/widgets/read_more_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      print(
          '_tabController.indexIsChanging    ===${_tabController.indexIsChanging}');
      if (_tabController.indexIsChanging == false) {
        print('_tabController.index    ===${_tabController.index}');
        setState(() {}); // Rafraîchit la FAB quand l'index change

        print('_tabController.index    ===${_tabController.index}');
      }
    });
  }

  late final professionalCubit = context.read<ProfessionalCubit>();
  late final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfessionalCubit, ProfessionalState>(
        listener: onEventReceived,
        builder: (context, state) => state is InitializingProfessionalState
            ? ProfessionalBoardLoaderBuilder()
            : state is ProfessionalLoggedState
                ? existProfessionnel()
                : state is NoProfessionnalFondState
                    ? noExistProfessionnel()
                    : errorFindProfessionnel());
  }

  Widget existProfessionnel() => Scaffold(
      primary: false,
      body: Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(children: [
            _TabBarGap(controller: _scrollController),
            TabBar(
              isScrollable: false,
              controller: _tabController,
              tabAlignment: TabAlignment.fill,
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
                controller: _tabController,
                children: [
                  Catalogue(),
                  Stories(),
                  Stories(),
                ],
              ),
            )
          ])),
      floatingActionButton: _tabController.index == 2
          ? null
          : FloatingActionButton(
              heroTag: 'nouveau',
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  ),
              child: toSvgIcon(icon: Assets.iconsMore)));

  Widget noExistProfessionnel() => SingleChildScrollView(
        child: SafeArea(
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Illustration SVG (à adapter)
                    SizedBox(
                      height: 180,
                      child: SvgPicture.asset(
                        Assets.iconsEmpty, // remplace par ton asset
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "Aucun profil professionnel",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Vous n’avez pas encore créé de profil professionnel.\nC’est essentiel pour proposer vos services.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    BeautyButton.primary(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const CreateProfilProScreen()),
                        );
                      },
                      text: "Créer mon profil",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget errorFindProfessionnel() => SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Illustration SVG
                SizedBox(
                  height: 180,
                  child: SvgPicture.asset(
                    Assets.iconsError, // remplace par ton illustration
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "Une erreur est survenue",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "Impossible de récupérer vos données pour le moment.\nVeuillez vérifier votre connexion et réessayer.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextButton.icon(
                  onPressed: professionalCubit.getInitialState,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Réessayer"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppTheme.errorRed,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

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
