part of 'new_professional_cubit.dart';

mixin NewProfessionalState on Equatable {}

class NewProfessionalIdleState extends CubitSuccessState with NewProfessionalState {
  const NewProfessionalIdleState();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class NewProfessionalUploadingState extends CubitLoadingState with NewProfessionalState {
  const NewProfessionalUploadingState();
}

class NewProfessionalMediaState extends CubitInformationState with NewProfessionalState {
  final File? file;
  final AssetType? assetType;
  const NewProfessionalMediaState({this.file, this.assetType});
  @override
  List<Object?> get props => [...super.props, file, assetType];
}

class NewProfessionalUploadedState extends CubitInformationState with NewProfessionalState {
  final Professional professional;

  const NewProfessionalUploadedState(this.professional);
  @override
  List<Object?> get props => [...super.props, professional];
}

class NewProfessionalErrorState extends CubitErrorState with NewProfessionalState {
  NewProfessionalErrorState(super.error, [super.trace]);
}
