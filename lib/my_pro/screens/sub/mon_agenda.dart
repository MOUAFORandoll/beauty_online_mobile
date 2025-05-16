import 'package:beauty/agenda/screens/schedule_list_screen.dart';
import 'package:beauty/common/models/service_model.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:beauty/common/widgets/service_item.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonAgenda extends StatefulWidget {
  const MonAgenda({Key? key}) : super(key: key);

  @override
  State<MonAgenda> createState() => _MonAgendaState();
}

class _MonAgendaState extends State<MonAgenda> {
  @override
  Widget build(BuildContext context) {
    return ScheduleListScreen();
  }
}
