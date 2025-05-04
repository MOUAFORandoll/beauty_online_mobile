import 'dart:math';

import 'package:beauty/Professionnal/bloc/professional_cubit.dart';
import 'package:beauty/Professionnal/screens/my_professional_board.dart';
import 'package:beauty/account/bloc/cubit/account_view_manage_cubit.dart';
import 'package:beauty/account/screens/my_account.dart';
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

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin, CompletableMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  late final userCubit = context.read<UserCubit>();
  late final professionalCubit = context.read<ProfessionalCubit>();
  late final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async => userCubit.reset(true),
        child: BlocConsumer<ProfessionalCubit, ProfessionalState>(
          listener: onEventReceived,
          builder: (context, state) {
            return NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, _) => [
                SliverAppBar(
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  foregroundColor: AppTheme.white,
                  expandedHeight: 250,
                  pinned: true,
                  actions: [
                    IconButton(
                      onPressed: onActionsPressed,
                      icon: toSvgIcon(
                        icon: Assets.iconsOptions,
                        color: AppTheme.white,
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image(
                          fit: BoxFit.cover,
                          image: context.read<AppCacheManager>().getImage(
                              'https://cdn.pixabay.com/photo/2025/03/31/21/30/italy-9505446_1280.jpg'),
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.error,
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                            size: 32,
                          ),
                        ),
                        // Positioned(
                        //   top: 0,
                        //   left: 0,
                        //   right: 0,
                        //   child: Container(
                        //     height: MediaQuery.of(context).viewPadding.top +
                        //         kToolbarHeight,
                        //     decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topCenter,
                        //         end: Alignment.bottomCenter,
                        //         colors: [
                        //           Theme.of(context).colorScheme.inverseSurface,
                        //           Colors.transparent
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height:
                                MediaQuery.of(context).viewPadding.top * 2.5 +
                                    kToolbarHeight,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Theme.of(context).colorScheme.inverseSurface,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 8, left: 0, right: 0, child: BtnAccount()),
                        // Positioned(
                        //     top: 8, left: 0, right: 8, child: toSvgIcon(Asser)),
                      ],
                    ),
                  ),
                  systemOverlayStyle: Theme.of(context)
                      .appBarTheme
                      .systemOverlayStyle
                      ?.copyWith(statusBarIconBrightness: Brightness.light),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<AccountViewManageCubit, bool>(
                    builder: (ctx, state) => state
                        ? Container()
                        : BlocConsumer<ProfessionalCubit, ProfessionalState>(
                            listener: onEventReceived,
                            builder: (context, state) =>
                                state is ProfessionalLoggedState
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 16.0, right: 16.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Randy Shop', //   'professionalCubit.professional.namePro',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              const SizedBox(height: 16),
                                              const PrimaryInfo(),
                                            ]),
                                      )
                                    : SizedBox.shrink(),
                          ),
                  ),
                ),
              ],
              body: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: BlocBuilder<AccountViewManageCubit, bool>(
                        builder: (ctx, state) => state
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: MyAccount())
                            : MyProfessionalBoard())),
              ),
            );
          },
        ));
  }

  void onActionsPressed() => showAppBottomSheet(
      context: context,
      builder: (innerContext) => Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ActionWidget(
                  title: 'Partager…',
                  icon: Assets.iconsShare,
                  onTap: () {
                    userCubit.shareUser();
                    Navigator.of(innerContext).pop();
                  },
                ),
                const SizedBox(height: 16),
                ActionWidget(
                  title: 'Éditer mon profil',
                  icon: Assets.iconsEdit,
                  onTap: () {
                    Navigator.of(innerContext).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()));
                  },
                ),
                const SizedBox(height: 16),
                ActionWidget(
                  title: 'Paramètres',
                  icon: Assets.iconsSetting,
                  onTap: () {
                    Navigator.of(innerContext).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ActionWidget(
                  title: 'Déconnexion',
                  icon: Assets.iconsLogout,
                  onTap: () async {
                    Navigator.pop(innerContext);
                    await disconnect(context: context);
                  },
                ),
              ],
            ),
          ));

  Future disconnect({required BuildContext context}) {
    return showAppBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Déconnexion',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleLarge!),
                  const SizedBox(
                    height: 32,
                  ),
                  Text('Veux-tu vraiment te déconnecter de cet appareil?',
                      style: Theme.of(context).textTheme.bodyMedium!),
                  const SizedBox(
                    height: 32,
                  ),
                  BeautyButton.primary(
                    onPressed: () {
                      Navigator.of(context).pop();
                      userCubit.signOut();
                    },
                    text: "Se Déconnecter",
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BeautyButton.white(
                    onPressed: () => Navigator.pop(context),
                    text: 'Annuler',
                  )
                ]));
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
