import 'package:beauty/common/models/professional.dart';
import 'package:beauty/common/services/professional_cubit_manager.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/models/search_result.dart';
import 'package:beauty/home/services/actu_cubit_manager.dart';
import 'package:beauty/home/services/actu_service.dart';
import 'package:potatoes/auto_list.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/bloc/search_cubit.dart';
import 'package:beauty/common/models/user.dart';
import 'package:beauty/common/services/user_service.dart';

class MySearchCubit extends SearchCubit<SearchResult> {
  final ActuService actuService;
  final ProfessionalCubitManager proCubitManager;
  final ActuCubitManager actuCubitManager;

  MySearchCubit({
    required this.actuService,
    required this.proCubitManager,
    required this.actuCubitManager,
  }) : super(
            proceedSearch: actuService.search,
            sleepDuration: Duration(milliseconds: 800));

  @override
  void onChange(Change<AutoListState<SearchResult>> change) {
    super.onChange(change);
    if (change.nextState is AutoListReadyState<SearchResult>) {
      (change.nextState as AutoListReadyState<SearchResult>)
          .items
          .items
          .forEach((item) {
        if (item.toData() is Actu) {
          actuCubitManager.add(item.toData());
          proCubitManager.add(item.toData().profileProfessionnel);
        } else if (item.toData()  is Professional) {
          proCubitManager.add(item.toData());
        }
      });
    }
  }
}
