import 'package:beauty/common/models/agenda.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';

class LoadMeAgendaCubit extends AutoListCubit<Agenda> {
  final ProfessionalService professionalService;

  LoadMeAgendaCubit(
    this.professionalService,
  ) : super(
            provider: ({page = 1}) => professionalService.meAgenda(
                  page: page,
                ));

  void putFirst(Agenda agenda) {
    if (state is LoadAgendaReadyState) {
      final currentState = state as LoadAgendaReadyState;
      final updatedList = [...currentState.items.items];

      final existingIndex =
          updatedList.indexWhere((item) => item.id == agenda.id);

      if (existingIndex != -1) {
        // Met à jour l'élément à la même position
        updatedList[existingIndex] = agenda;
        emit(AutoListReadyState(
          PaginatedList(
              items: updatedList,
              page: currentState.items.page,
              total: currentState.items.total),
        ));
        
      } else {
        // Ajoute au début si l'élément n'existe pas encore
        updatedList.insert(0, agenda);
        emit(currentState
            .prependAll([agenda], total: currentState.items.total + 1));
      }
    }
  }

  // remove this item from lists
  void removeAgenda(Agenda agenda) {
    if (state is LoadAgendaReadyState) {
      final list = (state as LoadAgendaReadyState).items;
      emit(AutoListReadyState(
        list.remove(agenda, update: true),
      ));
    }
  }
}

typedef LoadAgendaState = AutoListState<Agenda>;
typedef LoadingAgendaState = AutoListLoadingState<Agenda>;
typedef LoadAgendaReadyState = AutoListReadyState<Agenda>;
