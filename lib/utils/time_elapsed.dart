import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/bloc/server_time_cubit.dart';

extension TimeElapsed on DateTime {
  String elapsed({required BuildContext context, bool withFuture = false}) {
    final duration =
        context.read<ServerTimeCubit>().currentTime.difference(this);
    final isFuture = duration.isNegative && withFuture;
    final absDuration = duration.abs();

    if (absDuration.inMinutes < 1) {
      return isFuture ? 'dans un instant' : 'à l\'instant';
    }
    if (absDuration.inHours < 1) {
      final minutes = absDuration.inMinutes;
      return '${isFuture ? "dans" : "il y a"} $minutes minute${minutes < 2 ? "" : "s"}';
    }
    if (absDuration.inDays < 1) {
      final hours = absDuration.inHours;
      return '${isFuture ? "dans" : "il y a"} $hours heure${hours < 2 ? "" : "s"}';
    }
    if (absDuration.inDays == 1 && !isFuture) {
      return 'hier';
    }
    if (absDuration.inDays < 7) {
      final days = absDuration.inDays;
      return '${isFuture ? "dans" : "il y a"} $days jour${days < 2 ? "" : "s"}';
    }
    if (absDuration.inDays < 30) {
      final weeks = absDuration.inDays ~/ 7;
      return '${isFuture ? "dans" : "il y a"} $weeks semaine${weeks < 2 ? "" : "s"}';
    }
    if (absDuration.inDays < 365) {
      final months = absDuration.inDays ~/ 30;
      return '${isFuture ? "dans" : "il y a"} $months mois';
    }
    final years = absDuration.inDays ~/ 365;
    return '${isFuture ? "dans" : "il y a"} $years an${years < 2 ? "" : "s"}';
  }
}

String formatDuration(int totalSeconds) {
  final duration = Duration(seconds: totalSeconds);
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  if (duration.inHours > 0) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  } else {
    return '$minutes:$seconds';
  }
}
