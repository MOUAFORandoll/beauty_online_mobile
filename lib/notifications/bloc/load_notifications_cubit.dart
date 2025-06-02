import 'package:beauty/notifications/models/notification_model.dart';
import 'package:beauty/notifications/services/notifications_service.dart';
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';

class LoadNotificationsCubit extends AutoListCubit<NotificationModel> {
  final NotificationsService notificationsService;

  LoadNotificationsCubit(
    this.notificationsService,
  ) : super(
            provider: ({page = 1}) => notificationsService.getNotifications(
                  page: page,
                ));
}

abstract class TypeNotifications {
  static const String generale = 'GENERALE';
  static const String rdv = 'RENDEZ-VOUS';
  static const String nouveaute = 'NOUVEAUTE';
}
