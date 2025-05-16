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
  AddScheduleCubit() : super(AddScheduleInitial(
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

  void addTimeSlot(TimeSlot timeSlot) {
    if (!timeSlot.isValid()) {
      return; // Don't add invalid time slots
    }
    
    final currentState = state as AddScheduleInitial;
    final updatedSlots = List<TimeSlot>.from(currentState.timeSlots)..add(timeSlot);
    
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

  Schedule createSchedule() {
    final currentState = state as AddScheduleInitial;
    return Schedule(
      date: currentState.selectedDate,
      timeSlots: currentState.timeSlots,
    );
  }
}
