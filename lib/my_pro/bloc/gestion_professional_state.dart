part of 'gestion_professional_cubit.dart';

mixin GestionProfessionalState on Equatable {}

class InitializingGestionProfessionalState extends CubitLoadingState
    implements GestionProfessionalState {
  const InitializingGestionProfessionalState() : super();

  @override
  List<Object?> get props => [];
}

class AddCatalogueLoadingState extends CubitLoadingState
    implements GestionProfessionalState {
  const AddCatalogueLoadingState() : super();

  @override
  List<Object?> get props => [];
}

class AddCatalogueSuccessState extends CubitSuccessState
    implements GestionProfessionalState {
  const AddCatalogueSuccessState() : super();

  @override
  List<Object?> get props => [];
}

class AddStoriesLoadingState extends CubitLoadingState
    implements GestionProfessionalState {
  const AddStoriesLoadingState() : super();

  @override
  List<Object?> get props => [];
}

class AddStoriesSuccessState extends CubitSuccessState
    implements GestionProfessionalState {
  const AddStoriesSuccessState() : super();

  @override
  List<Object?> get props => [];
}

class DeletingCatalogueLoadingState extends CubitLoadingState
    implements GestionProfessionalState {
  const DeletingCatalogueLoadingState() : super();

  @override
  List<Object?> get props => [];
}

class DeletedCatalogueSuccessState extends CubitSuccessState
    implements GestionProfessionalState {
  const DeletedCatalogueSuccessState() : super();

  @override
  List<Object?> get props => [];
}

class DeletingStoriesLoadingState extends CubitLoadingState
    implements GestionProfessionalState {
  const DeletingStoriesLoadingState() : super();

  @override
  List<Object?> get props => [];
}

class DeletedStoriesSuccessState extends CubitSuccessState
    implements GestionProfessionalState {
  const DeletedStoriesSuccessState() : super();

  @override
  List<Object?> get props => [];
}

class AddAgendaLoadingState extends CubitLoadingState
    implements GestionProfessionalState {
  const AddAgendaLoadingState() : super();

  @override
  List<Object?> get props => [];
}

class AddAgendaSuccessState extends CubitSuccessState
    implements GestionProfessionalState {
  const AddAgendaSuccessState() : super();

  @override
  List<Object?> get props => [];
}

class DeletingAgendaLoadingState extends CubitLoadingState
    implements GestionProfessionalState {
  const DeletingAgendaLoadingState() : super();

  @override
  List<Object?> get props => [];
}

class DeletedAgendaSuccessState extends CubitSuccessState
    implements GestionProfessionalState {
  const DeletedAgendaSuccessState() : super();

  @override
  List<Object?> get props => [];
}

class AddCreneauLoadingState extends CubitLoadingState
    implements GestionProfessionalState {
  const AddCreneauLoadingState() : super();

  @override
  List<Object?> get props => [];
}

class AddCreneauSuccessState extends CubitSuccessState
    implements GestionProfessionalState {
  const AddCreneauSuccessState() : super();

  @override
  List<Object?> get props => [];
}

class DeletingCreneauLoadingState extends CubitLoadingState
    implements GestionProfessionalState {
  const DeletingCreneauLoadingState() : super();

  @override
  List<Object?> get props => [];
}

class DeletedCreneauSuccessState extends CubitSuccessState
    implements GestionProfessionalState {
  const DeletedCreneauSuccessState() : super();

  @override
  List<Object?> get props => [];
}

class GestionProfessionalErrorState extends CubitErrorState
    implements GestionProfessionalState {
  GestionProfessionalErrorState(super.error, [super.stackTrace]);
}
