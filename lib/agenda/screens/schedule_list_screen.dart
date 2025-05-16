import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/schedule_cubit.dart';
import '../models/schedule.dart';
import 'add_schedule_screen.dart';

class ScheduleListScreen extends StatelessWidget {
  const ScheduleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        if (state is ScheduleLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ScheduleLoaded) {
          return _buildScheduleList(context, state.schedules);
        } else if (state is ScheduleError) {
          return Center(child: Text('Erreur: ${state.message}'));
        } else {
          return const Center(child: Text('Aucune disponibilité'));
        }
      },
    );
  }

  Widget _buildScheduleList(BuildContext context, List<Schedule> schedules) {
    if (schedules.isEmpty) {
      return const Center(
        child: Text(
          'Aucune disponibilité configurée',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          child: ListTile(
            title: Text(
              schedule.formattedDate,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                ...schedule.timeSlots.map((slot) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${slot.startTime.formaTime()} - ${slot.endTime.formaTime()}',
                        style: TextStyle(
                          color: Colors.purple[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 8),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _showDeleteConfirmation(context, schedule);
              },
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Schedule schedule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer cette disponibilité?'),
        content: Text(
            'Voulez-vous vraiment supprimer la disponibilité du ${schedule.formattedDate}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              context.read<ScheduleCubit>().deleteSchedule(schedule.date);
              Navigator.of(context).pop();
            },
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
