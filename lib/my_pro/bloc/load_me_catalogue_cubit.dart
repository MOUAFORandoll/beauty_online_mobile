import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';

class LoadMeCatalogueCubit extends AutoListCubit<Catalogue> {
  final ProfessionalService professionalService;

  LoadMeCatalogueCubit(
    this.professionalService,
  ) : super(
            provider: ({page = 1}) => professionalService.meCatalogue(
                  page: page,
                ));

  void putFirst(Catalogue catalogue) {
    if (state is LoadCatalogueReadyState) {
      final stateBefore = state as LoadCatalogueReadyState;
      emit(stateBefore
          .prependAll([catalogue], total: stateBefore.items.total + 1));
    }
  }

  // remove this item from lists
  void removeCatalogue(Catalogue catalogue) {
    if (state is LoadCatalogueReadyState) {
      final list = (state as LoadCatalogueReadyState).items;
      emit(AutoListReadyState(
        list.remove(catalogue, update: true),
      ));
    }
  }
}

typedef LoadCatalogueState = AutoListState<Catalogue>;
typedef LoadingCatalogueState = AutoListLoadingState<Catalogue>;
typedef LoadCatalogueReadyState = AutoListReadyState<Catalogue>;
