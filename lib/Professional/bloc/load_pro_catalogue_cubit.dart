import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:beauty/common/models/catalogue.dart'; 
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';

class LoadProCatalogueCubit extends AutoListCubit<Catalogue> {
  final ProfessionalService professionalService;
  final String id;
  LoadProCatalogueCubit(
    this.professionalService,
    this.id
  ) : super(
            provider: ({page = 1}) => professionalService.professionalCatalogue(
                  page: page,
                  id: id
                ));
}
