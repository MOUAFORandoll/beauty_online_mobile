import 'dart:io';

import 'package:beauty/Professionnal/bloc/professional_cubit.dart';
import 'package:beauty/account/screens/account.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/widgets/profile_picture.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/account/bloc/theme_mode_cubit.dart';
import 'package:beauty/common/services/api_service.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/utils/assets.dart';
import 'package:beauty/utils/svg_utils.dart';
import 'package:beauty/utils/themes.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchNotificationSettings(); // Récupère les paramètres au démarrage.
  }

  late final userCubit = context.read<UserCubit>();
  late final professionalCubit = context.read<ProfessionalCubit>();

  late final preferencesService = userCubit.preferencesService;

  Future<void> _fetchNotificationSettings() async {
    await FirebaseMessaging.instance.getNotificationSettings();
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<NotificationSettings> _getNotificationSettings() {
    return FirebaseMessaging.instance.getNotificationSettings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      late final user = userCubit.user;

      return SafeArea(
        minimum: const EdgeInsets.only(bottom: 48, top: 24),
        child: ListTileTheme(
          data: ListTileThemeData(
              titleTextStyle: Theme.of(context).textTheme.bodyLarge,
              subtitleTextStyle: Theme.of(context).textTheme.bodyMedium),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile Personnel',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      'Profile Professionnel',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const AccountScreen()));
                              },
                              child: const UserProfilePicture(size: 80)),
                          SizedBox(
                            width: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.userName ?? '',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.phone ?? '',
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
                          )
                        ],
                      ),
                    ])),
                Container(
                  width: 1,
                  height: 80,
                  color: AppTheme.darkSecondary,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: BlocBuilder<ProfessionalCubit, ProfessionalState>(
                      builder: (ctx, professionalState) {
                    return Column(children: [
                      if (professionalState is InitializingProfessionalState)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              width: 8,
                            ),
                            Text('chargement')
                          ],
                        ),
                      if (professionalState is NoProfessionnalFondState)
                        Container(
                            child: Column(
                          children: [
                            Text("Vous n'avez pas de profil professionel ")
                          ],
                        )),
                      if (professionalState is ProfessionalErrorState)
                        GestureDetector(
                          onTap: () => professionalCubit.getInitialState(),
                          child: Container(
                              width: MediaQuery.of(context).size.width * .4,
                              child: Column(
                                children: [
                                  Text(
                                    "une erreur estr survenue appuyer pour recharger",
                                    maxLines: 2,
                                  )
                                ],
                              )),
                        ),
                      if (professionalState is ProfessionalLoggedState)
                        Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AccountScreen()));
                                    },
                                    child: const UserProfilePicture(size: 80)),
                                SizedBox(
                                  width: 24,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.userName ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      user.phone ?? '',
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
                              ],
                            ),
                          ],
                        )
                    ]);
                  }),
                )
              ]),
              Divider(),
              BlocBuilder<ThemeModeCubit, ThemeMode>(builder: (context, mode) {
                return ListTile(
                  leading: Icon(
                      mode == ThemeMode.dark
                          ? Icons.dark_mode
                          : mode == ThemeMode.light
                              ? Icons.light_mode
                              : Icons.auto_awesome_mosaic,
                      size: 26),
                  title: const Text('Thème'),
                  subtitle: Text(mode.settingsName),
                  trailing:
                      toSvgIcon(icon: Assets.iconsDirectionRight, size: 16.0),
                  onTap: onThemeTap,
                );
              }),
              _buildListTile(
                context,
                icon: Icons.favorite_border,
                title: 'Your favorites',
                subtitle: 'Reorder your favorite service in a click',
              ),
              _buildListTile(
                context,
                icon: Icons.payment_outlined,
                title: 'Payments',
                subtitle: 'Payment methods, Transaction History',
              ),
              _buildListTile(
                context,
                icon: Icons.location_on_outlined,
                title: 'Manage Address',
              ),
              _buildListTile(
                context,
                icon: Icons.notifications_none,
                title: 'Notifications',
                subtitle: 'View your past notifications',
              ),
              _buildListTile(
                context,
                icon: Icons.work_outline,
                title: 'Register as partner',
                subtitle: 'Want to list your service? Register with us',
              ),
              _buildListTile(
                context,
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'Privacy Policy, Terms of Services, Licenses',
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Logout',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Logout action
                },
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.red),
              ),
              ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text('Version'),
                subtitle: Text(preferencesService.packageInfo.version),
              ),
            ],
          ),
        ),
      );
    });
  }

  void onThemeTap() {
    final themeModeCubit = context.read<ThemeModeCubit>();
    showAppBottomSheet(
        context: context,
        horizontalPadding: 16.0,
        builder: (context) => ListView.separated(
              itemBuilder: (_, i) {
                final mode = ThemeMode.values.elementAt(i);
                final selected = themeModeCubit.state == mode;
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    themeModeCubit.set(mode);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: switch (Theme.of(context).brightness) {
                          Brightness.light => selected
                              ? Theme.of(context).colorScheme.primary
                              : AppTheme.lightGrey,
                          Brightness.dark => selected
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest,
                        },
                        child: Icon(
                          [
                            Icons.auto_awesome_mosaic,
                            Icons.light_mode,
                            Icons.dark_mode
                          ][i],
                          color: switch (Theme.of(context).brightness) {
                            Brightness.light => Colors.black,
                            Brightness.dark =>
                              Theme.of(context).colorScheme.onSurfaceVariant,
                          },
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        mode.settingsName,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: selected ? FontWeight.bold : null),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 16.0),
              itemCount: 3,
              padding: EdgeInsets.only(top: 24.0),
              shrinkWrap: true,
            ));
  }
}

Widget _buildListTile(BuildContext context,
    {required IconData icon, required String title, String? subtitle}) {
  return ListTile(
    leading: Icon(icon, size: 26),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
    subtitle: subtitle != null
        ? Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          )
        : null,
    trailing: toSvgIcon(icon: Assets.iconsDirectionRight, size: 16.0),
    onTap: () {
      // Add navigation or action here
    },
  );
}
