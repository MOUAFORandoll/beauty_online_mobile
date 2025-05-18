import 'dart:io';

import 'package:path/path.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/models/user.dart';
import 'package:beauty/common/services/api_service.dart';

class UserService extends ApiService {
  static const String _getMe = '/users/me';

  static const String _get = '/users/:id';
  static const String _follow = '/users/follow';
  static const String _unfollow = '/users/unfollow';
  static const String _block = '/users/:userId/block';
  static const String _unblock = '/users/:userId/unblock';
  static const String _blockedUsers = '/users/block';
  static const String _updateUser = '/users';
  static const String _updateProfilePicture = '/users/picture';
  static const String _userFollowers = '/users/followers';
  static const String _userFollowing = '/users/following';
  static const String _logout = '/users/logout';
  static const String _delete = '/users';
  static const String _catalogueView = '/users/catalogues-viewed';
  static const String _catalogueWatchlist = '/users/catalogues-watchlist';
  static const String _posts = '/posts';
  static const String _quizUser = '/quiz';
  static const String _shareUser = '/users/:idUser/share';
  static const String _sendFCMToken = '/users/notification';
  static const String _searchUser = '/users';
  const UserService(super._dio);

  Future<void> sendFCMToken({required String token}) {
    return compute(dio.patch(_sendFCMToken,
        options: Options(headers: withAuth()),
        data: {"notification_token": token}));
  }

  Future<User> getMe() {
    return compute(
        dio.get(
          _getMe,
          options: Options(headers: withAuth()),
        ),
        mapper: User.fromJson);
  }

  Future<User> getUser({required String user}) {
    return compute(
        dio.get(
          _get.replaceAll(':id', user),
          options: Options(headers: withAuth()),
        ),
        mapper: User.fromJson);
  }

  Future<String> shareUser({required String idUser}) {
    return compute(
        dio.get(
          _shareUser.replaceAll(':idUser', idUser),
          options: Options(headers: withAuth()),
        ),
        mapperKey: 'shareLink');
  }

  Future<User> follow({required String user}) async {
    return compute(
        dio.post(
          _follow,
          data: {
            'idFollowing': user,
          },
          options: Options(headers: withAuth()),
        ),
        mapper: User.fromJson);
  }

  Future<User> unFollow({required String user}) async {
    return compute(
        dio.delete(
          _unfollow,
          data: {
            'idFollowing': user,
          },
          options: Options(headers: withAuth()),
        ),
        mapper: User.fromJson);
  }

  Future<PaginatedList<User>> getBlockedUsers({int page = 1}) async {
    return compute(
        dio.get(_blockedUsers,
            options: Options(headers: withAuth()),
            queryParameters: {
              'page': page,
              'size': 12,
            }),
        mapper: (result) => toPaginatedList(result, User.fromJson));
  }

  Future<User> blockUser({required String user}) async {
    return compute(
        dio.post(
          _block.replaceAll(':userId', user),
          data: {
            'reason': null,
          },
          options: Options(headers: withAuth()),
        ),
        mapper: User.fromJson);
  }

  Future<User> unBlockUser({required String user}) async {
    return compute(
        dio.post(
          _unblock.replaceAll(':userId', user),
          options: Options(headers: withAuth()),
        ),
        mapper: User.fromJson);
  }

  Future<User> updateUser(
      {int? type, String? data, String? countryCode, String? codePhone}) {
    print(
      {
        if (type == 0) 'userName': data,
        if (type == 1) 'phone': data,
        if (type == 1) 'countryCode': countryCode,
        if (type == 1) 'codePhone': codePhone,
      },
    );
    return compute(
        dio.patch(
          _updateUser,
          data: {
            if (type == 0) 'userName': data,
            if (type == 1) 'phone': data,
            if (type == 1) 'countryCode': countryCode,
            if (type == 1) 'codePhone': codePhone,
          },
          options: Options(headers: withAuth()),
        ),
        mapper: User.fromJson);
  }

  Future<User> updateProfilePicture({required File file}) async {
    return compute(
        dio.patch(_updateProfilePicture,
            options: Options(headers: withAuth()),
            data: FormData.fromMap({
              'image': await MultipartFile.fromFile(file.path,
                  filename: basename(file.path))
            })),
        mapper: User.fromJson);
  }

  Future<void> logout() {
    return compute(
      dio.post(
        _logout,
        options: Options(headers: withAuth()),
      ),
    );
  }

  Future<void> deleteAccount(String firebaseUid) {
    return compute(
      dio.delete(
        _delete,
        data: {'firebase_uid': firebaseUid},
        options: Options(headers: withAuth()),
      ),
    );
  }

  Future<PaginatedList<User>> searchUser(
      {required String search, int page = 1, CancelToken? cancelToken}) async {
    return compute(
        dio.get(_searchUser,
            queryParameters: {
              'search': search,
              'page': page,
            },
            options: Options(headers: withAuth()),
            cancelToken: cancelToken),
        mapper: (result) => toPaginatedList(result, User.fromJson));
  }
}
