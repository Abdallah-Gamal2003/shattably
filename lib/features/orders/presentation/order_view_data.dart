import '../domain/orders_repository.dart';

/// Adapts typed entities to the existing card layouts during incremental migration.
extension OrderViewData on ServiceRequest {
  Map<String,dynamic> toViewMap() => {
    'orderId': id, 'clientID': customerId, 'order': description, 'city': city, 'jobType': category.name,
    'start_date': startDate?.toIso8601String().split('T').first ?? '',
    'end_date': endDate?.toIso8601String().split('T').first ?? '',
    'status': switch(status) { OrderStatus.pending => 'pending', OrderStatus.accepted => 'completed', _ => 'unknown' },
    'offerId': offerId, 'acceptedEmployeeId': workerId, 'price': price, 'endData': offerEndDate,
    'name': workerName, 'image': workerImage,
  };
}
