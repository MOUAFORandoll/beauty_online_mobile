import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/common/widgets/empty_builder.dart';
import 'package:beauty/common/widgets/error_builder.dart';
import 'package:beauty/my_pro/bloc/load_me_pro_rendez_vous_cubit.dart';
import 'package:beauty/my_pro/widgets/my_item_rendez_vous_pro.dart';
import 'package:flutter/material.dart' hide SearchBar, Notification;
import 'package:potatoes/auto_list/widgets/auto_list_view.dart';
import 'package:potatoes/libs.dart';

class RendezVousPro extends StatefulWidget {
  const RendezVousPro({super.key});

  @override
  State<RendezVousPro> createState() => _RendezVousProState();
}

class _RendezVousProState extends State<RendezVousPro> {
  late final loadMeProRendezVousCubit =
      context.read<LoadMeProRendezVousCubit>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          loadMeProRendezVousCubit.reset();
        },
        child: AutoListView.get<RendezVous>(
          autoManage: false,
          cubit: loadMeProRendezVousCubit,
          shrinkWrap: true,
          emptyBuilder: (context) => EmptyBuilder(),
          itemBuilder: (context, rendezVous) =>
              MyItemRendezVousPro(rendezVous: rendezVous),
          errorBuilder: (context, retry) => ErrorBuilder(retry: retry),
        ));
  }
}
