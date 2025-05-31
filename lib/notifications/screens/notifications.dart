import 'package:beauty/my_pro/bloc/my_professional_cubit.dart';
import 'package:beauty/my_pro/screens/sub/rendez_vous_pro.dart';
import 'package:beauty/notifications/screens/sub/generales.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/professional/screens/sub/rendez_vous_user.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:potatoes/libs.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<String> items = [
    'Toutes',
    'Mes Rendez-vous',
    'Rendez-vous Pro',
  ];

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: BlocBuilder<MyProfessionalCubit, MyProfessionalState>(
        builder: (ctx, state) {
          final isPro = state is MyProfessionalLoggedState;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(height: 16),
              _buildTabBar(isPro),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Expanded(child: _buildTabContent(isPro)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabBar(bool isPro) {
    if (!isPro) {
      return NotificationTabItem(
        label: 'Mes Rendez-vous',
        isSelected: true,
        onTap: () => setState(() => _selected = 1),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(items.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: NotificationTabItem(
              label: items[index],
              isSelected: _selected == index,
              onTap: () => setState(() => _selected = index),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTabContent(bool isPro) {
    if (_selected == 0) {
      return const Generales();
    }
    if (!isPro || _selected == 1) {
      return const RendezVousUser();
    } else if (_selected == 2) {
      return const RendezVousPro();
    }
    return const SizedBox.shrink();
  }
}

class NotificationTabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NotificationTabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : theme.colorScheme.onSurface.withOpacity(0.2),
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge!.copyWith(
            color: isSelected
                ? Colors.white
                : theme.textTheme.labelLarge!.color?.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
