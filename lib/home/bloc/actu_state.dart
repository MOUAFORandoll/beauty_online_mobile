part of 'actu_cubit.dart';

mixin ActuState on Equatable {}

class InitializingActuState extends CubitLoadingState
    with ActuState {
  const InitializingActuState() : super();
}

class ActuLoadedState extends CubitSuccessState with ActuState {
  final Actu actu;

  const ActuLoadedState(this.actu) : super();

  @override
  List<Object?> get props => [Actu];
}

class ActuLoadingState extends CubitLoadingState
    with ActuState {
  const ActuLoadingState() : super();
}
 
class ActuErrorState extends CubitErrorState with ActuState {
  ActuErrorState(super.error, [super.trace]);
}

class ShareActuLoadingState extends CubitLoadingState with ActuState {
  const ShareActuLoadingState() : super();
}

class ShareActuSuccessState extends CubitInformationState with ActuState {
  final String shareLink;

  const ShareActuSuccessState(this.shareLink);

  @override
  List<Object?> get props => [shareLink];
}
