import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class Notification with _$Notification {
  
  const factory Notification({required String type, required String rdvId}) =
      _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}

abstract class NotificationType {
  static const String general = 'general';
  static const String newRdv = 'new_rdv';
  static const String rdvAccepted = 'rdv_accepted';
  static const String rdvRefused = 'rdv_refused';
  static const String newFeature = 'new_feature';
  static const String bestConsultants = 'best_consultants';
}
