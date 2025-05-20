import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/common/services/preferences_service.dart';
import 'package:beauty/common/services/user_service.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:beauty/notifications/models/notification.dart';
import 'package:beauty/notifications/services/notification_service.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart' hide PreferencesService;
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final PreferencesService preferencesService;
  final NotificationService notificationService;
  final UserService userService;
  final ProfessionalService professionalService;
  NotificationCubit(this.preferencesService, this.notificationService,
      this.userService, this.professionalService)
      : super(const NotificationInitialState());

  Future<void> requestNotificationPermission() {
    return notificationService.requestPermission((token) {
      preferencesService.deviceToken.then((oldToken) {
        print('new token ${token}');
        print('oldToken  ${oldToken}');
        print('status  ${oldToken == token}');
        if (oldToken == token) return;
        userService.sendFCMToken(token: token).then((_) {
          preferencesService.saveDeviceToken(token);
        });
      });
    });
  }

  Future<void> onNotification({required Notification notification}) async {
    final id = notification.rdvId;

    switch (notification.type) {
      case NotificationType.newRdv:
      case NotificationType.rdvAccepted:
      case NotificationType.rdvRefused:
        if (id.isNotEmpty) {
          await findRendezVous(id: id, type: notification.type);
        } else {
          emit(NotificationErrorState("ID manquant pour l'utilisateur"));
        }
        break;

      default:
        emit(const NotificationInitialState());
    }
  }

  findRendezVous({required String id, required String type}) async {
    final stateBefore = state;
    emit(RdvNotificationLoadingState());

    try {
      final rdv = await professionalService.findRendezVous(id);
      if (type == NotificationType.newRdv) {
        emit(RdvProNotificationSuccessLoadState(rdv));
      } else {
        emit(RdvNotificationSuccessLoadState(rdv));
      }
    } catch (error, trace) {
      emit(NotificationErrorState(error, trace));
    }
  }

  //   emit(stateBefore);
  // }

  // fetchPost({required String id}) async {
  //   final stateBefore = state;

  //   try {
  //     final cubit = postCubitManager.getById(id);
  //     emit(PostNotificationLoadedState(cubit.x));
  //   } on UnsupportedError catch (_) {
  //     // on n'a pas trouvé de cubit en mémoire, on fetch l'objet
  //     emit(PostNotificationLoadingState());
  //     final post = await linkService.getPost(idPost: id);
  //     try {
  //       postCubitManager.add(post);
  //       emit(PostNotificationLoadedState(post));
  //     } catch (error, trace) {
  //       emit(NotificationErrorState(error, trace));
  //     }
  //   } catch (error, trace) {
  //     emit(NotificationErrorState(error, trace));
  //   }

  //   emit(stateBefore);
  // }

  // fetchAnime({required String id}) async {
  //   final stateBefore = state;

  //   try {
  //     final cubit = animeCubitManager.getById(id);
  //     emit(AnimeNotificationLoadedState(cubit.anime));
  //   } on UnsupportedError catch(_) {
  //     // on n'a pas trouvé de cubit en mémoire, on fetch l'objet
  //     emit(AnimeNotificationLoadingState());
  //     try {
  //       final anime = await linkService.getAnime(idAnime: id);
  //       animeCubitManager.add(anime);
  //       emit(AnimeNotificationLoadedState(anime));
  //     } catch (error, trace) {
  //       emit(NotificationErrorState(error, trace));
  //     }
  //   } catch (error, trace) {
  //     emit(NotificationErrorState(error, trace));
  //   }

  //   emit(stateBefore);
  // }

  // fetchEpisode({required String id}) async {
  //   final stateBefore = state;

  //   try {
  //     final cubit = episodeCubitManager.getById(id);
  //     emit(EpisodeNotificationLoadedState(cubit.x));
  //   } on UnsupportedError catch (_) {
  //     // on n'a pas trouvé de cubit en mémoire, on fetch l'objet
  //     emit(EpisodeNotificationLoadingState());
  //     try {
  //       final episode = await linkService.getEpisode(idEpisode: id);
  //       episodeCubitManager.add(episode);
  //       emit(EpisodeNotificationLoadedState(episode));
  //     } catch (error, trace) {
  //       emit(NotificationErrorState(error, trace));
  //     }
  //   } catch (error, trace) {
  //     emit(NotificationErrorState(error, trace));
  //   }

  //   emit(stateBefore);
  // }

  // fetchQuiz({required String id}) async {
  //   final stateBefore = state;

  //   try {
  //     final cubit = quizCubitManager.getById(id);
  //     emit(QuizNotificationLoadedState(cubit.quiz));
  //   } on UnsupportedError catch (_) {
  //     // on n'a pas trouvé de cubit en mémoire, on fetch l'objet
  //     emit(QuizNotificationLoadingState());
  //     try {
  //       final quiz = await linkService.getQuiz(idQuiz: id);
  //       quizCubitManager.add(quiz);
  //       emit(QuizNotificationLoadedState(quiz));
  //     } catch (error, trace) {
  //       emit(NotificationErrorState(error, trace));
  //     }
  //   } catch (error, trace) {
  //     emit(NotificationErrorState(error, trace));
  //   }

  //   emit(stateBefore);
  // }
}
