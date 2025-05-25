part of 'professional_cubit.dart';

mixin ProfessionalState on Equatable {}

class InitializingProfessionalState extends CubitLoadingState
    with ProfessionalState {
  const InitializingProfessionalState() : super();
}

class ProfessionalLoadedState extends CubitSuccessState with ProfessionalState {
  final Professional professional;

  const ProfessionalLoadedState(this.professional) : super();

  @override
  List<Object?> get props => [Professional];
}

class ProfessionalLoadingState extends CubitLoadingState
    with ProfessionalState {
  const ProfessionalLoadingState() : super();
}
 
class ProfessionalErrorState extends CubitErrorState with ProfessionalState {
  ProfessionalErrorState(super.error, [super.trace]);
}

class ShareProfessionalLoadingState extends CubitLoadingState with ProfessionalState {
  const ShareProfessionalLoadingState() : super();
}

class ShareProfessionalSuccessState extends CubitInformationState with ProfessionalState {
  final String link;

  const ShareProfessionalSuccessState(this.link);

  @override
  List<Object?> get props => [link];
}
