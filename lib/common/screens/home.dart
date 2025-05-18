import 'package:beauty/common/bloc/select_realisation_cubit.dart';
import 'package:beauty/common/screens/await_load.dart';
import 'package:beauty/home/screens/fil_actu_screen.dart';
import 'package:beauty/account/screens/account.dart';
import 'package:beauty/account/screens/settings/settings_screen.dart';
import 'package:beauty/map/screens/map_screen.dart';
import 'package:beauty/notifications/bloc/notification_cubit.dart';
import 'package:beauty/notifications/screens/notifications.dart';
import 'package:beauty/notifications/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart';
import 'package:beauty/common/bloc/home_bottom_navigation_cubit.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/screens/app_upgrade.dart';
import 'package:beauty/common/widgets/profile_picture.dart';
import 'package:beauty/common/widgets/search_widget.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with CompletableMixin {
  late final navigationCubit = context.read<HomeBottomNavigationCubit>();
  late final pages = [
    {'title': 'Social', 'page': FilActuScreen()},
    {'title': 'Find', 'page': MapScreen()},
    {'title': 'Notifications', 'page': NotificationsScreen()},
    {'title': 'Compte', 'page': AccountScreen()},
  ];
  bool activityInitiallyLoaded = false;

  @override
  void initState() {
    super.initState();
    context.read<SelectRealisationCubit>().change('');

    context.read<NotificationService>().context = context;
    context.read<NotificationCubit>().requestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: navigationCubit.state.isInInitialPosition,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (!didPop) navigationCubit.goToPage(index: 0);
      },
      child: BlocListener<UserCubit, UserState>(
        listener: onUserEventReceived,
        child: BlocListener<NotificationCubit, NotificationState>(
          listener: onNotificationReceived,
          child:
              BlocBuilder<HomeBottomNavigationCubit, HomeBottomNavigationState>(
                  builder: (context, state) => Scaffold(
                        body: PageView(
                          controller: navigationCubit.state.pageController,
                          onPageChanged: (index) => navigationCubit.goToPage(
                              index: index, animate: false),
                          children: pages
                              .map((page) => page['page'] as Widget)
                              .toList(),
                        ),
                        bottomNavigationBar: BottomNavigationBar(
                          onTap: (index) =>
                              navigationCubit.goToPage(index: index),
                          currentIndex: state.currentIndex,
                          useLegacyColorScheme: false,
                          items: <BottomNavigationBarItem>[
                            BottomNavigationBarItem(
                                icon: _buildIconWithDecoration(
                                    icon: Assets.iconsNotification,
                                    selected: state.currentIndex == 0),
                                label: pages[0]['title'] as String,
                                backgroundColor: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor),
                            BottomNavigationBarItem(
                                icon: _buildIconWithDecoration(
                                    icon: Assets.iconsbeauty,
                                    selected: state.currentIndex == 1),
                                label: pages[1]['title'] as String,
                                backgroundColor: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor),
                            BottomNavigationBarItem(
                                icon: _buildIconWithDecoration(
                                    icon: Assets.iconsTrending,
                                    selected: state.currentIndex == 2),
                                label: pages[2]['title'] as String,
                                backgroundColor: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor),
                            BottomNavigationBarItem(
                                icon: _buildIconWithDecoration(
                                    icon: Assets.iconsQuiz,
                                    selected: state.currentIndex == 3),
                                label: pages[3]['title'] as String,
                                backgroundColor: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .backgroundColor),
                          ],
                        ),
                      )),
        ),
      ),
    );
  }

  void onNotificationReceived(
      BuildContext context, NotificationState state) async {
    if (state is RdvNotificationLoadingState) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AwaitLoadScreen()));
    }
  }

  void onUserEventReceived(BuildContext context, UserState state) {
    if (state is UserShouldUpgradeAppState) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const AppUpgradeScreen()));
    }
  }

  Widget _buildIconWithDecoration({required icon, required bool selected}) {
    return selected
        ? Container(
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(32.0)),
            child: toSvgIcon(
              icon: icon,
              color: Colors
                  .white, //  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            ))
        : toSvgIcon(
            icon: icon,
            color:
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            size: 24.0);
  }
}
