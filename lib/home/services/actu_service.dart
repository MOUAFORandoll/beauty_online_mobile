import 'dart:io';

import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/models/search_result.dart';
import 'package:path/path.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/models/user.dart';
import 'package:beauty/common/services/api_service.dart';
import 'package:share_plus/share_plus.dart';

class ActuService extends ApiService {
  static const String _findActu = '/actus';
  static const String _shareActu = '/actus/:id/share';
  static const String _vueActu = '/actus/:id/vue';
  static const String _likeActu = '/actus/:id/like';
  static const String _search = '/actus/search';

  const ActuService(super._dio);

  Future<PaginatedList<SearchResult>> search({
    required String search,
    int page = 1,
  }) {
    return compute(
        dio.get(_search,
            options: Options(headers: withAuth()),
            queryParameters: {
              'page': page,
              'search': search,
            }),
        mapper: (result) => toPaginatedList(result, SearchResult.fromJson));
  }

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

  Future<String> shareActu({required String id}) {
    return compute(
        dio.get(
          _shareActu.replaceAll(':id', id),
          options: Options(headers: withAuth()),
        ),
        mapperKey: 'shareLink');
  }

  Future<void> vueActu({required String id}) {
    return compute(
      dio.get(
        _vueActu.replaceAll(':id', id),
        options: Options(headers: withAuth()),
      ),
    );
  }

  Future<void> likeUnlikeActu({required String id}) {
    return compute(
      dio.post(
        _likeActu.replaceAll(':id', id),
        options: Options(headers: withAuth()),
      ),
    );
  }
}
