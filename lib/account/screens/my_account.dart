import 'dart:io';

import 'package:beauty/account/bloc/theme_mode_cubit.dart';
import 'package:beauty/account/screens/my_user_info.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/notifications/bloc/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:open_settings/open_settings.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount>
    with
        SingleTickerProviderStateMixin,
        CompletableMixin,
        WidgetsBindingObserver {
  late final userCubit = context.read<UserCubit>();
  late final notificationCubit = context.read<NotificationCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchNotificationSettings();
  }

  Future<void> _fetchNotificationSettings() async {
    await FirebaseMessaging.instance.getNotificationSettings();
    setState(() {});
  }

  Future<NotificationSettings> _getNotificationSettings() {
    return FirebaseMessaging.instance.getNotificationSettings();
  }

  void _openNotificationSettings() {
    if (Platform.isAndroid) {
      OpenSettings.openNotificationSetting();
    } else if (Platform.isIOS) {
      OpenSettings.openAppNotificationSetting();
    }
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        BlocBuilder<ThemeModeCubit, ThemeMode>(
          builder: (context, mode) {
            return SettingsItem(
              icon: mode == ThemeMode.dark
                  ? Icons.dark_mode
                  : mode == ThemeMode.light
                      ? Icons.light_mode
                      : Icons.auto_awesome_mosaic,
              title: 'Thème',
              subtitle: mode.settingsName,
              onTap: _onThemeTap,
            );
          },
        ),
        const SizedBox(height: 16),
        SettingsSection(
          title: 'Compte',
          items: [
            SettingsItem(
              icon: Icons.person,
              title: 'Informations personnelles',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MyUserInfo()),
              ),
            ),
            SettingsItem(
                icon: Icons.lock, title: 'Confidentialité', onTap: () {}),
            SettingsItem(
                icon: Icons.notifications_none,
                title: 'Notifications',
                onTap: _onNotificationTap),
          ],
        ),
        const SizedBox(height: 16),
        SettingsSection(
          title: 'Support',
          items: [
            SettingsItem(
              icon: Icons.support_agent,
              title: 'Service client',
              onTap: () {
                final Uri uri = Uri(
                  scheme: 'https',
                  host: 'wa.me',
                  path: '/237690863838',
                  queryParameters: {
                    'text':
                        'Bonjour, j\'ai une question concernant beauty online.'
                  },
                );
                launchUrl(uri);
              },
            ),
            SettingsItem(
                icon: Icons.help_outline,
                title: 'Aide',
                onTap: () {
                  final Uri uri = Uri(
                    scheme: 'https',
                    host: 'www.beauty-online.fr',
                    path: '/help',
                  );
                  launchUrl(uri);
                }),
            SettingsItem(
                icon: Icons.group_add_outlined,
                title: 'Inviter un proche',
                onTap: () {
                  final Uri shareUri = Uri(
                    scheme: 'https',
                    host: 'www.beauty-online.fr',
                    path: '/invite',
                  );
                  final String shareMessage =
                      'Partagez ce lien avec vos amis et votre famille pour leur faire découvrir Beauty Online : ${shareUri.toString()}';
                  Share.share(shareMessage);
                }),
          ],
        ),
      ],
    );
  }

  void _onThemeTap() {
    final themeModeCubit = context.read<ThemeModeCubit>();
    showAppBottomSheet(
      context: context,
      horizontalPadding: 16.0,
      builder: (_) => ListView.separated(
        itemCount: ThemeMode.values.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 24.0),
        separatorBuilder: (_, __) => const SizedBox(height: 16.0),
        itemBuilder: (_, i) {
          final mode = ThemeMode.values[i];
          final selected = themeModeCubit.state == mode;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: selected
                  ? Theme.of(context).colorScheme.primary
                  : AppTheme.lightGrey,
              child: Icon(
                [
                  Icons.auto_awesome_mosaic,
                  Icons.light_mode,
                  Icons.dark_mode
                ][i],
                color: Colors.black,
                size: 20,
              ),
            ),
            title: Text(
              mode.settingsName,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: selected ? FontWeight.bold : null,
                  ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              themeModeCubit.set(mode);
            },
          );
        },
      ),
    );
  }

  void _onNotificationTap() {
    showAppBottomSheet(
      context: context,
      horizontalPadding: 16.0,
      builder: (_) => FutureBuilder<NotificationSettings>(
        future: _getNotificationSettings(),
        builder: (context, snapshot) {
          final settings = snapshot.data;
          final isAuthorized =
              settings?.authorizationStatus == AuthorizationStatus.authorized;
          return SwitchListTile(
            title: const Text('Notifications'),
            subtitle: Text(isAuthorized ? 'Activées' : 'Désactivées'),
            value: isAuthorized,
            onChanged: (_) async {
              if (settings?.authorizationStatus ==
                  AuthorizationStatus.notDetermined) {
                await notificationCubit.requestNotificationPermission();
                setState(() {});
              } else {
                _openNotificationSettings();
              }
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String? title;
  final List<SettingsItem> items;

  const SettingsSection({super.key, this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              title!,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  item,
                  if (index < items.length - 1)
                    Divider(color: Colors.grey.shade800, height: 1, indent: 56),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData? icon;
  final Widget? customIcon;
  final String title;
  final String? subtitle;
  final String? badge;
  final VoidCallback? onTap;

  const SettingsItem({
    super.key,
    this.icon,
    this.customIcon,
    required this.title,
    this.subtitle,
    this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            if (icon != null) Icon(icon, size: 24),
            if (customIcon != null && icon == null)
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                child: customIcon,
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400)),
                  if (subtitle != null)
                    Text(subtitle!,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            if (badge != null)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(badge!,
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
            toSvgIcon(icon: Assets.iconsDirectionRight, size: 16.0),
          ],
        ),
      ),
    );
  }
}
