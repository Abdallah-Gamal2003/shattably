enum OrderStatus { pending, accepted, unknown }

class ServiceCategory {
  const ServiceCategory(this.name);
  final String name;
}

class ServiceRequest {
  const ServiceRequest(
      {required this.id,
      required this.customerId,
      required this.description,
      required this.city,
      required this.category,
      required this.startDate,
      required this.endDate,
      required this.status,
      this.offerId,
      this.workerId,
      this.price = '',
      this.offerEndDate = '',
      this.workerName = '',
      this.workerImage = ''});
  final String id, customerId, description, city;
  final ServiceCategory category;
  final DateTime? startDate, endDate;
  final OrderStatus status;
  final String? offerId, workerId;
  final String price, offerEndDate, workerName, workerImage;
}

class ServiceRequestDraft {
  const ServiceRequestDraft(
      {required this.description,
      required this.city,
      required this.category,
      required this.startDate,
      required this.endDate});
  final String description, city;
  final ServiceCategory category;
  final DateTime? startDate, endDate;
}

abstract interface class OrdersRepository {
  Future<String> create(ServiceRequestDraft draft);
  Future<List<ServiceRequest>> customerOrders();
  Stream<List<ServiceRequest>> availableOrders(
      String city, ServiceCategory category);
  Stream<List<ServiceRequest>> workerOrders(
      String city, ServiceCategory category);
  Future<ServiceRequest> details(String id);
}
