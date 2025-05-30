import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/my_pro/bloc/gestion_professional_cubit.dart';
import 'package:beauty/my_pro/bloc/load_me_agenda_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../bloc/add_schedule_cubit.dart';
import '../../bloc/schedule_cubit.dart';
import '../../models/schedule.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen>
    with CompletableMixin {
  late final gestionProfessionalCubit =
      context.read<GestionProfessionalCubit>();
  late final cubit = context.read<LoadMeAgendaCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une disponibilité'),
      ),
      body: _buildAddScheduleForm(context),
    );
  }

  void onEventReceived(
      BuildContext context, GestionProfessionalState state) async {
    await waitForDialog();
    if (state is AddAgendaLoadingState) {
      loadingDialogCompleter = showLoadingBarrier(context: context);
    }

    if (state is AddAgendaSuccessState) {
      cubit.putFirst(state.agenda);
      context.read<AddScheduleCubit>().cleanTimeSlot();
      showSuccessToast(context: context, content: 'Agenda ajouté avec succès!');
    }
    if (state is GestionProfessionalErrorState) {
      showErrorToast(context: context, content: state.error);
    }
  }

  Widget _buildAddScheduleForm(BuildContext context) {
    return BlocBuilder<AddScheduleCubit, AddScheduleState>(
        builder: (context, state) {
      final stateF = state as AddScheduleInitial;
      return BlocConsumer<GestionProfessionalCubit, GestionProfessionalState>(
          listener: onEventReceived,
          builder: (ctx, stateG) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
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
                                    lastDay: DateTime.now()
                                        .add(const Duration(days: 365)),
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
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      todayDecoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                    headerStyle: HeaderStyle(
                                      formatButtonVisible: false,
                                      titleCentered: true,
                                      titleTextStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Créneaux horaires',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      BeautyButton.primary(
                                        onPressed: () =>
                                            _showAddTimeSlotDialog(context),
                                        icon: const Icon(Icons.add),
                                        text:'Ajouter', 
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  if (stateF.timeSlots.isEmpty)
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: stateF.timeSlots.length,
                                      itemBuilder: (context, index) {
                                        final slot = stateF.timeSlots[index];
                                        return Card(
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          child: ListTile(
                                            title: Text(
                                              '${slot.startTime.formaTime()} - ${slot.endTime.formaTime()}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            trailing: IconButton(
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.red),
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
                        ])),
                    const SizedBox(height: 20),
                    BeautyButton.primary(
                      onPressed: stateF.timeSlots.isEmpty
                          ? null
                          : () {
                              final schedule = context
                                  .read<AddScheduleCubit>()
                                  .createSchedule();

                              gestionProfessionalCubit.addAgenda(
                                  schedule: schedule);
                            },
                      text: "Enregistrer",
                    ),
                  ],
                ),
              ));
    });
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
                child: Text(
                  'Annuler',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
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

                        if (!newSlot.isValid()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'L\'heure de fin doit être après l\'heure de début'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final hasNoConflict = context
                            .read<AddScheduleCubit>()
                            .isCorrectTimeSlot(newSlot);

                        if (!hasNoConflict) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Ce créneau chevauche un autre déjà existant.'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }

                        context.read<AddScheduleCubit>().addTimeSlot(newSlot);
                        Navigator.of(context).pop();
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
