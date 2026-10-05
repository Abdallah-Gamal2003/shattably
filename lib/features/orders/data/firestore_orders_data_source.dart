import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shattably/core/errors/app_failure.dart';
import 'package:shattably/features/orders/domain/orders_repository.dart';

String dateText(DateTime? value) =>
    value?.toIso8601String().split('T').first ?? '';
DateTime? _date(dynamic value) => value is Timestamp
    ? value.toDate()
    : DateTime.tryParse(value?.toString().trim() ?? '');
ServiceRequest orderFromMap(String id, Map<String, dynamic> data) =>
    ServiceRequest(
        id: id,
        customerId: data['clientID'] as String? ?? '',
        description: data['order'] as String? ?? '',
        city: data['city'] as String? ?? '',
        category: ServiceCategory(data['jobType'] as String? ?? ''),
        startDate: _date(data['start_date']),
        endDate: _date(data['end_date']),
        status: switch (data['status']) {
          'pending' => OrderStatus.pending,
          'completed' => OrderStatus.accepted,
          _ => OrderStatus.unknown
        },
        offerId: data['offerId'] as String?,
        workerId: data['acceptedEmployeeId'] as String?,
        price: data['price']?.toString() ?? '',
        offerEndDate: data['endData']?.toString() ?? '',
        workerName: data['name'] as String? ?? '',
        workerImage: data['image'] as String? ?? '');

Map<String, dynamic> newOrderFields(
        String id, String customerId, ServiceRequestDraft draft) =>
    {
      'orderId': id,
      'clientID': customerId,
      'order': draft.description.trim(),
      'city': draft.city.trim(),
      'jobType': draft.category.name,
      'start_date': dateText(draft.startDate),
      'end_date': dateText(draft.endDate),
      'status': 'pending',
    };

class FirestoreOrdersDataSource {
  FirestoreOrdersDataSource(this.firestore);
  final FirebaseFirestore firestore;
  Future<String> create(String customerId, ServiceRequestDraft draft) async {
    final reference = firestore.collection('orders').doc();
    await reference.set(newOrderFields(reference.id, customerId, draft));
    return reference.id;
  }

  Future<List<ServiceRequest>> customerOrders(String id) async =>
      (await firestore
              .collection('orders')
              .where('clientID', isEqualTo: id)
              .get())
          .docs
          .map((doc) => orderFromMap(doc.id, doc.data()))
          .toList();
  Stream<List<ServiceRequest>> watch(String city, ServiceCategory category,
      {String? workerId}) {
    var query = firestore
        .collection('orders')
        .where('city', isEqualTo: city)
        .where('jobType', isEqualTo: category.name)
        .where('status', isEqualTo: workerId == null ? 'pending' : 'completed');
    if (workerId != null)
      query = query.where('acceptedEmployeeId', isEqualTo: workerId);
    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => orderFromMap(doc.id, doc.data())).toList());
  }

  Future<ServiceRequest> details(String id) async {
    final doc = await firestore.collection('orders').doc(id).get();
    if (!doc.exists) throw const AppFailure('not-found', 'Order not found.');
    return orderFromMap(doc.id, doc.data()!);
  }
}
