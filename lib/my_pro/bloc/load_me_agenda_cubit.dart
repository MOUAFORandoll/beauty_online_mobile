import 'package:beauty/common/models/agenda.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';

class LoadMeCatalogueCubit extends AutoListCubit<Agenda> {
  final ProfessionalService professionalService;

  LoadMeCatalogueCubit(
    this.professionalService,
  ) : super(
            provider: ({page = 1}) => professionalService.meAgenda(
                  page: page,
                ));
}
