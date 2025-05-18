import 'dart:io';

import 'package:beauty/notifications/models/notification.dart';
import 'package:path/path.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/models/user.dart';
import 'package:beauty/common/services/api_service.dart';

class NotificationsService extends ApiService { 
  static const String _userNotifications = '/users/notifications';
  const NotificationsService(super._dio);
 

  Future<PaginatedList<Notification>> getNotifications(
      {int page = 1, required String type}) async {
    return compute(
        dio.get(_userNotifications,
            options: Options(headers: withAuth()),
            queryParameters: {
              'page': page,
              'type': type,
              'size': 12,
            }),
        mapper: (result) => toPaginatedList(result, Notification.fromJson));
  }
}
