import 'package:flutter/material.dart';

class AvailabilityPeriod {
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  AvailabilityPeriod({required this.startTime, required this.endTime});

  // Méthodes pour comparer et valider les périodes
  bool isValid() {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;
    return endMinutes > startMinutes;
  }

  bool overlaps(AvailabilityPeriod other) {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;
    final otherStartMinutes = other.startTime.hour * 60 + other.startTime.minute;
    final otherEndMinutes = other.endTime.hour * 60 + other.endTime.minute;

    return startMinutes < otherEndMinutes && endMinutes > otherStartMinutes;
  }

  // Pour la sérialisation/désérialisation (si nécessaire)
  Map<String, dynamic> toJson() {
    return {
      'startHour': startTime.hour,
      'startMinute': startTime.minute,
      'endHour': endTime.hour,
      'endMinute': endTime.minute,
    };
  }

  factory AvailabilityPeriod.fromJson(Map<String, dynamic> json) {
    return AvailabilityPeriod(
      startTime: TimeOfDay(hour: json['startHour'], minute: json['startMinute']),
      endTime: TimeOfDay(hour: json['endHour'], minute: json['endMinute']),
    );
  }

  // Clone avec modifications
  AvailabilityPeriod copyWith({
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  }) {
    return AvailabilityPeriod(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}

class DayAvailability {
  final DateTime date;
  final List<AvailabilityPeriod> periods;

  DayAvailability({required this.date, required this.periods});

  // Méthodes utilitaires
  bool get isEmpty => periods.isEmpty;
  bool get isNotEmpty => periods.isNotEmpty;

  // Vérifier si toutes les périodes sont valides et ne se chevauchent pas
  bool arePeriodsValid() {
    if (periods.isEmpty) return true;
    
    // Vérifier que chaque période est valide
    for (var period in periods) {
      if (!period.isValid()) return false;
    }
    
    // Vérifier qu'il n'y a pas de chevauchement
    for (int i = 0; i < periods.length; i++) {
      for (int j = i + 1; j < periods.length; j++) {
        if (periods[i].overlaps(periods[j])) return false;
      }
    }
    
    return true;
  }

  // Pour la sérialisation/désérialisation (si nécessaire)
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'periods': periods.map((p) => p.toJson()).toList(),
    };
  }

  factory DayAvailability.fromJson(Map<String, dynamic> json) {
    return DayAvailability(
      date: DateTime.parse(json['date']),
      periods: (json['periods'] as List)
          .map((p) => AvailabilityPeriod.fromJson(p))
          .toList(),
    );
  }

  // Clone avec modifications
  DayAvailability copyWith({
    DateTime? date,
    List<AvailabilityPeriod>? periods,
  }) {
    return DayAvailability(
      date: date ?? this.date,
      periods: periods ?? List.from(this.periods),
    );
  }

  // Comparer les dates sans l'heure
  bool isSameDay(DateTime other) {
    return date.year == other.year && 
           date.month == other.month && 
           date.day == other.day;
  }
}
