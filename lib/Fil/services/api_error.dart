import 'package:potatoes/potatoes.dart' as potatoes;
import 'package:beauty/common/models/error.dart';

class ApiError extends potatoes.ApiError {
  final Error? error;

  ApiError.fromDio(super.dio)
      : error = null,
        super.fromDio();

  const ApiError.unknown(super.message, [super.trace])
      : error = null,
        super.unknown();

  ApiError.fromApi(Map<String, dynamic> errors, [StackTrace? trace])
      : error = Error.fromJson(errors),
        super.unknown('error', trace);

  bool get isInternalServerError => super.statusCode == 500;

  @override
  List<Object?> get props => [...super.props, error];
}
