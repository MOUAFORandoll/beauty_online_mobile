import 'dart:io';

import 'package:beauty/Professional/models/professional.dart';
import 'package:path/path.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/models/user.dart';
import 'package:beauty/common/services/api_service.dart';

class ProfessionalService extends ApiService {
  static const String _createUserProfile = '/profile-professionnels';
  static const String _findAllProfiles = '/profile-professionnels';
  static const String _findUserProfile = '/profile-professionnels/me';
  static const String _filterProfiles = '/profile-professionnels/filter';
  static const String _findProfileById = '/profile-professionnels/{id}';
  static const String _updateUserProfile = '/profile-professionnels/{id}';
  static const String _deleteProfile = '/profile-professionnels/{id}';
  static const String _findProfilesByProximity =
      '/profile-professionnels/proximity';
  static const String _updateUserPosition =
      '/profile-professionnels/{id}/update-position';

  const ProfessionalService(super._dio);

  Future<Professional> createUserProfile({
    required Map data
  }) {
    return compute(
        dio.post(_createUserProfile,
            options: Options(headers: withAuth()), data: data),
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

  Future<Professional> updateUserProfile(
      {required String id, required Professional profile}) {
    return compute(dio.put(_updateUserProfile.replaceAll('{id}', id),
        options: Options(headers: withAuth()), data: profile.toJson()));
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
}
