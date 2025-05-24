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

class MyProfessionalLoadingState extends CubitLoadingState
    with MyProfessionalState {
  const MyProfessionalLoadingState() : super();
}

class NoProfessionnalFondState extends CubitInformationState
    with MyProfessionalState {
  const NoProfessionnalFondState();
}

class MyProfessionalErrorState extends CubitErrorState with MyProfessionalState {
  MyProfessionalErrorState(super.error, [super.trace]);
}


class MyProfessionalUpdatingState extends CubitLoadingState with MyProfessionalState {
  const MyProfessionalUpdatingState() : super();
}

class MyProfessionalUpdatedState extends CubitInformationState with MyProfessionalState {
  const MyProfessionalUpdatedState() : super();
}

class UpdateMyProfessionalErrorState extends CubitErrorState with MyProfessionalState {
  UpdateMyProfessionalErrorState(super.error, [super.trace]);
}

class ShareMyProfessionalLoadingState extends CubitLoadingState
    with MyProfessionalState {
  const ShareMyProfessionalLoadingState() : super();
}

class ShareMyProfessionalSuccessState extends CubitInformationState
    with MyProfessionalState {
  final String shareLink;

  const ShareMyProfessionalSuccessState(this.shareLink);

  @override
  List<Object?> get props => [shareLink];
}
