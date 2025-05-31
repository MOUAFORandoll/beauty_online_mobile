import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/common/services/preferences_service.dart';
import 'package:beauty/common/services/user_service.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:beauty/notifications/models/notification.dart';
import 'package:beauty/notifications/services/notification_service.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart' hide PreferencesService;
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final PreferencesService preferencesService;
  final NotificationService notificationService;
  final UserService userService;
  final ProfessionalService professionalService;
  NotificationCubit(this.preferencesService, this.notificationService,
      this.userService, this.professionalService)
      : super(const NotificationInitialState());

  Future<void> requestNotificationPermission() {
    return notificationService.requestPermission((token) {
      preferencesService.deviceToken.then((oldToken) {
        print('new token ${token}');
        print('oldToken  ${oldToken}');
        print('status  ${oldToken == token}');
        if (oldToken == token) return;
        userService.sendFCMToken(token: token).then((_) {
          preferencesService.saveDeviceToken(token);
        });
      });
    });
  }

  Future<void> onNotification({required Notification notification}) async {
    final id = notification.refId;

    switch (notification.type) {
      case NotificationType.newRdv:
      case NotificationType.rdvAccepted:
      case NotificationType.rdvRefused:
        if (id.isNotEmpty) {
          await findRendezVous(id: id, type: notification.type);
        } else {
          emit(NotificationErrorState("ID manquant pour la notification"));
        }
        break;

      default:
        emit(const NotificationInitialState());
    }
  }

  findRendezVous({required String id, required String type}) async {
    final stateBefore = state;
    emit(RdvNotificationLoadingState());

    try {
      final rdv = await professionalService.findRendezVous(id);
      if (type == NotificationType.newRdv) {
        emit(RdvProNotificationSuccessLoadState(rdv));
      } else if (type == NotificationType.rdvAccepted ||
          type == NotificationType.rdvRefused) {
        emit(RdvClientNotificationSuccessLoadState(rdv));
      } else {
        // emit(RdvClientNotificationSuccessLoadState(rdv));
      }
    } catch (error, trace) {
      emit(NotificationErrorState(error, trace));
    }
    // emit(stateBefore);
  }
}
