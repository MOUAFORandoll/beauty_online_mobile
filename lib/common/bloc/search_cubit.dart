import 'dart:async';

import 'package:potatoes/auto_list.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/services/api_error.dart';

class SearchCubit<T> extends AutoListCubit<T> {
  final Duration sleepDuration;
  final Future<PaginatedList<T>> Function(
      {required String search,
      int page,
      CancelToken? cancelToken}) proceedSearch;
  final int minimumQueryLength;

  CancelToken? _cancelToken;
  Timer? _timer;
  String _query = '';
  String get queryText => _query;

  SearchCubit(
      {required this.proceedSearch,
      required this.sleepDuration,
      this.minimumQueryLength = 2})
      : super(
            provider: ({page = 1}) =>
                Future.value(PaginatedList(items: <T>[], page: 0, total: 0)));

  set query(String value) {
    if (value == _query) return;
    emit(AutoListLoadingState<T>());
    if (value.length < minimumQueryLength) return;
    _query = value;
    _setTimer();
  }

  void _setTimer() {
    _timer?.cancel();
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    _timer = Timer(sleepDuration, reset);
  }

  @override
  void initialize() async {
    try {
      final result = await (provider as DataProvider<T>).call();
      emit(AutoListReadyState<T>(result));
    } catch (error, trace) {
      if (error is ApiError &&
          error.dio is DioException &&
          error.dio!.type == DioExceptionType.cancel) {
        emit(const AutoListLoadingState());
      } else {
        emit(AutoListErrorState(error, trace));
      }
    }
  }

  @override
  dynamic get provider {
    if (_query.isEmpty) return baseProvider;

    return ({int page = 1}) =>
        proceedSearch(search: _query, page: page, cancelToken: _cancelToken);
  }

  void cancel() {
    _timer?.cancel();
    _cancelToken?.cancel();
  }
}
