import 'dart:io';

import 'package:beauty/home/models/actu.dart';
import 'package:path/path.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/models/user.dart';
import 'package:beauty/common/services/api_service.dart';
import 'package:share_plus/share_plus.dart';

class ActuService extends ApiService {
  static const String _findActu = '/actus';
  const ActuService(super._dio);

  Future<PaginatedList<Actu>> findActu({
    int page = 1,
  }) {
    return compute(
        dio.get(_findActu,
            options: Options(headers: withAuth()),
            queryParameters: {
              'page': page,
              'size': 12,
            }),
        mapper: (result) => toPaginatedList(result, Actu.fromJson));
  }
}
