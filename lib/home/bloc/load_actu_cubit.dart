
import 'package:beauty/common/services/professional_cubit_manager.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/services/actu_service.dart';
import 'package:beauty/notifications/models/notification.dart';
import 'package:beauty/notifications/services/notifications_service.dart';
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/auto_content/bloc/auto_content_cubit.dart';
import 'package:potatoes/libs.dart';

class LoadActuCubit extends AutoListCubit<Actu> {
  final ActuService actuService;
  final ProfessionalCubitManager cubitManager;

  LoadActuCubit(this.actuService, this.cubitManager)
      : super(
            provider: ({page = 1}) => actuService.findActu(
                  page: page,
                ));
  @override
  void onChange(Change<AutoListState<Actu>> change) {
    super.onChange(change);
    if (change.nextState is AutoListReadyState<Actu>) {
      (change.nextState as AutoListReadyState<Actu>)
          .items
          .items
          .forEach((item) => cubitManager.add(item.profileProfessionnel));
    }
  }
}
