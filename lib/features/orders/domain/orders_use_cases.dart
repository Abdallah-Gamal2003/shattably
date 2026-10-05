import '../../../core/errors/app_failure.dart';
import 'orders_repository.dart';

class CreateServiceRequest {
  CreateServiceRequest(this.repository, {DateTime Function()? clock}) : clock = clock ?? DateTime.now;
  final OrdersRepository repository;
  final DateTime Function() clock;
  Future<String> call(ServiceRequestDraft draft) {
    final now = clock();
    final today = DateTime(now.year, now.month, now.day);
    if (draft.description.trim().isEmpty || draft.city.trim().isEmpty || draft.category.name.trim().isEmpty) {
      throw const AppFailure('validation', 'Description, city and service are required.');
    }
    if (draft.startDate == null || draft.endDate == null ||
        draft.startDate!.isBefore(today) || draft.endDate!.isBefore(draft.startDate!)) {
      throw const AppFailure('validation', 'Select a valid start and end date, starting today or later.');
    }
    return repository.create(draft);
  }
}
class GetCustomerOrders {
  const GetCustomerOrders(this.repository);
  final OrdersRepository repository;
  Future<List<ServiceRequest>> call() => repository.customerOrders();
}
class WatchAvailableOrders {
  const WatchAvailableOrders(this.repository);
  final OrdersRepository repository;
  Stream<List<ServiceRequest>> call(String city, ServiceCategory category) => repository.availableOrders(city, category);
}
class WatchWorkerOrders {
  const WatchWorkerOrders(this.repository);
  final OrdersRepository repository;
  Stream<List<ServiceRequest>> call(String city, ServiceCategory category) => repository.workerOrders(city, category);
}
class GetOrderDetails {
  const GetOrderDetails(this.repository);
  final OrdersRepository repository;
  Future<ServiceRequest> call(String id) => repository.details(id);
}
