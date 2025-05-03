part of 'auth_cubit.dart';

mixin AuthState on Equatable {}

class AuthIdleState extends CubitSuccessState with AuthState {
  AuthIdleState();
 
  @override
  List<Object?> get props => [ ];
}

class AuthLoadingState extends CubitLoadingState with AuthState {
  const AuthLoadingState();
}

class NoCompletedUserState extends CubitInformationState with AuthState {
  const NoCompletedUserState();
}

class CompletedUserSuccessUserState extends CubitInformationState
    with AuthState {
  const CompletedUserSuccessUserState();
}

class AuthErrorState extends CubitErrorState with AuthState {
  AuthErrorState(super.error, [super.trace]);
}
