import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../cubits/add_availability_cubit.dart';
import '../models/availability_model.dart';
import '../widgets/period_editor_widget.dart';

class AddAvailabilityScreen extends StatelessWidget {
  final DateTime initialDate;
  final List<AvailabilityPeriod>? initialPeriods;

  const AddAvailabilityScreen({
    Key? key,
    required this.initialDate,
    this.initialPeriods,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAvailabilityCubit(
        initialDate: initialDate,
        initialPeriods: initialPeriods,
      ),
      child: BlocBuilder<AddAvailabilityCubit, AddAvailabilityState>(
        builder: (context, state) {
          if (state is AddAvailabilityEditing) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Définir disponibilité'),
                centerTitle: true,
                elevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sélection de date
                    _buildDateSelector(context, state),

                    const SizedBox(height: 16),

                    // Titre des périodes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Périodes de disponibilité',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (state.periods.length < 5)
                          TextButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text('Ajouter'),
                            onPressed: () {
                              context.read<AddAvailabilityCubit>().addPeriod();
                            },
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Liste des périodes
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.periods.length,
                        itemBuilder: (context, index) {
                          return PeriodEditorWidget(
                            periodIndex: index,
                            period: state.periods[index],
                            canDelete: state.periods.length > 1,
                            onStartTimeChanged: (time) {
                              context
                                  .read<AddAvailabilityCubit>()
                                  .updateStartTime(index, time);
                            },
                            onEndTimeChanged: (time) {
                              context
                                  .read<AddAvailabilityCubit>()
                                  .updateEndTime(index, time);
                            },
                            onDelete: () {
                              context
                                  .read<AddAvailabilityCubit>()
                                  .removePeriod(index);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Annuler'),
                      ),
                      ElevatedButton(
                        onPressed: state.isValid
                            ? () {
                                final availability = context
                                    .read<AddAvailabilityCubit>()
                                    .getAvailability();
                                if (availability != null) {
                                  Navigator.pop(context, availability);
                                }
                              }
                            : null,
                        child: const Text('Enregistrer'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateSelector(
      BuildContext context, AddAvailabilityEditing state) {
    final dateFormat = DateFormat('EEEE d MMMM yyyy', 'fr_FR');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _capitalize(dateFormat.format(state.selectedDate)),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final cubit = context.read<AddAvailabilityCubit>();
    final state = cubit.state;

    if (state is AddAvailabilityEditing) {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: state.selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        locale: const Locale('fr', 'FR'),
      );

      if (picked != null && picked != state.selectedDate) {
        cubit.selectDate(picked);
      }
    }
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
