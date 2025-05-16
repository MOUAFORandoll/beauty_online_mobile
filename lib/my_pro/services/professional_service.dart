import 'dart:io';
import 'package:beauty/common/models/agenda.dart';
import 'package:beauty/common/models/catalogue.dart';

import 'package:beauty/common/models/professional.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/services/api_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart';

class ProfessionalService extends ApiService {
  static const String _createUserProfile = '/profile-professionnels';
  static const String _findAllProfiles = '/profile-professionnels';
  static const String _findUserProfile = '/profile-professionnels/me';
  static const String _filterProfiles = '/profile-professionnels/filter';
  static const String _findProfileById = '/profile-professionnels/{id}';
  static const String _updateUserProfile = '/profile-professionnels';
  static const String _updaterProfileCover = '/profile-professionnels/cover';

  static const String _deleteProfile = '/profile-professionnels/{id}';
  static const String _findProfilesByProximity =
      '/profile-professionnels/proximity';
  static const String _updateUserPosition =
      '/profile-professionnels/{id}/update-position';

  static const String _catalogue = '/realisations';
  static const String _agendas = '/agendas';

  const ProfessionalService(super._dio);

  Future<Professional> createUserProfile(
      {required Map<String, dynamic> data, required XFile? cover}) async {
    final FormData formData = FormData.fromMap(data);

    if (cover != null) {
      formData.files
          .add(MapEntry('cover', await MultipartFile.fromFile(cover.path)));
    }
    return compute(
        dio.post(_createUserProfile,
            options: Options(headers: withAuth()), data: formData),
        mapper: Professional.fromJson);
  }

  Future<PaginatedList<Professional>> findAllProfiles() {
    return compute(
        dio.get(_findAllProfiles, options: Options(headers: withAuth())),
        mapper: (result) => toPaginatedList(result, Professional.fromJson));
  }

  Future<Professional> findUserProfile() {
    return compute(
        dio.get(_findUserProfile, options: Options(headers: withAuth())),
        mapper: Professional.fromJson);
  }

  Future<PaginatedList<Professional>> filterProfiles({required String filter}) {
    return compute(
        dio.get(_filterProfiles,
            queryParameters: {'filter': filter},
            options: Options(headers: withAuth())),
        mapper: (result) => toPaginatedList(result, Professional.fromJson));
  }

  Future<Professional> findProfileById({required String id}) {
    return compute(
        dio.get(_findProfileById.replaceAll('{id}', id),
            options: Options(headers: withAuth())),
        mapper: Professional.fromJson);
  }

  Future<Professional> updateProfilePicture({required File file}) async {
    return compute(
        dio.patch(_updaterProfileCover,
            options: Options(headers: withAuth()),
            data: FormData.fromMap({
              'image': await MultipartFile.fromFile(file.path,
                  filename: basename(file.path))
            })),
        mapper: Professional.fromJson);
  }

  Future<Professional> updateProfilePro({
    required int? type,
    String? data,
  }) {
    print(
      {
        if (type == 0) 'name_pro': data,
        if (type == 1) 'description': data,
      },
    );
    return compute(
        dio.patch(
          _updateUserProfile,
          options: Options(headers: withAuth()),
          data: {
            if (type == 0) 'name_pro': data,
            if (type == 1) 'description': data,
          },
        ),
        mapper: Professional.fromJson);
  }

  Future<void> deleteProfile({required String id}) {
    return compute(dio.delete(_deleteProfile.replaceAll('{id}', id),
        options: Options(headers: withAuth())));
  }

  Future<PaginatedList<Professional>> findProfilesByProximity() {
    return compute(
        dio.get(_findProfilesByProximity,
            options: Options(headers: withAuth())),
        mapper: (result) => toPaginatedList(result, Professional.fromJson));
  }

  Future<void> updateUserPosition(
      {required String id,
      required double latitude,
      required double longitude}) {
    return compute(dio.patch(_updateUserPosition.replaceAll('{id}', id),
        options: Options(headers: withAuth()),
        data: {'latitude': latitude, 'longitude': longitude}));
  }

  Future<Catalogue> addCatalogue({
    required FormData data,
  }) async {
    return compute(
        dio.post(_catalogue, options: Options(headers: withAuth()), data: data),
        mapper: Catalogue.fromJson);
  }

  Future<PaginatedList<Catalogue>> meCatalogue({
    int page = 1,
  }) async {
    return compute(
        dio.get(_catalogue,
            options: Options(headers: withAuth()),
            queryParameters: {
              'page': page,
              'size': 12,
            }),
        mapper: (result) => toPaginatedList(result, Catalogue.fromJson));
  }

  Future<Agenda> addAgenda({
    required data,
  }) async {
    return compute(
        dio.post(_agendas, options: Options(headers: withAuth()), data: data),
        mapper: Agenda.fromJson);
  }

  Future deleteAgenda({
    required id,
  }) async {
    return compute(
      dio.delete(
        _agendas + '/${id}',
        options: Options(headers: withAuth()),
      ),
    );
  }

  Future<Agenda> addCreneau({
    required idAgenda,
    required data,
  }) async {
    return compute(
        dio.post(_agendas + '/${idAgenda}/creneau',
            options: Options(headers: withAuth()), data: data),
        mapper: Agenda.fromJson);
  }

  Future deleteCreneau({
    required idCreneau,
  }) async {
    return compute(
      dio.delete(
        _agendas + '/creneau/${idCreneau}',
        options: Options(headers: withAuth()),
      ),
    );
  }

  Future<PaginatedList<Agenda>> meAgenda({
    int page = 1,
  }) async {
    return compute(
        dio.get(_agendas,
            options: Options(headers: withAuth()),
            queryParameters: {
              'page': page,
              'size': 12,
            }),
        mapper: (result) => toPaginatedList(result, Agenda.fromJson));
  }

  Future<PaginatedList<Catalogue>> professionalCatalogue({
    int page = 1,
    required String id,
  }) async {
    return compute(
        dio.get(_catalogue + '/professional/${id}',
            options: Options(headers: withAuth()),
            queryParameters: {
              'page': page,
              'size': 12,
            }),
        mapper: (result) => toPaginatedList(result, Catalogue.fromJson));
  }

  Future<void> deleteCatalogue({required String id}) {
    return compute(dio.delete(_catalogue + '/${id}',
        options: Options(headers: withAuth())));
  }
}
