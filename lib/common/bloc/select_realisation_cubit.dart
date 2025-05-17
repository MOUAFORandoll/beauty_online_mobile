import 'package:bloc/bloc.dart';

class SelectRealisationCubit extends Cubit<String> {
  SelectRealisationCubit() : super('');
  change(value) {
    emit(value);
  }
}
