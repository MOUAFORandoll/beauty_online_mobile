import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/availability_model.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDate;
  final List<DayAvailability> availabilities;
  final Function(DateTime) onDateSelected;

  const CalendarWidget({
    Key? key,
    required this.selectedDate,
    required this.availabilities,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _displayedMonth;
  final DateFormat _monthFormat = DateFormat('MMMM yyyy', 'fr_FR');

  @override
  void initState() {
    super.initState();
    _displayedMonth = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      1,
    );
  }

  @override
  void didUpdateWidget(CalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate.month != widget.selectedDate.month ||
        oldWidget.selectedDate.year != widget.selectedDate.year) {
      _displayedMonth = DateTime(
        widget.selectedDate.year,
        widget.selectedDate.month,
        1,
      );
    }
  }

  List<DateTime> _getDaysInMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    List<DateTime> days = [];
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      days.add(DateTime(date.year, date.month, i));
    }
    return days;
  }

  bool _hasAvailability(DateTime date) {
    return widget.availabilities.any((dayAvail) =>
        dayAvail.date.year == date.year &&
        dayAvail.date.month == date.month &&
        dayAvail.date.day == date.day);
  }

  void _previousMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month - 1,
        1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(_displayedMonth);

    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _previousMonth,
              ),
              Text(
                _monthFormat.format(_displayedMonth).toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _nextMonth,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Jours de la semaine,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text('L', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('M', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('M', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('J', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('V', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('S', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('D', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          // Grille des jours
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: daysInMonth.length +
                DateTime(daysInMonth[0].year, daysInMonth[0].month, 1).weekday -
                1,
            itemBuilder: (context, index) {
              // Espaces vides pour les jours avant le 1er du mois
              if (index <
                  DateTime(daysInMonth[0].year, daysInMonth[0].month, 1)
                          .weekday -
                      1) {
                return const SizedBox();
              }

              final dayIndex = index -
                  (DateTime(daysInMonth[0].year, daysInMonth[0].month, 1)
                          .weekday -
                      1);
              if (dayIndex >= daysInMonth.length) {
                return const SizedBox();
              }

              final day = daysInMonth[dayIndex];
              final isSelected = day.day == widget.selectedDate.day &&
                  day.month == widget.selectedDate.month &&
                  day.year == widget.selectedDate.year;
              final hasAvailability = _hasAvailability(day);

              return GestureDetector(
                onTap: () {
                  widget.onDateSelected(day);
                },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : hasAvailability
                            ? Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.3)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: TextStyle(
                        color: isSelected ? Colors.white : null,
                        fontWeight: hasAvailability ? FontWeight.bold : null,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
