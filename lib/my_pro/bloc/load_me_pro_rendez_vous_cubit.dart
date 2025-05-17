import 'package:beauty/common/models/agenda.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';

class LoadMeProRendezVousCubit extends AutoListCubit<RendezVous> {
  final ProfessionalService professionalService;

  LoadMeProRendezVousCubit(
    this.professionalService,
  ) : super(
            provider: ({page = 1}) => professionalService.proRendezVous(
                  page: page,
                ));
}
