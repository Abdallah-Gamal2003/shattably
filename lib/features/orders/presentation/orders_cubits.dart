import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/presentation/load_state.dart';
import '../domain/orders_repository.dart';
import '../domain/orders_use_cases.dart';

class CreateRequestCubit extends Cubit<LoadState<String>> {
  CreateRequestCubit(this.create) : super(const LoadState());
  final CreateServiceRequest create;
  Future<void> submit(ServiceRequestDraft draft) async {
    if (state.status == LoadStatus.loading) return;
    emit(const LoadState(status: LoadStatus.loading));
    try {
      final id = await create(draft);
      if (!isClosed) emit(LoadState(status: LoadStatus.success, data: id));
    } on AppFailure catch (error) {
      if (!isClosed) emit(LoadState(status: LoadStatus.failure, failure: error));
    }
  }
}
class CustomerOrdersCubit extends Cubit<LoadState<List<ServiceRequest>>> {
  CustomerOrdersCubit(this.getOrders) : super(const LoadState());
  final GetCustomerOrders getOrders;
  Future<void> load() async {
    emit(const LoadState(status: LoadStatus.loading));
    try {
      final orders = await getOrders();
      if (!isClosed) emit(LoadState(status: LoadStatus.success, data: orders));
    } on AppFailure catch (error) {
      if (!isClosed) emit(LoadState(status: LoadStatus.failure, failure: error));
    }
  }
}
class WorkerOrdersCubit extends Cubit<LoadState<List<ServiceRequest>>> {
  WorkerOrdersCubit(this.available, this.accepted) : super(const LoadState());
  final WatchAvailableOrders available;
  final WatchWorkerOrders accepted;
  StreamSubscription<List<ServiceRequest>>? _subscription;
  Future<void> watch(String city, ServiceCategory category, {bool last = false}) async {
    await _subscription?.cancel();
    if (isClosed) return;
    emit(const LoadState(status: LoadStatus.loading));
    _subscription = (last ? accepted(city, category) : available(city, category)).listen(
      (orders) { if (!isClosed) emit(LoadState(status: LoadStatus.success, data: orders)); },
      onError: (Object failure) { if (!isClosed) emit(LoadState(status: LoadStatus.failure, failure: failure is AppFailure ? failure : const AppFailure('stream', 'Unable to load orders.'))); });
  }
  @override
  Future<void> close() async { await _subscription?.cancel(); return super.close(); }
}
class OrderDetailsCubit extends Cubit<LoadState<ServiceRequest>> {
  OrderDetailsCubit(this.getDetails) : super(const LoadState());
  final GetOrderDetails getDetails;
  Future<void> load(String id) async {
    emit(const LoadState(status: LoadStatus.loading));
    try { final order = await getDetails(id); if (!isClosed) emit(LoadState(status: LoadStatus.success, data: order)); }
    on AppFailure catch (error) { if (!isClosed) emit(LoadState(status: LoadStatus.failure, failure: error)); }
  }
}
