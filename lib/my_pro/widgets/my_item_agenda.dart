import 'package:beauty/common/utils/text_utils.dart';
import 'package:beauty/my_pro/bloc/gestion_professional_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/my_pro/screens/sub/catalogue_for_pro_details.dart.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/models/agenda.dart';
import 'package:beauty/my_pro/bloc/load_me_agenda_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potatoes/auto_list/widgets/auto_list_view.dart';
import '../bloc/schedule_cubit.dart';
import '../models/schedule.dart';
import 'package:intl/intl.dart';

class MyAgendaItem extends StatelessWidget {
  final Agenda agenda;

  const MyAgendaItem(
    this.agenda,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // onTap: () => showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return CatalogueForProDialog(
        //       catalogue: catalogue,
        //     );
        //   },
        // ),
        child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        title: Text(
          DateFormat('EEEE d MMMM yyyy', 'fr_FR')
              .format(agenda.day.toLocal())
              .capitalize(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: agenda.creneaux.map((creneau) {
                return GestureDetector(
                    onTap: () {
                      // _showDeleteCreneauConfirmation(context, creneau);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${creneau.startTimeAvailable} - ${creneau.endTimeAvailable}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ));
              }).toList(),
            ),
            const SizedBox(height: 8),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            _showDeleteConfirmation(context, agenda);
          },
        ),
      ),
    ));
  }

  void _showDeleteConfirmation(BuildContext context, Agenda agenda) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer cette disponibilité?'),
        content: Text(
            'Voulez-vous vraiment supprimer la disponibilité du ${DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(agenda.day)}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Annuler',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<GestionProfessionalCubit>()
                  .deleteAgenda(agenda: agenda);
              Navigator.of(context).pop();
            },
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDeleteCreneauConfirmation(BuildContext context, Creneau creneau) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le creneau ?'),
        content: Text(
            'Voulez-vous vraiment supprimer le crenau ${creneau.startTimeAvailable} - ${creneau.endTimeAvailable} du ${DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(agenda.day).capitalize()}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Annuler',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<GestionProfessionalCubit>()
                  .deleteCreneau(creneau: creneau);
              Navigator.of(context).pop();
            },
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
