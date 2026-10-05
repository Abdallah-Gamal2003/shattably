import 'package:shattably/core/errors/app_failure.dart';

enum LoadStatus { initial, loading, success, failure }

class LoadState<T> {
  const LoadState({this.status = LoadStatus.initial, this.data, this.failure});
  final LoadStatus status;
  final T? data;
  final AppFailure? failure;
}
