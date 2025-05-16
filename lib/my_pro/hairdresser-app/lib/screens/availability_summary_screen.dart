import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../cubits/availability_cubit.dart';
import '../models/availability_model.dart';
import 'add_availability_screen.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/availability_details_widget.dart';

class AvailabilitySummaryScreen extends StatelessWidget {
  const AvailabilitySummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityCubit, AvailabilityState>(
      builder: (context, state) {
        if (state is AvailabilityInitial) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is AvailabilityLoaded) {
          final selectedDate = state.selectedDate;
          final dayAvailability = state.getAvailabilityForDate(selectedDate);

          return Scaffold(
            body: Column(
              children: [
                // Calendrier
                CalendarWidget(
                  selectedDate: selectedDate,
                  availabilities: state.availabilities,
                  onDateSelected: (date) {
                    context.read<AvailabilityCubit>().selectDate(date);
                  },
                ),

                // Détails de disponibilité
                Expanded(
                  child: AvailabilityDetailsWidget(
                    selectedDate: selectedDate,
                    dayAvailability: dayAvailability,
                    onEdit: (availability) =>
                        _editAvailability(context, availability),
                    onDelete: (availability) =>
                        _deleteAvailability(context, availability),
                    onDeletePeriod: (date, periodIndex) {
                      context
                          .read<AvailabilityCubit>()
                          .deletePeriod(date, periodIndex);
                    },
                  ),
                ),
                
              ],
            ),
            floatingActionButton: dayAvailability == null
                ? FloatingActionButton.extended(
                    onPressed: () => _addNewAvailability(context, selectedDate),
                    icon: const Icon(Icons.add),
                    label: const Text('Ajouter disponibilité'),
                  )
                : null,
          );
        }

        return const Scaffold(
          body: Center(
            child: Text('Une erreur est survenue'),
          ),
        );
      },
    );
  }

  void _addNewAvailability(BuildContext context, DateTime selectedDate) async {
    final result = await Navigator.push<DayAvailability?>(
      context,
      MaterialPageRoute(
        builder: (context) => AddAvailabilityScreen(
          initialDate: selectedDate,
        ),
      ),
    );

    if (result != null) {
      context.read<AvailabilityCubit>().saveAvailability(result);
    }
  }

  void _editAvailability(
      BuildContext context, DayAvailability availability) async {
    final result = await Navigator.push<DayAvailability?>(
      context,
      MaterialPageRoute(
        builder: (context) => AddAvailabilityScreen(
          initialDate: availability.date,
          initialPeriods: availability.periods,
        ),
      ),
    );

    if (result != null) {
      context.read<AvailabilityCubit>().saveAvailability(result);
    }
  }

  void _deleteAvailability(BuildContext context, DayAvailability availability) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content:
            const Text('Voulez-vous vraiment supprimer cette disponibilité ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<AvailabilityCubit>()
                  .deleteAvailability(availability.date);
              Navigator.pop(context);
            },
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
