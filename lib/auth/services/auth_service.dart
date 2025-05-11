import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/auth/models/auth_response.dart';
import 'package:beauty/common/models/user.dart';
import 'package:beauty/common/services/api_service.dart';

class AuthService extends ApiService {
  static const String _auth = '/auth';
  static const String _completeProfile = '/users';
  const AuthService(super._dio);

  Future<AuthResponse> authUser({
    required String token,
  }) {
    return compute(
      dio.post(
        _auth,
        data: {
          "token": token,
        },
      ),
      mapper: AuthResponse.fromJson,
    );
  }

  Future<User> completeUserProfile({
    required String userName,
    required String phone,
    required String countryCode,
    required String codePhone,
  }) {
    return compute(
      dio.patch(
        _completeProfile,
        options: Options(headers: withAuth()),
        data: {
          'countryCode': countryCode,
          'phone': phone,
          'userName': userName,
          'codePhone': codePhone,
        },
      ),
      mapper: User.fromJson,
    );
  }
}
