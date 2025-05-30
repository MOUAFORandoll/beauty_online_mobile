part of 'link_cubit.dart';

mixin LinkState on Equatable {}

class LinkInitial extends CubitSuccessState with LinkState {
  const LinkInitial();

  @override
  List<Object?> get props => [];
}

class LinkLoading extends CubitLoadingState with LinkState {}

class DetectedLink extends CubitInformationState with LinkState {
  DetectedLink();
}

class ActuLinkLoading extends CubitLoadingState with LinkState {}

class ActuLinkLoaded extends CubitInformationState with LinkState {
  final Actu actu;
  ActuLinkLoaded(this.actu);
}

class ProfessionalLinkLoading extends CubitLoadingState with LinkState {}

class ProfessionalLinkLoaded extends CubitInformationState with LinkState {
  final Professional professional;
  ProfessionalLinkLoaded(this.professional);
}


class LinkError extends CubitErrorState with LinkState {
  LinkError(super.error, [super.trace]);
}
