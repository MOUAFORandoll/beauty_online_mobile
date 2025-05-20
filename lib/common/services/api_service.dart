import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart' as potatoes;
import 'api_error.dart';

class ApiLinks extends potatoes.Links {
  const ApiLinks();

//Box
  // @override
  // String get devUrl => "http://192.168.1.129:8080/api";

  // @override
  // String get stagingUrl => "http://192.168.1.129:8080/api";

  // @override
  // String get productionUrl => "http://192.168.1.129:8080/api";

//Online
  // @override
  String get devUrl => "https://api.beauty.petite-monnaie.com";

  // @override
  String get stagingUrl => "https://api.beauty.petite-monnaie.com";

  // @override
  String get productionUrl => "https://api.beauty.petite-monnaie.com";

  static const privacy = 'https://www.beauty.app/privacy-policy';
}

class ApiService extends potatoes.ApiService {
  final CacheOptions? cacheOptions;

  const ApiService(super._dio, [this.cacheOptions]);

  @override
  Future<T> compute<T>(
    Future<Response<dynamic>> request, {
    String? mapperKey,
    T Function(Map<String, dynamic> p1)? mapper,
    T Function(String p1)? messageMapper,
  }) async {
    assert(mapper == null || messageMapper == null);
    try {
      Response response = await request;
      if (response.data.toString().isEmpty) {
        return response.data;
      }
      if (response.data != null) {
        return defaultExtractResult(
          response.data,
          mapperKey,
          mapper,
          messageMapper,
        );
      } else {
        if (response.data['error'] != null) {
          throw response.data['error'];
        }
        throw response.data['detail'];
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        if ((e.response!.data as Map<String, dynamic>)['error'] != null) {
          print('====================');
          print(e.response!);
          print('====================');

          print(e.response!.data['error']);
          throw ApiError.fromApi(
            e.response!.data['error'],
          );
        } else {
          throw ApiError.fromDio(e);
        }
      } else {
        throw ApiError.fromDio(e);
      }
    } on Map<String, dynamic> catch (errors, s) {
      throw ApiError.fromApi(errors, s);
    } on String catch (e) {
      throw ApiError.unknown(e);
    } catch (e, s) {
      throw ApiError.unknown(e.toString(), s);
    }
  }

  PaginatedList<T> toPaginatedList<T>(
    Map<String, dynamic> data,
    T Function(Map<String, dynamic> item) mapper,
  ) {
    return PaginatedList(
      items: (data['content'] as List<dynamic>)
          .map((e) => mapper(e as Map<String, dynamic>))
          .toList(),
      page: data['page'],
      total: data['total'],
    );
  }
}

Future<CacheOptions> cacheStoreOptions() {
  return getTemporaryDirectory().then((directory) {
    return CacheOptions(
      store: MemCacheStore(),
      maxStale: const Duration(minutes: 5),
      policy: CachePolicy.noCache,
    );
  });
}
