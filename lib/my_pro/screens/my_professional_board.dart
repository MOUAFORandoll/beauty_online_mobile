import 'dart:math';

import 'package:beauty/my_pro/screens/sub/add_schedule_screen.dart';
import 'package:beauty/my_pro/bloc/my_professional_cubit.dart';
import 'package:beauty/my_pro/screens/create_profil_pro.dart.dart';
import 'package:beauty/my_pro/screens/sub/add_catalogue.dart';
import 'package:beauty/my_pro/screens/sub/catalogue.dart';
import 'package:beauty/my_pro/screens/sub/mon_agenda.dart';
import 'package:beauty/my_pro/screens/sub/stories.dart';
import 'package:beauty/account/widgets/btn_account.dart';
import 'package:beauty/account/widgets/primary_info.dart';
import 'package:beauty/common/screens/home.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/widgets/loader_builder.dart';
import 'package:beauty/common/widgets/read_more_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart'; 
import 'package:intl/intl.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:beauty/account/screens/settings/edit_user.dart';

import 'package:beauty/account/screens/settings/settings_screen.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/widgets/action_widget.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/profile_picture.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';

class MyProfessionalBoard extends StatefulWidget {
  final ScrollController scrollController;

  const MyProfessionalBoard({super.key, required this.scrollController});

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

  late final professionalCubit = context.read<MyProfessionalCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyProfessionalCubit, MyProfessionalState>(
        listener: onEventReceived,
        builder: (context, state) =>

            // noExistProfessionnel()

            state is InitializingMyProfessionalState
                ? ProfessionalBoardLoaderBuilder()
                : state is MyProfessionalLoggedState
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
            _TabBarGap(controller: widget.scrollController),
            TabBar(
              isScrollable: false,
              controller: _tabController,
              tabAlignment: TabAlignment.fill,
              splashBorderRadius: BorderRadius.circular(64.0),
              tabs: const [
                Tab(text: "Catalogues"),
                // Tab(text: "Stories"),
                Tab(text: "Mon Agenda"),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  CatalogueView(),
                  // Stories(),
                  MonAgenda(),

                  // .get(context: context),
                ],
              ),
            )
          ])),
      floatingActionButton: FloatingActionButton(
          heroTag: 'nouveau',
          onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => _tabController.index == 0
                      ? AddProductScreen()
                      : _tabController.index == 1
                          ? AddScheduleScreen()
                          : AddScheduleScreen(),
                ),
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

  void onEventReceived(BuildContext context, MyProfessionalState state) async {
    await waitForDialog();

    // if (state is ShareCatalogueLoadingState) {
    //   loadingDialogCompleter = showLoadingBarrier(
    //     context: context,
    //   );
    // } else if (state is ShareCatalogueSuccesState) {
    //   await Share.share(state.link);
    // } else if (state is CatalogueManipErrorState) {
    //   showErrorToast(content: state.error, context: context);
    // }
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
