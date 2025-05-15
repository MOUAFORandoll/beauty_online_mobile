import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../models/availability_model.dart';

// États
abstract class AvailabilityState extends Equatable {
  const AvailabilityState();
  
  @override
  List<Object> get props => [];
}

class AvailabilityInitial extends AvailabilityState {}

class AvailabilityLoaded extends AvailabilityState {
  final List<DayAvailability> availabilities;
  final DateTime selectedDate;
  
  const AvailabilityLoaded({
    required this.availabilities,
    required this.selectedDate,
  });
  
  @override
  List<Object> get props => [availabilities, selectedDate];
  
  AvailabilityLoaded copyWith({
    List<DayAvailability>? availabilities,
    DateTime? selectedDate,
  }) {
    return AvailabilityLoaded(
      availabilities: availabilities ?? this.availabilities,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
  
  DayAvailability? getAvailabilityForDate(DateTime date) {
    try {
      return availabilities.firstWhere((dayAvail) => 
        dayAvail.date.year == date.year && 
        dayAvail.date.month == date.month && 
        dayAvail.date.day == date.day
      );
    } catch (e) {
      return null;
    }
  }
  
  bool hasAvailability(DateTime date) {
    return availabilities.any((dayAvail) => 
      dayAvail.date.year == date.year && 
      dayAvail.date.month == date.month && 
      dayAvail.date.day == date.day
    );
  }
}

// Cubit
class AvailabilityCubit extends Cubit<AvailabilityState> {
  AvailabilityCubit() : super(AvailabilityInitial()) {
    // Initialiser avec des données d'exemple
    _loadInitialData();
  }
  
  void _loadInitialData() {
    final now = DateTime.now();
    
    final List<DayAvailability> initialData = [
      DayAvailability(
        date: now,
        periods: [
          AvailabilityPeriod(
            startTime: const TimeOfDay(hour: 9, minute: 0),
            endTime: const TimeOfDay(hour: 12, minute: 0),
          ),
          AvailabilityPeriod(
            startTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 18, minute: 0),
          ),
        ],
      ),
      DayAvailability(
        date: DateTime(now.year, now.month, now.day + 1),
        periods: [
          AvailabilityPeriod(
            startTime: const TimeOfDay(hour: 10, minute: 0),
            endTime: const TimeOfDay(hour: 16, minute: 0),
          ),
        ],
      ),
      DayAvailability(
        date: DateTime(now.year, now.month, now.day + 3),
        periods: [
          AvailabilityPeriod(
            startTime: const TimeOfDay(hour: 9, minute: 0),
            endTime: const TimeOfDay(hour: 13, minute: 0),
          ),
          AvailabilityPeriod(
            startTime: const TimeOfDay(hour: 15, minute: 0),
            endTime: const TimeOfDay(hour: 19, minute: 0),
          ),
        ],
      ),
    ];
    
    emit(AvailabilityLoaded(
      availabilities: initialData,
      selectedDate: now,
    ));
  }
  
  // Changer la date sélectionnée
  void selectDate(DateTime date) {
    if (state is AvailabilityLoaded) {
      final currentState = state as AvailabilityLoaded;
      emit(currentState.copyWith(selectedDate: date));
    }
  }
  
  // Ajouter ou mettre à jour une disponibilité
  void saveAvailability(DayAvailability availability) {
    if (state is AvailabilityLoaded) {
      final currentState = state as AvailabilityLoaded;
      final availabilities = List<DayAvailability>.from(currentState.availabilities);
      
      // Vérifier si la date existe déjà
      final existingIndex = availabilities.indexWhere(
        (dayAvail) => dayAvail.isSameDay(availability.date)
      );
      
      if (existingIndex >= 0) {
        // Mettre à jour l'existant
        availabilities[existingIndex] = availability;
      } else {
        // Ajouter un nouveau
        availabilities.add(availability);
      }
      
      emit(currentState.copyWith(availabilities: availabilities));
    }
  }
  
  // Supprimer une disponibilité
  void deleteAvailability(DateTime date) {
    if (state is AvailabilityLoaded) {
      final currentState = state as AvailabilityLoaded;
      final availabilities = List<DayAvailability>.from(currentState.availabilities);
      
      availabilities.removeWhere((dayAvail) => dayAvail.isSameDay(date));
      
      emit(currentState.copyWith(availabilities: availabilities));
    }
  }
  
  // Supprimer une période spécifique
  void deletePeriod(DateTime date, int periodIndex) {
    if (state is AvailabilityLoaded) {
      final currentState = state as AvailabilityLoaded;
      final availabilities = List<DayAvailability>.from(currentState.availabilities);
      
      final index = availabilities.indexWhere((dayAvail) => dayAvail.isSameDay(date));
      
      if (index >= 0) {
        final dayAvail = availabilities[index];
        final periods = List<AvailabilityPeriod>.from(dayAvail.periods);
        
        if (periodIndex >= 0 && periodIndex < periods.length) {
          periods.removeAt(periodIndex);
          
          if (periods.isEmpty) {
            // Si plus de périodes, supprimer la journée entière
            availabilities.removeAt(index);
          } else {
            // Sinon mettre à jour avec les périodes restantes
            availabilities[index] = dayAvail.copyWith(periods: periods);
          }
          
          emit(currentState.copyWith(availabilities: availabilities));
        }
      }
    }
  }
}
