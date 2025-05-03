import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
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

  Widget counter(
      {required int count,
      required String label,
      required String icon,
      VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                NumberFormat.compact().format(count),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 16.0),
              ),
              const SizedBox(width: 4.0),
              toSvgIcon(icon: icon, size: 16.0)
            ],
          ),
          Text(
            label,
            style: const TextStyle(color: AppTheme.disabledText),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: onEventReceived,
        builder: (context, state) {
          late final user = userCubit.user;

          return Scaffold(
              appBar: AppBar(
                forceMaterialTransparency: true,
                title: Text(user.userName!),
                centerTitle: true,
                actions: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: onActionsPressed,
                    icon: toSvgIcon(
                      icon: Assets.iconsOptions,
                    ),
                  )
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async => userCubit.reset(true),
                child: NestedScrollViewPlus(
                  physics: const AlwaysScrollableScrollPhysics(),
                  headerSliverBuilder: (context, _) => [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              const EditProfilePictureScreen()));
                                    },
                                    child: const UserProfilePicture(size: 80)),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.userName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        user.phone!,
                                        maxLines: 100,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surfaceTint),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              counter(
                                  onTap: () {},
                                  icon: Assets.iconsFollow,
                                  count: 12,
                                  label: "Realisations"),
                              counter(
                                  onTap: () {},
                                  icon: Assets.iconsFollow,
                                  count: 21,
                                  label: "Rendez-vous"),
                              counter(
                                  icon: Assets.iconsTrending,
                                  count: 54,
                                  onTap: () => _tabController.animateTo(1),
                                  label: "Nos"),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: BeautyButton.primary(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EditProfileScreen()));
                                    },
                                    text: "Éditer mon profil",
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: BeautyButton.black(
                                    onPressed: userCubit.shareUser,
                                    text: "Partager",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                  body: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        splashBorderRadius: BorderRadius.circular(64.0),
                        tabs: const [
                          Tab(text: 'Activité'),
                          Tab(text: 'Liste'),
                          Tab(text: 'Social'),
                          Tab(text: 'Quiz'),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  void onEventReceived(BuildContext context, UserState state) async {
    await waitForDialog();

    // empêche cette page d'écouter les évenements lancés dans les pages au dessus
    if (!(ModalRoute.of(context)?.isCurrent ?? false)) return;

    if (state is UserLoggingOut) {
      loadingDialogCompleter =
          showLoadingBarrier(context: context, text: "Déconnexion…");
    } else if (state is ShareUserLoadingState) {
      loadingDialogCompleter = showLoadingBarrier(
        context: context,
      );
    } else if (state is ShareUserSuccessState) {
      await Share.share(state.shareLink);
    } else if (state is UserErrorState) {
      showErrorToast(content: state.error, context: context);
    }
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
}
