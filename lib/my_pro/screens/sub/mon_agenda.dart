import 'package:beauty/my_pro/widgets/my_item_agenda.dart' show MyAgendaItem;
import 'package:beauty/common/models/agenda.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/widgets/empty_builder.dart';
import 'package:beauty/common/widgets/error_builder.dart';
import 'package:beauty/common/widgets/loader_builder.dart';
import 'package:beauty/my_pro/bloc/gestion_professional_cubit.dart';
import 'package:beauty/my_pro/bloc/load_me_agenda_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potatoes/auto_list/widgets/auto_list_view.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import '../../bloc/schedule_cubit.dart';
import '../../models/schedule.dart';
import 'add_schedule_screen.dart';

class MonAgenda extends StatefulWidget {
  //  static Widget get({
  //   required BuildContext context,
  // }) {
  //   return BlocProvider(
  //     create: (context) => LoadMeAgendaCubit(context.read()),
  //     child: MonAgenda._(),
  //   );
  // }

  const MonAgenda();
  @override
  State<MonAgenda> createState() => _MonAgendaState();
}

class _MonAgendaState extends State<MonAgenda> with CompletableMixin {
  late final cubit = context.read<LoadMeAgendaCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GestionProfessionalCubit, GestionProfessionalState>(
        listener: onEventReceived,
        builder: (ctx, stateG) =>
            BlocListener<LoadMeAgendaCubit, LoadAgendaState>(
                listenWhen: (previous, current) =>
                    previous is LoadingAgendaState &&
                    current is LoadAgendaReadyState,
                listener: (context, state) {
                  // scrollController.animateTo(
                  //   scrollController.position.maxScrollExtent,
                  //   duration: Duration(milliseconds: 300),
                  //   curve: Curves.easeInOut
                  // );
                },
                child: AutoListView.get<Agenda>(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewPadding.bottom),
                    autoManage: false,
                       cubit: cubit,
                    itemBuilder: (context, agenda) => MyAgendaItem(agenda),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0,
                            childAspectRatio: .65),
                    emptyBuilder: (ctx) => const EmptyBuilder(),
                    errorBuilder: (context, retry) =>
                        ErrorBuilder(retry: retry),
                    loadingBuilder: (_) => const AgendaLoaderBuilder(count: 12),
                    loadingMoreBuilder: (_) => const AgendaLoaderBuilder())));
  }

  void onEventReceived(
      BuildContext context, GestionProfessionalState state) async {
    await waitForDialog();
    if (state is DeletingAgendaLoadingState) {
      loadingDialogCompleter = showLoadingBarrier(context: context);
    }
    if (state is DeletedAgendaSuccessState) {
      cubit.removeAgenda(state.agenda);
      showSuccessToast(
          context: context, content: 'Agenda supprimé avec succès!');
    }
    if (state is GestionProfessionalErrorState) {
      showErrorToast(context: context, content: state.error);
    }
  }
}
