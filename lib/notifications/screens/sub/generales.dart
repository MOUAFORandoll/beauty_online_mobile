import 'package:beauty/common/widgets/empty_builder.dart';
import 'package:beauty/common/widgets/error_builder.dart';
import 'package:beauty/common/widgets/filter_buttons.dart';
import 'package:beauty/common/widgets/horizontal_service_list.dart';
import 'package:beauty/common/widgets/location_selector.dart';
import 'package:beauty/common/widgets/post_list.dart';
import 'package:beauty/common/widgets/salon_card_list.dart';
import 'package:beauty/common/widgets/search_bar.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:beauty/notifications/bloc/load_notifications_cubit.dart';
import 'package:beauty/notifications/services/notifications_service.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:flutter/material.dart' hide SearchBar, Notification;
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/auto_list/widgets/auto_list_view.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/notifications/models/notification.dart';

class Generales extends StatefulWidget {
  const Generales({super.key});

  @override
  State<Generales> createState() => _GeneralesState();
}

class _GeneralesState extends State<Generales> {
  late final loadNotificationsCubit = LoadNotificationsCubit(
      notificationsService: context.read<NotificationsService>(),
      type: TypeNotifications.generale);

  @override
  Widget build(BuildContext context) {
    return AutoListView.get<Notification>(
      autoManage: false,
      cubit: loadNotificationsCubit,
      shrinkWrap: true,
      emptyBuilder: (context) => EmptyBuilder(),
      itemBuilder: (context, notification) => Container(),
      errorBuilder: (context, retry) => ErrorBuilder(retry: retry),
    );
  }
}

// Container(
        // alignment: Alignment.center,
        // padding: EdgeInsets.symmetric(horizontal: 16),
        // child:
        //     Text('Generale', style: Theme.of(context).textTheme.labelLarge!))