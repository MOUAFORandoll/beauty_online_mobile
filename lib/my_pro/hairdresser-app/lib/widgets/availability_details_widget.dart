import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/availability_model.dart';

class AvailabilityDetailsWidget extends StatelessWidget {
  final DateTime selectedDate;
  final DayAvailability? dayAvailability;
  final Function(DayAvailability) onEdit;
  final Function(DayAvailability) onDelete;
  final Function(DateTime, int) onDeletePeriod;

  const AvailabilityDetailsWidget({
    Key? key,
    required this.selectedDate,
    required this.dayAvailability,
    required this.onEdit,
    required this.onDelete,
    required this.onDeletePeriod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE d MMMM', 'fr_FR');

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _capitalize(dateFormat.format(selectedDate)),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (dayAvailability != null)
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => onEdit(dayAvailability!),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (dayAvailability == null || dayAvailability!.periods.isEmpty)
                Container(
                  child: Center(
                    child: Text(
                      'Aucune disponibilité définie pour cette journée',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: dayAvailability!.periods.length,
                  itemBuilder: (context, index) {
                    final period = dayAvailability!.periods[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const Icon(Icons.access_time),
                        title: Text(
                          '${period.startTime.format(context)} - ${period.endTime.format(context)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: dayAvailability!.periods.length > 1
                            ? IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () {
                                  onDeletePeriod(selectedDate, index);
                                },
                              )
                            : null,
                      ),
                    );
                  },
                ),
            ]),
          )),
        ],
      ),
      bottomNavigationBar: (dayAvailability != null)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Supprimer'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () => onDelete(dayAvailability!),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Ajouter une période'),
                  onPressed: () => onEdit(dayAvailability!),
                ),
              ],
            )
          : null,
    );
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
