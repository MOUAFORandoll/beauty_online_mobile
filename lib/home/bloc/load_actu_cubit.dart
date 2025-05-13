import 'package:beauty/Professional/models/catalogue.dart';
import 'package:beauty/Professional/screens/sub/catalogue.dart';
import 'package:beauty/Professional/services/professional_service.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/services/actu_service.dart';
import 'package:beauty/notifications/models/notification.dart';
import 'package:beauty/notifications/services/notifications_service.dart';
import 'package:potatoes/auto_list/bloc/auto_list_cubit.dart';
import 'package:potatoes/auto_list/models/paginated_list.dart';
import 'package:potatoes/auto_content/bloc/auto_content_cubit.dart';

class LoadActuCubit extends AutoListCubit<Actu> {
  final ActuService actuService;

  LoadActuCubit(
    this.actuService,
  ) : super(
            provider: ({page = 1}) => actuService.findActu(
                  page: page,
                ));
}



