import 'package:beauty/common/widgets/filter_buttons.dart';
import 'package:beauty/common/widgets/horizontal_service_list.dart';
import 'package:beauty/common/widgets/location_selector.dart';
import 'package:beauty/common/widgets/post_list.dart';
import 'package:beauty/common/widgets/salon_card_list.dart';
import 'package:beauty/common/widgets/search_bar.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:beauty/notifications/screens/sub/generales.dart';
import 'package:beauty/notifications/screens/sub/news.dart';
import 'package:beauty/notifications/screens/sub/rendez_vous.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:flutter/material.dart' hide SearchBar;

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<String> items = ['Générales', 'Mes Rendez-vous', 'Nouveautés'];
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          // _TabBarGap(controller: _scrollController),
          Container(
            height: 32.0,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => Container(
                      width: 12,
                    ),
                itemCount: items.length,
                itemBuilder: (ctx, i) => ItemHome(
                      label: items[i],
                      isSelected: _selected == i,
                      onTap: () => setState(() {
                        _selected = i;
                      }),
                    )),
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
        return RendezVous();
      case 2:
        return News();
      default:
        return Container();
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
        padding: EdgeInsets.symmetric(horizontal: 16),
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
