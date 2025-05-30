import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel(
      {required String id,
      required String type,
      required String message,
      Map<String, dynamic>? data}) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

abstract class NotificationModelType {
  static const String welcome = 'welcome';
  static const String generale = 'generale';
  static const String information = 'information';
  static const String newRdv = 'new_rdv';
  static const String rdvAccepted = 'rdv_accepted';
  static const String rdvRefused = 'rdv_refused';
  static const String newFeature = 'new_feature';
  static const String bestConsultants = 'best_consultants';
}
