import 'package:beauty/common/models/catalogue.dart'; 
import 'package:beauty/professional/bloc/catalogue_cubit.dart';
import 'package:potatoes/common/bloc/cubit_manager.dart'; 

class CatalogueCubitManager extends CubitManager<CatalogueCubit, Catalogue, String> {
   
  CatalogueCubitManager();

  @override
  String buildId(Catalogue object) {
    return object.id;
  }

  @override
  CatalogueCubit create(Catalogue object) {
    return CatalogueCubit( object);
  }

  @override
  void updateCubit(CatalogueCubit cubit, Catalogue object) {
    cubit.update(object);
  }
}
