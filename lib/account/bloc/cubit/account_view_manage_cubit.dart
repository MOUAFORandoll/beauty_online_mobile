import 'package:bloc/bloc.dart';

class AccountViewManageCubit extends Cubit<bool> {
  AccountViewManageCubit() : super(true);
  changeView(value) {
    emit(value);
  }
}
