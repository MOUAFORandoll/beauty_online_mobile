import 'package:potatoes/libs.dart';
import 'package:time_change_detector/time_change_detector.dart';
import 'package:beauty/common/services/api_service.dart';

// permet d'obtenir l'heure réelle sans tenir compte des modifications
// de date du système de l'utilisateur
class ServerTimeCubit extends Cubit<Duration> {
  final ServerTimeService timeService;

  ServerTimeCubit(this.timeService) : super(Duration.zero) {
    reset();
    TimeChangeDetector().listener().listen((event) => reset());
  }

  /// reset when system date time changes
  void reset() {
    timeService.getCurrentTime().then((time) {
      emit(time.toLocal().difference(DateTime.now()));
    });
  }

  DateTime get currentTime => DateTime.now().add(state);
}

class ServerTimeService extends ApiService {
  static const String _getTime = '/time';

  const ServerTimeService(super._dio);

  Future<DateTime> getCurrentTime() {
    return compute(dio.get(_getTime),
        mapper: (result) =>
            DateTime.fromMillisecondsSinceEpoch(result['time']));
  }
}
