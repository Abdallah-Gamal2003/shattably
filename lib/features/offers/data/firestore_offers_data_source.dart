import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/errors/app_failure.dart';
import '../../orders/data/firestore_orders_data_source.dart';
import '../domain/offers_repository.dart';

Offer offerFromMap(String id, Map<String,dynamic> data) => Offer(id:id,
  orderId:data['orderId'] as String? ?? '', workerId:data['employeeId'] as String? ?? '',
  price:data['price']?.toString() ?? '', endDate:data['endData']?.toString() ?? '',
  workerName:data['name'] as String? ?? '', workerImage:data['image'] as String? ?? '');

class FirestoreOffersDataSource {
  FirestoreOffersDataSource(this.firestore);
  final FirebaseFirestore firestore;
  Future<String> submit(String workerId, OfferDraft draft) async {
    final reference = firestore.collection('offers').doc();
    await firestore.runTransaction((transaction) async {
      final order = await transaction.get(firestore.collection('orders').doc(draft.orderId));
      final profile = await transaction.get(firestore.collection('profiles').doc(workerId));
      if (!order.exists || order.data()!['status'] != 'pending' || order.data()!['offerId'] != null) {
        throw const AppFailure('conflict', 'This order is no longer available.');
      }
      if (order.data()!['clientID'] == workerId) throw const AppFailure('forbidden', 'You cannot offer on your own order.');
      if (!profile.exists) throw const AppFailure('profile-missing', 'Complete your profile before submitting an offer.');
      transaction.set(reference, {
        'offerId': reference.id, 'orderId':draft.orderId, 'employeeId':workerId,
        'price':draft.price.trim(), 'endData':draft.endDate.trim(),
        'name':profile.data()!['name'] ?? '', 'image':profile.data()!['image'] ?? '',
      });
    });
    return reference.id;
  }
  Future<List<Offer>> orderOffers(String id) async =>
    (await firestore.collection('offers').where('orderId', isEqualTo:id).get()).docs
      .map((doc) => offerFromMap(doc.id, doc.data())).toList();
  Future<String> orderForOffer(String id) async {
    final doc = await firestore.collection('offers').doc(id).get();
    if (!doc.exists) throw const AppFailure('not-found', 'Offer not found.');
    return offerFromMap(doc.id, doc.data()!).orderId;
  }
  Future<OfferAcceptance> accept(String customerId, String orderId, String offerId) =>
    firestore.runTransaction((transaction) async {
      final reference = firestore.collection('orders').doc(orderId);
      final orderDoc = await transaction.get(reference);
      final offerDoc = await transaction.get(firestore.collection('offers').doc(offerId));
      if (!orderDoc.exists || !offerDoc.exists) throw const AppFailure('not-found', 'Order or offer no longer exists.');
      final order = orderFromMap(orderDoc.id, orderDoc.data()!);
      final offer = offerFromMap(offerDoc.id, offerDoc.data()!);
      validateOfferAcceptance(order, offer, customerId);
      transaction.update(reference, {
        // Compatibility: completed means accepted, not that work was delivered.
        'status':'completed', 'offerId':offer.id, 'acceptedEmployeeId':offer.workerId,
        'price':offer.price, 'endData':offer.endDate, 'name':offer.workerName, 'image':offer.workerImage,
      });
      // This persisted transition is the future backend notification trigger.
      // Never send network notifications inside a retryable transaction callback.
      return OfferAcceptance(orderId, offerId, offer.workerId);
    });
}
