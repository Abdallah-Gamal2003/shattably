import 'package:shattably/core/data/firebase_guard.dart';
import 'package:shattably/core/errors/app_failure.dart';
import 'package:shattably/features/auth/domain/auth_repository.dart';
import 'package:shattably/features/orders/domain/orders_repository.dart';
import 'package:shattably/features/orders/data/firestore_orders_data_source.dart';

class FirebaseOrdersRepository implements OrdersRepository {
  FirebaseOrdersRepository(this.source, this.auth);
  final FirestoreOrdersDataSource source;
  final AuthRepository auth;
  String get _id =>
      auth.currentUser?.id ??
      (throw const AppFailure('unauthenticated', 'Please sign in.'));
  @override
  Future<String> create(ServiceRequestDraft draft) =>
      firebaseGuard(() => source.create(_id, draft));
  @override
  Future<List<ServiceRequest>> customerOrders() =>
      firebaseGuard(() => source.customerOrders(_id));
  @override
  Stream<List<ServiceRequest>> availableOrders(
      String city, ServiceCategory category) async* {
    try {
      yield* source.watch(city, category);
    } catch (error) {
      throw mapFailure(error);
    }
  }

  @override
  Stream<List<ServiceRequest>> workerOrders(
      String city, ServiceCategory category) async* {
    try {
      yield* source.watch(city, category, workerId: _id);
    } catch (error) {
      throw mapFailure(error);
    }
  }

  @override
  Future<ServiceRequest> details(String id) =>
      firebaseGuard(() => source.details(id));
}
