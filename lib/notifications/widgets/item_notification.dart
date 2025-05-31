import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/common/utils/text_utils.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/my_pro/screens/sub/my_rendez_vous_pro_view.dart';
import 'package:beauty/notifications/models/notification_model.dart';
import 'package:beauty/professional/screens/sub/rendez_vous_user_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemNotification extends StatelessWidget {
  final NotificationModel notification;

  const ItemNotification({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => actionForType(context: context, type: notification.type),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getNotificationTypeString(notification.type),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(notification.message,
                  style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }

  actionForType({required BuildContext context, required String type}) {
    print(type);
    print(type);
    switch (type) {
      case NotificationModelType.welcome:
      case NotificationModelType.generale:
        return;
      case NotificationModelType.newRdv:
        return showAppBottomSheet(
            context: context,
            maxHeight: MediaQuery.of(context).size.height * .8,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return MyRendezVousProView(
                  rendezVous: RendezVous.fromJson(notification.data!));
            });
      case NotificationModelType.rdvAccepted:
      case NotificationModelType.rdvRefused:
        return showAppBottomSheet(
            context: context,
            maxHeight: MediaQuery.of(context).size.height * .8,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return RendezVousUserView(
                  rendezVous: RendezVous.fromJson(notification.data!));
            });
      case NotificationModelType.newFeature:
      case NotificationModelType.bestConsultants:
        return;
      default:
        return;
    }
  }

  String getNotificationTypeString(String type) {
    switch (type) {
      case NotificationModelType.welcome:
        return 'Bienvenue';
      case NotificationModelType.generale:
        return 'Générale';
      case NotificationModelType.newRdv:
        return 'Nouveau RDV';
      case NotificationModelType.rdvAccepted:
        return 'RDV Accepté';
      case NotificationModelType.rdvRefused:
        return 'RDV Refusé';
      case NotificationModelType.newFeature:
        return 'Nouvelle Fonctionnalité';
      case NotificationModelType.bestConsultants:
        return 'Meilleurs Consultants';
      default:
        return 'Générale';
    }
  }
}
