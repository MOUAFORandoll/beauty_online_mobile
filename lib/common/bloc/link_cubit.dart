import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:beauty/common/models/professional.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/notifications/services/notifications_service.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart';

part 'link_state.dart';

class LinkCubit extends Cubit<LinkState> {
  late AppLinks _appLinks;

  StreamSubscription<Uri>? _linkSubscription;
  final NotificationsService notificationsService;
  LinkCubit(this.notificationsService) : super(const LinkInitial()) {
    _initialize();
  }

  void _initialize() async {
    _appLinks = AppLinks();
    initDeepLinks();
  }

  Future<void> initDeepLinks() async {
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleUri(uri);
      }
    });
  }

  Future<void> _handleUri(Uri uri) async {
    final id = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
    switch (uri.pathSegments.first) {
      case 'professionnel':
        if (id.isNotEmpty) {
          await fetchPro(id: id);
        } else {
          emit(LinkError("ID manquant pour le professionnel"));
        }
        break;
      case 'actu':
        if (id.isNotEmpty) {
          await fecthActu(id: id);
        } else {
          emit(LinkError("ID manquant pour láctu"));
        }
        break;

      default:
        emit(const LinkInitial());
    }
  }

  fecthActu({required String id}) async {
    final stateBefore = state;

    emit(ActuLinkLoading());
    notificationsService.findActuById(id: id).then((data) {
      emit(ActuLinkLoaded(data));
    }, onError: (error, trace) {
      emit(LinkError(error, trace));
      emit(stateBefore);
    });
  }

  fetchPro({required String id}) async {
    final stateBefore = state;

    emit(ProfessionalLinkLoading());

    notificationsService.findProfileById(id: id).then((data) {
      emit(ProfessionalLinkLoaded(data));
    }, onError: (error, trace) {
      emit(LinkError(error, trace));
      emit(stateBefore);
    });
  }

  @override
  Future<void> close() {
    _linkSubscription?.cancel();
    return super.close();
  }
}
