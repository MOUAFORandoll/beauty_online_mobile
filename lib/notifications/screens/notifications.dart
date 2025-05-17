import 'package:beauty/my_pro/screens/sub/rendez_vous_pro.dart';
import 'package:beauty/notifications/screens/sub/generales.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/professional/screens/sub/rendez_vous_user.dart';
import 'package:flutter/material.dart' hide SearchBar;

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<String> items = [
    'Générales',
    'Mes Rendez-vous',
    'Rendez-vous Pro',
  ];
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(children: [
          SizedBox(
            height: 16,
          ),
          // _TabBarGap(controller: _scrollController),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: items
                  .map((item) => ItemHome(
                        label: item,
                        isSelected: _selected == items.indexOf(item),
                        onTap: () => setState(() {
                          _selected = items.indexOf(item);
                        }),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 8.0),

          Divider(),

          const SizedBox(height: 8.0),
          Expanded(
            child: _bodyBuilder(),
          )
        ]));
  }

  Widget _bodyBuilder() {
    switch (_selected) {
      case 0:
        return Generales();
      case 1:
        return RendezVousUser();
      case 2:
        return RendezVousPro();
      default:
        return Generales();
    }
  }
}

class ItemHome extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  ItemHome(
      {required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16.0))
            : null,
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: isSelected ? AppTheme.black : AppTheme.disabledText,
              ),
        ),
      ),
    );
  }
}
