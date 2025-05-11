import 'package:beauty/account/screens/my_user_info.dart';
import 'package:beauty/account/widgets/head.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:share_plus/share_plus.dart';
import 'package:beauty/account/screens/settings/edit_profile.dart';
import 'package:beauty/account/screens/settings/edit_profile_picture_screen.dart';
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

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount>
    with SingleTickerProviderStateMixin, CompletableMixin {
  late final userCubit = context.read<UserCubit>();
  late final user = userCubit.user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Second section
        SettingsSection(
          items: [
            SettingsItem(
              icon: Icons.key,
              title: 'Compte',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MyUserInfo()),
                );
              },
            ),
            SettingsItem(
              icon: Icons.lock,
              title: 'Confidentialité',
              onTap: () {},
            ),
            SettingsItem(
              icon: Icons.chat_bubble_outline,
              title: 'Discussions',
              badge: '1',
              onTap: () {},
            ),
            SettingsItem(
              icon: Icons.notifications_none,
              title: 'Notifications',
              onTap: () {},
            ),
            SettingsItem(
              icon: Icons.swap_vert,
              title: 'Stockage et données',
              onTap: () {},
            ),
          ],
        ),

        SizedBox(
          height: 16,
        ),
        // Third section
        SettingsSection(
          items: [
            SettingsItem(
              icon: Icons.info_outline,
              title: 'Aide',
              onTap: () {},
            ),
            SettingsItem(
              icon: Icons.people_outline,
              title: 'Inviter un proche',
              onTap: () {},
            ),
          ],
        ),

        // Meta products section
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
          child: Text(
            'Mes Sociaux',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
        SettingsSection(
          items: [
            SettingsItem(
              icon: Icons.camera_alt,
              title: 'Mon Instagram',
              onTap: () {},
            ),
            SettingsItem(
              icon: Icons.camera_alt,
              title: 'Mon Tiktok',
              onTap: () {},
            ),
            SettingsItem(
              icon: Icons.camera_alt,
              title: 'Mon Snap',
              onTap: () {},
            ),
          ],
        ),

        // Add some space at the bottom
        const SizedBox(height: 80),
      ],
    );
  }
}

class SettingsSection extends StatelessWidget {
  final List<SettingsItem> items;

  const SettingsSection({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return Column(
            children: [
              item,
              // Add divider except for the last item
              if (index < items.length - 1)
                Divider(
                  color: Colors.grey.shade800,
                  height: 1,
                  indent: 56,
                  endIndent: 0,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData? icon;
  final Widget? customIcon;
  final String title;
  final String? badge;
  final VoidCallback onTap;

  const SettingsItem({
    Key? key,
    this.icon,
    this.customIcon,
    required this.title,
    this.badge,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            // Icon
            if (icon != null)
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  // color: Colors.white,
                  size: 24,
                ),
              ),
            if (customIcon != null && icon == null)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF833AB4),
                      Color(0xFFC13584),
                      Color(0xFFE1306C),
                      Color(0xFFFD1D1D),
                      Color(0xFFF56040),
                      Color(0xFFF77737),
                      Color(0xFFFCAF45),
                      Color(0xFFFFDC80),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Icon(
                  customIcon as IconData,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            const SizedBox(width: 16),

            // Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // Badge
            if (badge != null)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),

            // Chevron
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade600,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

// Custom status bar for iOS style (for demonstration)
class StatusBar extends StatelessWidget {
  const StatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '11:44',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.signal_cellular_alt,
                  size: 16, color: Colors.white),
              const SizedBox(width: 4),
              const Text('LTE', style: TextStyle(color: Colors.white)),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '72%',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
