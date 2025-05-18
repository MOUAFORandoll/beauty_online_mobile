import 'package:beauty/common/services/preferences_service.dart';
import 'package:beauty/common/services/user_service.dart';
import 'package:beauty/notifications/models/notification.dart';
import 'package:beauty/notifications/services/notification_service.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart' hide PreferencesService; 
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
   
  final PreferencesService preferencesService;
  final NotificationService notificationService; 
  final UserService userService;
  NotificationCubit(
      this.preferencesService, 
     
      this.notificationService,
      this.userService,
     )
      : super(const NotificationInitialState());

  Future<void> requestNotificationPermission() {
    return notificationService.requestPermission((token) {
      preferencesService.deviceToken.then((oldToken) {
        if (oldToken == token) return;
        userService.sendFCMToken(token: token).then((_) {
          preferencesService.saveDeviceToken(token);
        });
      });
    });
  }

  Future<void> onNotification({required Notification notification}) async {
    final id = notification.target;
    // switch (notification.type) {
    //   case NotificationType.follows:
    //     if (id.isNotEmpty) {
    //       await fetchUserById(id: id);
    //     } else {
    //       emit(NotificationErrorState("ID manquant pour l'utilisateur"));
    //     }
    //     break;
    //   case NotificationType.participations:
    //     if (id.isNotEmpty) {
    //       await fetchQuiz(id: id);
    //     } else {
    //       emit(NotificationErrorState("ID manquant pour le quiz"));
    //     }
    //     break;
    //   case NotificationType.postLikes:
    //   case NotificationType.postComments:
    //   case NotificationType.postCommentLikes:
    //   case NotificationType.inactivityPost:
    //     if (id.isNotEmpty) {
    //       await fetchPost(id: id);
    //     } else {
    //       emit(NotificationErrorState("ID manquant pour le post"));
    //     }
    //     break;
    //   case NotificationType.episodeComments:
    //   case NotificationType.episodeCommentLikes:
    //   case NotificationType.newEpisode:
    //   case NotificationType.inactivityEpisode:
    //     if (id.isNotEmpty) {
    //       await fetchEpisode(id: id);
    //     } else {
    //       emit(NotificationErrorState("ID manquant pour l'épisode"));
    //     }
    //     break;
    //   case NotificationType.inactivityAnime:
    //     if (id.isNotEmpty) {
    //       await fetchAnime(id: id);
    //     } else {
    //       emit(NotificationErrorState("ID manquant pour l'anime"));
    //     }
    //     break;

    //   default:
    //     emit(const NotificationInitialState());
    // }
  }

  // fetchUserById({required String id}) async {
  //   final stateBefore = state;

  //   try {
  //     final cubit = personCubitManager.getById(id);
  //     emit(UserNotificationLoadedState(cubit.user));
  //   } on UnsupportedError catch (_) {
  //     // on n'a pas trouvé de cubit en mémoire, on fetch l'objet
  //     emit(UserNotificationLoadingState());
  //     try {
  //       final user = await linkService.getUserById(id: id);
  //       personCubitManager.add(user);
  //       emit(UserNotificationLoadedState(user));
  //     } catch (error, trace) {
  //       emit(NotificationErrorState(error, trace));
  //     }
  //   } catch (error, trace) {
  //     emit(NotificationErrorState(error, trace));
  //   }

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
