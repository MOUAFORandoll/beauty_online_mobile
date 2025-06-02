import 'package:beauty/common/models/agenda.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';

class LoadAgendaProCubit extends AutoListCubit<Agenda> {
  final ProfessionalService professionalService;

  final String id;
  LoadAgendaProCubit(this.professionalService, this.id)
      : super(
            provider: ({page = 1}) =>
                professionalService.professionalAgenda(page: page, id: id));
}

typedef LoadAgendaState = AutoListState<Agenda>;
typedef LoadingAgendaState = AutoListLoadingState<Agenda>;
typedef LoadAgendaReadyState = AutoListReadyState<Agenda>;
