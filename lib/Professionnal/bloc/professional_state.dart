part of 'professional_cubit.dart';

mixin ProfessionalState on Equatable {}

class InitializingProfessionalState extends CubitLoadingState
    with ProfessionalState {
  const InitializingProfessionalState() : super();
}

class ProfessionalLoggedState extends CubitSuccessState with ProfessionalState {
  final Professional professional;

  const ProfessionalLoggedState(this.professional) : super();

  @override
  List<Object?> get props => [Professional];
}

class ProfessionalLoadingState extends CubitLoadingState
    with ProfessionalState {
  const ProfessionalLoadingState() : super();
}

class NoProfessionnalFondState extends CubitInformationState
    with ProfessionalState {
  const NoProfessionnalFondState();
}

class ProfessionalErrorState extends CubitErrorState with ProfessionalState {
  ProfessionalErrorState(super.error, [super.trace]);
}
