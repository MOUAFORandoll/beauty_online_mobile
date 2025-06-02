import 'package:beauty/common/widgets/empty_builder.dart';
import 'package:beauty/common/widgets/error_builder.dart';
import 'package:beauty/notifications/bloc/load_notifications_cubit.dart';
import 'package:beauty/notifications/models/notification_model.dart'
    show NotificationModel;
import 'package:beauty/notifications/widgets/item_notification.dart';
import 'package:flutter/material.dart' hide SearchBar, Notification;
import 'package:potatoes/auto_list/widgets/auto_list_view.dart';
import 'package:potatoes/libs.dart';

class Generales extends StatefulWidget {
  const Generales({super.key});

  @override
  State<Generales> createState() => _GeneralesState();
}

class _GeneralesState extends State<Generales> {
  late final loadNotificationsCubit = context.read<LoadNotificationsCubit>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          loadNotificationsCubit.reset();
          print('000000');
        },
        child: AutoListView.get<NotificationModel>(
          autoManage: false,
          cubit: loadNotificationsCubit,
          shrinkWrap: true,
          emptyBuilder: (context) => EmptyBuilder(),
          itemBuilder: (context, notification) =>
              ItemNotification(notification: notification),
          errorBuilder: (context, retry) => ErrorBuilder(retry: retry),
        ));
  }
}

// Container(
        // alignment: Alignment.center,
        // padding: EdgeInsets.symmetric(horizontal: 16),
        // child:
        //     Text('Generale', style: Theme.of(context).textTheme.labelLarge!))