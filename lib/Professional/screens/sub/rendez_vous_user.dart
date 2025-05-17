import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/common/widgets/empty_builder.dart';
import 'package:beauty/common/widgets/error_builder.dart';
import 'package:beauty/professional/widgets/item_rendez_vous.dart';
import 'package:flutter/material.dart' hide SearchBar, Notification;
import 'package:potatoes/auto_list/widgets/auto_list_view.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/professional/bloc/load_me_rendez_vous_cubit.dart';

class RendezVousUser extends StatefulWidget {
  const RendezVousUser({super.key});

  @override
  State<RendezVousUser> createState() => _RendezVousUserState();
}

class _RendezVousUserState extends State<RendezVousUser> {
  late final loadMeRendezVousCubit = context.read<LoadMeRendezVousCubit>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          loadMeRendezVousCubit.reset();
        },
        child: AutoListView.get<RendezVous>(
          autoManage: false,
          cubit: loadMeRendezVousCubit,
          shrinkWrap: true,
          emptyBuilder: (context) => EmptyBuilder(),
          itemBuilder: (context, rendezVous) =>
              RendezVousItem(rendezVous: rendezVous),
          errorBuilder: (context, retry) => ErrorBuilder(retry: retry),
        ));
  }
}
