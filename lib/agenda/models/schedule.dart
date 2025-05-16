import 'package:beauty/common/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Schedule {
  final DateTime date;
  final List<TimeSlot> timeSlots;

  Schedule({required this.date, required this.timeSlots});

  String get formattedDate {
    final dateFormat = DateFormat('EEEE d MMMM yyyy', 'fr_FR');

    return dateFormat.format(date).capitalize();
  }

  String get availabilityText {
    if (timeSlots.isEmpty) return 'Aucune disponibilité';

    final slots = timeSlots
        .map((slot) =>
            '${slot.startTime.formaTime()} - ${slot.endTime.formaTime()}')
        .join(', ');
    return slots;
  }
}

class TimeSlot {
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  TimeSlot({required this.startTime, required this.endTime});

  bool isValid() {
    // Convert to minutes for comparison
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;
    return endMinutes > startMinutes;
  }
}

extension Time on TimeOfDay {
  String formaTime() {
    final hourString = hour.toString().padLeft(2, '0');
    final minuteString = minute.toString().padLeft(2, '0');
    return '$hourString:$minuteString';
  }
}
