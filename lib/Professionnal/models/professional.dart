import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:beauty/utils/datetime_converter.dart';
part 'professional.freezed.dart';
part 'professional.g.dart';
@freezed
class Professional with _$Professional {
  const Professional._();

  const factory Professional({
    required String id,
    required String namePro,
    required String service,
  }) = _Professional;

  factory Professional.fromJson(Map<String, dynamic> json) => _$ProfessionalFromJson(json);
}
