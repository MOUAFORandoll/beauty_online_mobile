import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/schedule.dart';

// States
abstract class AddScheduleState {}

class AddScheduleInitial extends AddScheduleState {
  final DateTime selectedDate;
  final List<TimeSlot> timeSlots;

  AddScheduleInitial({
    required this.selectedDate,
    this.timeSlots = const [],
  });
}

// Cubit
class AddScheduleCubit extends Cubit<AddScheduleState> {
  AddScheduleCubit()
      : super(AddScheduleInitial(
          selectedDate: DateTime.now(),
          timeSlots: [],
        ));

  void selectDate(DateTime date) {
    final currentState = state as AddScheduleInitial;
    emit(AddScheduleInitial(
      selectedDate: date,
      timeSlots: currentState.timeSlots,
    ));
  }

  bool isCorrectTimeSlot(TimeSlot newSlot) {
    if (!newSlot.isValid()) return false;

    final currentState = state as AddScheduleInitial;

    final hasConflict = currentState.timeSlots.any((slot) => _isOverlapping(
        slot.startTime, slot.endTime, newSlot.startTime, newSlot.endTime));

    return !hasConflict;
  }
bool _isOverlapping(
      TimeOfDay start1, TimeOfDay end1, TimeOfDay start2, TimeOfDay end2) {
    final s1 = _toMinutes(start1);
    final e1 = _toMinutes(end1);
    final s2 = _toMinutes(start2);
    final e2 = _toMinutes(end2);

    return s1 < e2 && s2 < e1;
  }

  int _toMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

  void addTimeSlot(TimeSlot timeSlot) {
    if (!timeSlot.isValid()) {
      return; // Don't add invalid time slots
    }

    final currentState = state as AddScheduleInitial;
    final updatedSlots = List<TimeSlot>.from(currentState.timeSlots)
      ..add(timeSlot);

    emit(AddScheduleInitial(
      selectedDate: currentState.selectedDate,
      timeSlots: updatedSlots,
    ));
  }

  void removeTimeSlot(int index) {
    final currentState = state as AddScheduleInitial;
    final updatedSlots = List<TimeSlot>.from(currentState.timeSlots);

    if (index >= 0 && index < updatedSlots.length) {
      updatedSlots.removeAt(index);
    }

    emit(AddScheduleInitial(
      selectedDate: currentState.selectedDate,
      timeSlots: updatedSlots,
    ));
  }

  void cleanTimeSlot() {
    final currentState = state as AddScheduleInitial;
    print('cleanTimeSlot');
    emit(AddScheduleInitial(
      selectedDate: currentState.selectedDate,
      timeSlots: [],
    ));
  }

  Schedule createSchedule() {
    final currentState = state as AddScheduleInitial;
    return Schedule(
      date: currentState.selectedDate,
      timeSlots: currentState.timeSlots,
    );
  }
}
