import 'package:beauty/common/models/agenda.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/models/professional.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:beauty/professional/bloc/load_pro_agenda_cubit.dart';
import 'package:beauty/professional/bloc/load_pro_catalogue_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/professional/widgets/item_agenda.dart';
import 'package:beauty/professional/widgets/item_catalogue.dart';
import 'package:beauty/common/models/service_model.dart';
import 'package:beauty/common/widgets/empty_builder.dart';
import 'package:beauty/common/widgets/error_builder.dart';
import 'package:beauty/common/widgets/loader_builder.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:beauty/common/widgets/service_item.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/auto_content/widgets/auto_content_view.dart';
import 'package:potatoes/auto_list.dart';
import 'package:potatoes/libs.dart';

class MyUserReservation extends StatefulWidget {
  final Professional professional;

  static Widget get({
    required BuildContext context,
    required Professional professional,
  }) {
    return BlocProvider(
      create: (context) => LoadAgendaProCubit(
          context.read<ProfessionalService>(), professional.id),
      child: MyUserReservation._(professional),
    );
  }

  const MyUserReservation._(this.professional);
  @override
  State<MyUserReservation> createState() => _MyUserReservationState();
}

class _MyUserReservationState extends State<MyUserReservation> {
  late final cubit = context.read<LoadAgendaProCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 16, children: <Widget>[
      SizedBox(
        height: 16,
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Choisir votre crenau de rendez-vous'),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close))
          ],
        ),
      ),
      Expanded(
          child: AutoListView.get<Agenda>(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom),
              autoManage: false,
              cubit: cubit,
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, agenda) => AgendaItem(
                    professional: widget.professional,
                    agenda: agenda,
                  ),
              emptyBuilder: (ctx) => const EmptyBuilder(),
              errorBuilder: (context, retry) => ErrorBuilder(retry: retry),
              loadingBuilder: (_) => const AgendaLoaderBuilder(count: 12),
              loadingMoreBuilder: (_) => const AgendaLoaderBuilder()))
    ]);
  }
}
