part of 'action_professional_cubit.dart';

mixin ActionProfessionalState on Equatable {}

class InitializingActionProfessionalState extends CubitLoadingState
    implements ActionProfessionalState {
  const InitializingActionProfessionalState() : super();

  @override
  List<Object?> get props => [];
}

class NewRendezVousLoadingState extends CubitLoadingState
    implements ActionProfessionalState {
  const NewRendezVousLoadingState() : super();

  @override
  List<Object?> get props => [];
}

class NewRendezVousSuccessState extends CubitSuccessState
    implements ActionProfessionalState {
      final RendezVous rendezVous;
  const NewRendezVousSuccessState(this.rendezVous) : super();

  @override
  List<Object?> get props => [rendezVous];
}
 

class DeletingRendezVousLoadingState extends CubitLoadingState
    implements ActionProfessionalState {
  const DeletingRendezVousLoadingState() : super();

  @override
  List<Object?> get props => [];
}

class DeletedRendezVousSuccessState extends CubitSuccessState
    implements ActionProfessionalState {
  const DeletedRendezVousSuccessState() : super();

  @override
  List<Object?> get props => [];
}
 
class ActionProfessionalErrorState extends CubitErrorState
    implements ActionProfessionalState {
  ActionProfessionalErrorState(super.error, [super.stackTrace]);
}
