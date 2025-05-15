import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../models/availability_model.dart';

// États
abstract class AddAvailabilityState extends Equatable {
  const AddAvailabilityState();
  
  @override
  List<Object> get props => [];
}

class AddAvailabilityInitial extends AddAvailabilityState {}

class AddAvailabilityEditing extends AddAvailabilityState {
  final DateTime selectedDate;
  final List<AvailabilityPeriod> periods;
  final bool isValid;
  
  const AddAvailabilityEditing({
    required this.selectedDate,
    required this.periods,
    required this.isValid,
  });
  
  @override
  List<Object> get props => [selectedDate, periods, isValid];
  
  AddAvailabilityEditing copyWith({
    DateTime? selectedDate,
    List<AvailabilityPeriod>? periods,
    bool? isValid,
  }) {
    return AddAvailabilityEditing(
      selectedDate: selectedDate ?? this.selectedDate,
      periods: periods ?? this.periods,
      isValid: isValid ?? this.isValid,
    );
  }
}

// Cubit
class AddAvailabilityCubit extends Cubit<AddAvailabilityState> {
  AddAvailabilityCubit({
    required DateTime initialDate,
    List<AvailabilityPeriod>? initialPeriods,
  }) : super(AddAvailabilityInitial()) {
    // Initialiser avec les données fournies ou des valeurs par défaut
    final periods = initialPeriods ?? [
      AvailabilityPeriod(
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 17, minute: 0),
      )
    ];
    
    emit(AddAvailabilityEditing(
      selectedDate: initialDate,
      periods: periods,
      isValid: _validatePeriods(periods),
    ));
  }
  
  // Valider toutes les périodes
  bool _validatePeriods(List<AvailabilityPeriod> periods) {
    if (periods.isEmpty) return true;
    
    // Vérifier que chaque période est valide
    for (var period in periods) {
      if (!_isTimeValid(period)) return false;
    }
    
    // Vérifier qu'il n'y a pas de chevauchement
    for (int i = 0; i < periods.length; i++) {
      for (int j = i + 1; j < periods.length; j++) {
        if (periods[i].overlaps(periods[j])) return false;
      }
    }
    
    return true;
  }
  
  // Vérifier qu'une période est valide
  bool _isTimeValid(AvailabilityPeriod period) {
    final startMinutes = period.startTime.hour * 60 + period.startTime.minute;
    final endMinutes = period.endTime.hour * 60 + period.endTime.minute;
    return endMinutes > startMinutes;
  }
  
  // Changer la date sélectionnée
  void selectDate(DateTime date) {
    if (state is AddAvailabilityEditing) {
      final currentState = state as AddAvailabilityEditing;
      emit(currentState.copyWith(selectedDate: date));
    }
  }
  
  // Mettre à jour l'heure de début d'une période
  void updateStartTime(int periodIndex, TimeOfDay time) {
    if (state is AddAvailabilityEditing) {
      final currentState = state as AddAvailabilityEditing;
      final periods = List<AvailabilityPeriod>.from(currentState.periods);
      
      if (periodIndex >= 0 && periodIndex < periods.length) {
        periods[periodIndex] = periods[periodIndex].copyWith(startTime: time);
        emit(currentState.copyWith(
          periods: periods,
          isValid: _validatePeriods(periods),
        ));
      }
    }
  }
  
  // Mettre à jour l'heure de fin d'une période
  void updateEndTime(int periodIndex, TimeOfDay time) {
    if (state is AddAvailabilityEditing) {
      final currentState = state as AddAvailabilityEditing;
      final periods = List<AvailabilityPeriod>.from(currentState.periods);
      
      if (periodIndex >= 0 && periodIndex < periods.length) {
        periods[periodIndex] = periods[periodIndex].copyWith(endTime: time);
        emit(currentState.copyWith(
          periods: periods,
          isValid: _validatePeriods(periods),
        ));
      }
    }
  }
  
  // Ajouter une nouvelle période
  void addPeriod() {
    if (state is AddAvailabilityEditing) {
      final currentState = state as AddAvailabilityEditing;
      final periods = List<AvailabilityPeriod>.from(currentState.periods);
      
      // Trouver une heure de début après la dernière période
      TimeOfDay lastEndTime = periods.last.endTime;
      TimeOfDay newStartTime = TimeOfDay(
        hour: lastEndTime.hour + 1 > 23 ? 23 : lastEndTime.hour + 1,
        minute: lastEndTime.minute,
      );
      
      TimeOfDay newEndTime = TimeOfDay(
        hour: newStartTime.hour + 1 > 23 ? 23 : newStartTime.hour + 1,
        minute: newStartTime.minute,
      );
      
      periods.add(AvailabilityPeriod(
        startTime: newStartTime,
        endTime: newEndTime,
      ));
      
      emit(currentState.copyWith(
        periods: periods,
        isValid: _validatePeriods(periods),
      ));
    }
  }
  
  // Supprimer une période
  void removePeriod(int index) {
    if (state is AddAvailabilityEditing) {
      final currentState = state as AddAvailabilityEditing;
      final periods = List<AvailabilityPeriod>.from(currentState.periods);
      
      if (index >= 0 && index < periods.length) {
        periods.removeAt(index);
        emit(currentState.copyWith(
          periods: periods,
          isValid: _validatePeriods(periods),
        ));
      }
    }
  }
  
  // Obtenir la disponibilité finale
  DayAvailability? getAvailability() {
    if (state is AddAvailabilityEditing) {
      final currentState = state as AddAvailabilityEditing;
      if (currentState.isValid) {
        return DayAvailability(
          date: currentState.selectedDate,
          periods: currentState.periods,
        );
      }
    }
    return null;
  }
}
