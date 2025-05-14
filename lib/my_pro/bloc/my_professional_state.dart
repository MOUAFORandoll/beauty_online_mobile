part of 'my_professional_cubit.dart';

mixin MyProfessionalState on Equatable {}

class InitializingMyProfessionalState extends CubitLoadingState
    with MyProfessionalState {
  const InitializingMyProfessionalState() : super();
}

class MyProfessionalLoggedState extends CubitSuccessState with MyProfessionalState {
  final Professional professional;

  const MyProfessionalLoggedState(this.professional) : super();

  @override
  List<Object?> get props => [Professional];
}

class ProfessionalLoadingState extends CubitLoadingState
    with MyProfessionalState {
  const ProfessionalLoadingState() : super();
}

class NoProfessionnalFondState extends CubitInformationState
    with MyProfessionalState {
  const NoProfessionnalFondState();
}

class ProfessionalErrorState extends CubitErrorState with MyProfessionalState {
  ProfessionalErrorState(super.error, [super.trace]);
}
