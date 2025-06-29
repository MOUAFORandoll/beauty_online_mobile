import 'package:beauty/home/models/actu.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/professional/bloc/catalogue_cubit_manager.dart'; 
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';
import 'package:potatoes/libs.dart';

class LoadProCatalogueCubit extends AutoListCubit<Catalogue> {
  final ProfessionalService professionalService;
  final String id;
  final CatalogueCubitManager catalogueCubitManager;

  LoadProCatalogueCubit(
    this.professionalService, this.catalogueCubitManager,
    this.id
  ) : super(
            provider: ({page = 1}) => professionalService.professionalCatalogue(
                  page: page,
                  id: id
                ));

 
  @override
  void onChange(Change<AutoListState<Catalogue>> change) {
    super.onChange(change);
    if (change.nextState is AutoListReadyState<Catalogue>) {
        catalogueCubitManager.addAll((change.nextState as AutoListReadyState<Catalogue>)
          .items
          .items);
    }
  }

                
}
