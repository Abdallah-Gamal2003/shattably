import 'package:flutter_test/flutter_test.dart';
import 'package:shattably/core/errors/app_failure.dart';
import 'package:shattably/features/orders/domain/orders_repository.dart';
import 'package:shattably/features/orders/domain/orders_use_cases.dart';
import 'package:shattably/features/orders/data/firestore_orders_data_source.dart';

class RecordingOrders implements OrdersRepository {
  ServiceRequestDraft? created;
  @override
  Future<String> create(ServiceRequestDraft draft) async { created = draft; return 'new-order'; }
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
void main() {
  final today = DateTime(2030, 1, 2);
  ServiceRequestDraft draft({String description='Fix sink', String city='Example', DateTime? start, DateTime? end}) =>
    ServiceRequestDraft(description:description, city:city, category: const ServiceCategory('سباك'), startDate:start, endDate:end);
  test('Invalid, missing and reversed date ranges never reach the repository', () {
    final repository = RecordingOrders();
    final create = CreateServiceRequest(repository, clock: () => today);
    for (final input in [draft(), draft(start:today,end:today.subtract(const Duration(days:1))),
      draft(start:today.subtract(const Duration(days:1)),end:today), draft(description:' ',start:today,end:today),
      draft(city:'',start:today,end:today)]) {
      expect(() => create(input), throwsA(isA<AppFailure>()));
    }
    expect(repository.created, null);
  });
  test('A valid request produces a complete legacy-compatible document in one payload', () async {
    final repository = RecordingOrders();
    final input = draft(start:today,end:today.add(const Duration(days:2)));
    expect(await CreateServiceRequest(repository, clock: () => today)(input), 'new-order');
    final fields = newOrderFields('new-order','owner',repository.created!);
    expect(fields, containsPair('clientID','owner'));
    expect(fields, containsPair('status','pending'));
    expect(fields.keys, containsAll(['orderId','order','city','jobType','start_date','end_date']));
    expect(orderFromMap('new-order', {...fields,'status':'completed'}).status, OrderStatus.accepted);
  });
}
