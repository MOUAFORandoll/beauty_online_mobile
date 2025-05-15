import 'package:beauty/common/models/service_model.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:beauty/common/widgets/service_item.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AvailabilityPeriod {
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  AvailabilityPeriod({required this.startTime, required this.endTime});
}

class DayAvailability {
  final DateTime date;
  final List<AvailabilityPeriod> periods;

  DayAvailability({required this.date, required this.periods});
}

// Données d'exemple
List<DayAvailability> availabilityData = [
  DayAvailability(
    date: DateTime.now(),
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
    date: DateTime.now().add(const Duration(days: 1)),
    periods: [
      AvailabilityPeriod(
        startTime: const TimeOfDay(hour: 10, minute: 0),
        endTime: const TimeOfDay(hour: 16, minute: 0),
      ),
    ],
  ),
  DayAvailability(
    date: DateTime.now().add(const Duration(days: 3)),
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

class MonAgenda extends StatefulWidget {
  const MonAgenda({Key? key}) : super(key: key);

  @override
  State<MonAgenda> createState() => _MonAgendaState();
}

class _MonAgendaState extends State<MonAgenda> {
  DateTime _selectedDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('EEEE d MMMM', 'fr_FR');
  final DateFormat _monthFormat = DateFormat('MMMM yyyy', 'fr_FR');

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
    return availabilityData.any((dayAvail) =>
        dayAvail.date.year == date.year &&
        dayAvail.date.month == date.month &&
        dayAvail.date.day == date.day);
  }

  DayAvailability? _getAvailabilityForDate(DateTime date) {
    try {
      return availabilityData.firstWhere((dayAvail) =>
          dayAvail.date.year == date.year &&
          dayAvail.date.month == date.month &&
          dayAvail.date.day == date.day);
    } catch (e) {
      return null;
    }
  }

  void _addNewAvailability() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddAvailabilityScreen(
                  initialDate: _selectedDate,
                  onSave: (newAvailability) {
                    setState(() {
                      // Vérifier si la date existe déjà
                      int existingIndex = availabilityData.indexWhere(
                          (dayAvail) =>
                              dayAvail.date.year == newAvailability.date.year &&
                              dayAvail.date.month ==
                                  newAvailability.date.month &&
                              dayAvail.date.day == newAvailability.date.day);

                      if (existingIndex >= 0) {
                        // Mettre à jour les périodes existantes
                        availabilityData[existingIndex] = newAvailability;
                      } else {
                        // Ajouter une nouvelle disponibilité
                        availabilityData.add(newAvailability);
                      }
                    });
                  },
                )));
  }

  void _editAvailability(DayAvailability availability) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddAvailabilityScreen(
                  initialDate: availability.date,
                  initialPeriods: availability.periods,
                  onSave: (newAvailability) {
                    setState(() {
                      // Trouver et remplacer l'élément existant
                      int index = availabilityData.indexWhere((dayAvail) =>
                          dayAvail.date.year == availability.date.year &&
                          dayAvail.date.month == availability.date.month &&
                          dayAvail.date.day == availability.date.day);

                      if (index >= 0) {
                        availabilityData[index] = newAvailability;
                      }
                    });
                  },
                )));
  }

  void _deleteAvailability(DayAvailability availability) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content:
            const Text('Voulez-vous vraiment supprimer cette disponibilité ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                availabilityData.removeWhere((dayAvail) =>
                    dayAvail.date.year == availability.date.year &&
                    dayAvail.date.month == availability.date.month &&
                    dayAvail.date.day == availability.date.day);
              });
              Navigator.pop(context);
            },
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(_selectedDate);
    final dayAvailability = _getAvailabilityForDate(_selectedDate);

    return Scaffold(
      body: Column(
        children: [
          // Calendrier mensuel
          Container(
            padding: const EdgeInsets.all(16),
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        setState(() {
                          _selectedDate = DateTime(
                            _selectedDate.year,
                            _selectedDate.month - 1,
                            1,
                          );
                        });
                      },
                    ),
                    Text(
                      _monthFormat.format(_selectedDate).toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {
                        setState(() {
                          _selectedDate = DateTime(
                            _selectedDate.year,
                            _selectedDate.month + 1,
                            1,
                          );
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Jours de la semaine
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
                      DateTime(daysInMonth[0].year, daysInMonth[0].month, 1)
                          .weekday -
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
                    final isSelected = day.day == _selectedDate.day &&
                        day.month == _selectedDate.month &&
                        day.year == _selectedDate.year;
                    final hasAvailability = _hasAvailability(day);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = day;
                        });
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
                              fontWeight:
                                  hasAvailability ? FontWeight.bold : null,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Détails de la journée sélectionnée
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _dateFormat.format(_selectedDate).capitalize(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (dayAvailability != null)
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editAvailability(dayAvailability),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (dayAvailability == null ||
                      dayAvailability.periods.isEmpty)
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Aucune disponibilité définie pour cette journée',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: dayAvailability.periods.length,
                        itemBuilder: (context, index) {
                          final period = dayAvailability.periods[index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: const Icon(Icons.access_time),
                              title: Text(
                                '${period.startTime.format(context)} - ${period.endTime.format(context)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: dayAvailability.periods.length > 1
                                  ? IconButton(
                                      icon: const Icon(Icons.delete_outline),
                                      onPressed: () {
                                        setState(() {
                                          dayAvailability.periods
                                              .removeAt(index);
                                          if (dayAvailability.periods.isEmpty) {
                                            availabilityData
                                                .remove(dayAvailability);
                                          }
                                        });
                                      },
                                    )
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  if (dayAvailability != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton.icon(
                            icon: const Icon(Icons.delete),
                            label: const Text('Supprimer'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            onPressed: () =>
                                _deleteAvailability(dayAvailability),
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text('Ajouter une période'),
                            onPressed: () => _editAvailability(dayAvailability),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: dayAvailability == null
          ? FloatingActionButton.extended(
              onPressed: _addNewAvailability,
              icon: const Icon(Icons.add),
              label: const Text('Ajouter disponibilité'),
            )
          : null,
    );
  }
}

class AddAvailabilityScreen extends StatefulWidget {
  final DateTime initialDate;
  final List<AvailabilityPeriod>? initialPeriods;
  final Function(DayAvailability) onSave;

  const AddAvailabilityScreen({
    Key? key,
    required this.initialDate,
    this.initialPeriods,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AddAvailabilityScreen> createState() => _AddAvailabilityScreenState();
}

class _AddAvailabilityScreenState extends State<AddAvailabilityScreen> {
  late DateTime _selectedDate;
  late List<AvailabilityPeriod> _periods;
  final DateFormat _dateFormat = DateFormat('EEEE d MMMM yyyy', 'fr_FR');

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _periods = widget.initialPeriods?.toList() ??
        [
          AvailabilityPeriod(
            startTime: const TimeOfDay(hour: 9, minute: 0),
            endTime: const TimeOfDay(hour: 17, minute: 0),
          )
        ];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('fr', 'FR'),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(bool isStart, int periodIndex) async {
    final TimeOfDay initialTime = isStart
        ? _periods[periodIndex].startTime
        : _periods[periodIndex].endTime;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _periods[periodIndex] = AvailabilityPeriod(
            startTime: picked,
            endTime: _periods[periodIndex].endTime,
          );
        } else {
          _periods[periodIndex] = AvailabilityPeriod(
            startTime: _periods[periodIndex].startTime,
            endTime: picked,
          );
        }
      });
    }
  }

  void _addPeriod() {
    setState(() {
      // Trouver une heure de début après la dernière période
      TimeOfDay lastEndTime = _periods.last.endTime;
      TimeOfDay newStartTime = TimeOfDay(
        hour: lastEndTime.hour + 1 > 23 ? 23 : lastEndTime.hour + 1,
        minute: lastEndTime.minute,
      );

      TimeOfDay newEndTime = TimeOfDay(
        hour: newStartTime.hour + 1 > 23 ? 23 : newStartTime.hour + 1,
        minute: newStartTime.minute,
      );

      _periods.add(AvailabilityPeriod(
        startTime: newStartTime,
        endTime: newEndTime,
      ));
    });
  }

  void _removePeriod(int index) {
    setState(() {
      _periods.removeAt(index);
    });
  }

  bool _isTimeValid(int index) {
    final period = _periods[index];

    // Vérifier que l'heure de fin est après l'heure de début
    final startMinutes = period.startTime.hour * 60 + period.startTime.minute;
    final endMinutes = period.endTime.hour * 60 + period.endTime.minute;

    if (endMinutes <= startMinutes) {
      return false;
    }

    // Vérifier qu'il n'y a pas de chevauchement avec d'autres périodes
    for (int i = 0; i < _periods.length; i++) {
      if (i == index) continue;

      final otherPeriod = _periods[i];
      final otherStartMinutes =
          otherPeriod.startTime.hour * 60 + otherPeriod.startTime.minute;
      final otherEndMinutes =
          otherPeriod.endTime.hour * 60 + otherPeriod.endTime.minute;

      // Chevauchement si:
      // (début1 < fin2 ET fin1 > début2)
      if (startMinutes < otherEndMinutes && endMinutes > otherStartMinutes) {
        return false;
      }
    }

    return true;
  }

  bool _areAllPeriodsValid() {
    for (int i = 0; i < _periods.length; i++) {
      if (!_isTimeValid(i)) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Définir disponibilité'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sélection de date
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _dateFormat.format(_selectedDate).capitalize(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Titre des périodes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Périodes de disponibilité',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (_periods.length < 5)
                  TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Ajouter'),
                    onPressed: _addPeriod,
                  ),
              ],
            ),

            const SizedBox(height: 8),

            // Liste des périodes
            Expanded(
              child: ListView.builder(
                itemCount: _periods.length,
                itemBuilder: (context, index) {
                  final period = _periods[index];
                  final isValid = _isTimeValid(index);

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Période ${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (_periods.length > 1)
                                IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      color: Colors.red),
                                  onPressed: () => _removePeriod(index),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Heure de début'),
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: () => _selectTime(true, index),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(period.startTime
                                                .format(context)),
                                            const Icon(Icons.access_time),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Heure de fin'),
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: () => _selectTime(false, index),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                period.endTime.format(context)),
                                            const Icon(Icons.access_time),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (!isValid)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'Période invalide ou en conflit avec une autre période',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Annuler'),
              ),
              ElevatedButton(
                onPressed: _areAllPeriodsValid()
                    ? () {
                        widget.onSave(DayAvailability(
                          date: _selectedDate,
                          periods: _periods,
                        ));
                        Navigator.pop(context);
                      }
                    : null,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
