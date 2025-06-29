import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:beauty/professional/bloc/catalogue_cubit_manager.dart';
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';
import 'package:potatoes/libs.dart';

class LoadMeCatalogueCubit extends AutoListCubit<Catalogue> {
  final ProfessionalService professionalService;
  final CatalogueCubitManager catalogueCubitManager;

  LoadMeCatalogueCubit(
    this.professionalService,
     this.catalogueCubitManager,
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

  @override
  void onChange(Change<AutoListState<Catalogue>> change) {
    super.onChange(change);
    if (change.nextState is AutoListReadyState<Catalogue>) {
      catalogueCubitManager.addAll(
          (change.nextState as AutoListReadyState<Catalogue>).items.items);
    }
  }
}

typedef LoadCatalogueState = AutoListState<Catalogue>;
typedef LoadingCatalogueState = AutoListLoadingState<Catalogue>;
typedef LoadCatalogueReadyState = AutoListReadyState<Catalogue>;
