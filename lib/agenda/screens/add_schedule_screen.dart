import 'package:flutter/material.dart' ;
import 'package:flutter_bloc/flutter_bloc.dart' ;
import 'package:table_calendar/table_calendar.dart';
import '../cubit/add_schedule_cubit.dart' ;
import '../cubit/schedule_cubit.dart'  ;
import '../models/schedule.dart' ;

class AddScheduleScreen extends StatelessWidget {
  const AddScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddScheduleCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ajouter une disponibilité'),
          backgroundColor: Colors.purple[800],
        ),
        body: BlocBuilder<AddScheduleCubit, AddScheduleState>(
          builder: (context, state) {
            if (state is AddScheduleInitial) {
              return _buildAddScheduleForm(context, state);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildAddScheduleForm(BuildContext context, AddScheduleInitial state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Sélectionnez une date',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TableCalendar(
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      focusedDay: state.selectedDate,
                      selectedDayPredicate: (day) {
                        return isSameDay(state.selectedDate, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        context
                            .read<AddScheduleCubit>()
                            .selectDate(selectedDay);
                      },
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: Colors.purple[800],
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.purple[200],
                          shape: BoxShape.circle,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          color: Colors.purple[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Time slots section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Créneaux horaires',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _showAddTimeSlotDialog(context),
                          icon: const Icon(Icons.add),
                          label: const Text('Ajouter'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple[800],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (state.timeSlots.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'Aucun créneau ajouté',
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.timeSlots.length,
                        itemBuilder: (context, index) {
                          final slot = state.timeSlots[index];
                          return Card(
                            color: Colors.purple[50],
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(
                                '${slot.startTime.formaTime()} - ${slot.endTime.formaTime()}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  context
                                      .read<AddScheduleCubit>()
                                      .removeTimeSlot(index);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.timeSlots.isEmpty
                    ? null
                    : () {
                        final schedule =
                            context.read<AddScheduleCubit>().createSchedule();
                        context.read<ScheduleCubit>().addSchedule(schedule);
                        Navigator.of(context).pop();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[800],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  disabledBackgroundColor: Colors.grey[300],
                ),
                child: const Text(
                  'Enregistrer',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTimeSlotDialog(BuildContext context) {
    TimeOfDay? startTime;
    TimeOfDay? endTime;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Ajouter un créneau'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Heure de début'),
                  subtitle: startTime != null
                      ? Text(
                          '${startTime!.hour}:${startTime!.minute.toString().padLeft(2, '0')}')
                      : const Text('Non définie'),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 9, minute: 0),
                    );
                    if (time != null) {
                      setState(() {
                        startTime = time;
                      });
                    }
                  },
                ),
                ListTile(
                  title: const Text('Heure de fin'),
                  subtitle: endTime != null
                      ? Text(
                          '${endTime!.hour}:${endTime!.minute.toString().padLeft(2, '0')}')
                      : const Text('Non définie'),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 18, minute: 0),
                    );
                    if (time != null) {
                      setState(() {
                        endTime = time;
                      });
                    }
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: startTime != null && endTime != null
                    ? () {
                        final newSlot = TimeSlot(
                          startTime: TimeOfDay(
                            hour: startTime!.hour,
                            minute: startTime!.minute,
                          ),
                          endTime: TimeOfDay(
                            hour: endTime!.hour,
                            minute: endTime!.minute,
                          ),
                        );

                        if (newSlot.isValid()) {
                          context.read<AddScheduleCubit>().addTimeSlot(newSlot);
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'L\'heure de fin doit être après l\'heure de début'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    : null,
                child: const Text('Ajouter'),
              ),
            ],
          );
        },
      ),
    );
  }
}
