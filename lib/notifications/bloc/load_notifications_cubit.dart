import 'package:beauty/notifications/models/notification.dart';
import 'package:beauty/notifications/services/notifications_service.dart';
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/auto_content/bloc/auto_content_cubit.dart';

class LoadNotificationsCubit
    extends AutoListCubit<Notification> {
  final NotificationsService notificationsService;
  final String type;

  LoadNotificationsCubit({
    required this.notificationsService,
    required this.type,
  }) : super(
            provider: ({page = 1}) => notificationsService.getNotifications(
                  page: page,
                  type: type,
                ));
}

abstract class TypeNotifications {
     static const String generale = 'GENERALE';
   static const String rdv ='RENDEZ-VOUS';
   static const String nouveaute = 'NOUVEAUTE';
}
