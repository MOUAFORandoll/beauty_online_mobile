import 'dart:io';

import 'package:beauty/common/models/professional.dart';
import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/notifications/models/notification.dart';
import 'package:path/path.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/models/user.dart';
import 'package:beauty/common/services/api_service.dart';

class NotificationsService extends ApiService { 
  static const String _userNotifications = '/users/notifications';
  static const String _findProfileById = '/profile-professionnels/{id}'; 
  static const String _findActuById = '/actus/{id}';
  static const String _rendezVous = '/rendez-vous/{id}';

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

  Future<Professional> findProfileById({required String id}) {
    return compute(
        dio.get(_findProfileById.replaceAll('{id}', id),
            options: Options(headers: withAuth())),
        mapper: Professional.fromJson);
  }

  Future<Actu> findActuById({required String id}) {
    return compute(
        dio.get(_findActuById.replaceAll('{id}', id),
            options: Options(headers: withAuth())),
        mapper: Actu.fromJson);
  }


  Future<RendezVous> fetchRdv({required String id}) {
    return compute(
        dio.get(_rendezVous.replaceAll('{id}', id),
            options: Options(headers: withAuth())),
        mapper: RendezVous.fromJson);
  }

}
