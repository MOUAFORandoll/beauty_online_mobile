import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/common/utils/text_utils.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/professional/screens/sub/rendez_vous_user_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RendezVousItem extends StatelessWidget {
  final RendezVous rendezVous;

  const RendezVousItem({
    super.key,
    required this.rendezVous,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAppBottomSheet(
            context: context,
            maxHeight: MediaQuery.of(context).size.height * .8,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return RendezVousUserView(
                rendezVous: rendezVous,
              );
            });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage(rendezVous.professional.cover ?? ''),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(rendezVous.professional.namePro,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                        DateFormat('EEEE d MMMM yyyy', 'fr_FR')
                            .format(rendezVous.day.toLocal())
                            .capitalize(),
                        style: TextStyle(color: Colors.grey[600])),
                    Text(
                        '${rendezVous.creneau.startTimeAvailable} - ${rendezVous.creneau.endTimeAvailable}',
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 8),
                    Text(rendezVous.realisation.title,
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text('${rendezVous.realisation.price} €',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.green)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor(rendezVous.status),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  rendezVous.status,
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Color statusColor(String status) {
  switch (status) {
    case 'ACCEPTE':
      return Colors.green;
    case 'REFUSE':
      return Colors.red;
    case 'EN ATTENTE':
    default:
      return Colors.orange;
  }
}
