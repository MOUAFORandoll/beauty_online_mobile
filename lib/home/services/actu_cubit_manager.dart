import 'package:beauty/home/bloc/actu_cubit.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/services/actu_service.dart';
import 'package:potatoes/common/bloc/cubit_manager.dart'; 

class ActuCubitManager extends CubitManager<ActuCubit, Actu, String> {
  final ActuService actuService;

  ActuCubitManager(this.actuService);

  @override
  String buildId(Actu object) {
    return object.id;
  }

  @override
  ActuCubit create(Actu object) {
    return ActuCubit(actuService, object);
  }

  @override
  void updateCubit(ActuCubit cubit, Actu object) {
    cubit.update(object);
  }
}
