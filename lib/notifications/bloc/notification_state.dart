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

class RdvNotificationLoadingState extends CubitLoadingState
    with NotificationState {}

class RdvClientNotificationSuccessLoadState extends CubitSuccessState
    with NotificationState {
  final RendezVous rendezVous;
  RdvClientNotificationSuccessLoadState(this.rendezVous);

  @override
  List<Object?> get props => [rendezVous];
}

class RdvProNotificationSuccessLoadState extends CubitSuccessState
    with NotificationState {
  final RendezVous rendezVous;
  RdvProNotificationSuccessLoadState(this.rendezVous);

  @override
  List<Object?> get props => [rendezVous];
}

 

class NotificationErrorState extends CubitErrorState with NotificationState {
  NotificationErrorState(super.error, [super.trace]);
}
