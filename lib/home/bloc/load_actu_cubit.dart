import 'package:beauty/common/services/professional_cubit_manager.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/services/actu_cubit_manager.dart';
import 'package:beauty/home/services/actu_service.dart';
import 'package:beauty/notifications/models/notification.dart';
import 'package:beauty/notifications/services/notifications_service.dart';
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/auto_content/bloc/auto_content_cubit.dart';
import 'package:potatoes/libs.dart';

class LoadActuCubit extends AutoListCubit<Actu> {
  final ActuService actuService;
  final ProfessionalCubitManager proCubitManager;
  final ActuCubitManager actuCubitManager;

  LoadActuCubit(this.actuService, this.proCubitManager, this.actuCubitManager)
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
          .forEach((item) => proCubitManager.add(item.profileProfessionnel));
      (change.nextState as AutoListReadyState<Actu>)
          .items
          .items
          .forEach((item) => actuCubitManager.add(item));
    }
  }
}
