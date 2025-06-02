import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';

class LoadMeRendezVousCubit extends AutoListCubit<RendezVous> {
  final ProfessionalService professionalService;




  LoadMeRendezVousCubit(this.professionalService)
      : super(
            provider: ({page = 1}) => professionalService.meRendezVous(
                  page: page,
                ));
}
 