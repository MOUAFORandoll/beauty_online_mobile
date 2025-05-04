import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class AccountViewManageCubit extends Cubit<bool> {
  AccountViewManageCubit() : super(true);
  changeView(value) {
    emit(value);
  }
}
