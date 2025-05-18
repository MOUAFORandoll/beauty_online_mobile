part of 'notification_cubit.dart';

mixin NotificationState on Equatable {}

class NotificationInitialState extends CubitSuccessState
    with NotificationState {
  const NotificationInitialState();

  @override
  List<Object?> get props => [];
}

class NotificationLoadingState extends CubitLoadingState
    with NotificationState {
  const NotificationLoadingState();
}

class PostNotificationLoadingState extends CubitLoadingState
    with NotificationState {}

class AnimeNotificationLoadingState extends CubitLoadingState
    with NotificationState {}

class EpisodeNotificationLoadingState extends CubitLoadingState
    with NotificationState {}

class QuizNotificationLoadingState extends CubitLoadingState
    with NotificationState {}

class UserNotificationLoadingState extends CubitLoadingState
    with NotificationState {}
 
class NotificationErrorState extends CubitErrorState with NotificationState {
  NotificationErrorState(super.error, [super.trace]);
}
