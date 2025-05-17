import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/schedule.dart';

// States
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<Schedule> schedules;

  ScheduleLoaded(this.schedules);
}

class ScheduleLoading extends ScheduleState {}

class ScheduleError extends ScheduleState {
  final String message;

  ScheduleError(this.message);
}

// Cubit
class ScheduleCubit extends Cubit<ScheduleState> {
  List<Schedule> _schedules = [];

  ScheduleCubit() : super(ScheduleInitial()) {
    loadSchedules();
  }

  void loadSchedules() {
    emit(ScheduleLoading());
    
    // In a real app, this would fetch from a database or API
    // For now, we'll use mock data
    _schedules = [
      Schedule(
        date: DateTime(2025, 5, 17),
        timeSlots: [
          TimeSlot(
            startTime: TimeOfDay(hour: 9, minute: 0),
            endTime: TimeOfDay(hour: 12, minute: 0),
          ),
          TimeSlot(
            startTime: TimeOfDay(hour: 14, minute: 0),
            endTime: TimeOfDay(hour: 18, minute: 0),
          ),
        ],
      ),
      Schedule(
        date: DateTime(2025, 5, 18),
        timeSlots: [
          TimeSlot(
            startTime: TimeOfDay(hour: 10, minute: 0),
            endTime: TimeOfDay(hour: 16, minute: 0),
          ),
        ],
      ),
    ];
    
    emit(ScheduleLoaded(_schedules));
  }

  void addSchedule(Schedule schedule) {
    emit(ScheduleLoading());
    
    // Check if a schedule for this date already exists
    final existingIndex = _schedules.indexWhere(
      (s) => s.date.year == schedule.date.year && 
             s.date.month == schedule.date.month && 
             s.date.day == schedule.date.day
    );
    
    if (existingIndex >= 0) {
      // Update existing schedule
      _schedules[existingIndex] = schedule;
    } else {
      // Add new schedule
      _schedules.add(schedule);
    }
    
    // Sort schedules by date
    _schedules.sort((a, b) => a.date.compareTo(b.date));
    
    emit(ScheduleLoaded(_schedules));
  }

  void deleteSchedule(DateTime date) {
    emit(ScheduleLoading());
    
    _schedules.removeWhere(
      (s) => s.date.year == date.year && 
             s.date.month == date.month && 
             s.date.day == date.day
    );
    
    emit(ScheduleLoaded(_schedules));
  }
}
