import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shattably/core/errors/app_failure.dart';
import 'package:shattably/features/orders/domain/orders_repository.dart';
import 'package:shattably/features/offers/domain/offers_repository.dart';
import 'package:shattably/features/offers/domain/offers_use_cases.dart';
import 'package:shattably/features/offers/data/firebase_offers_repository.dart';
import 'package:shattably/features/offers/data/firestore_offers_data_source.dart';
import 'profile_test.dart' show ProfileAuth;

class OfflineOffers implements FirestoreOffersDataSource {
  @override
  Future<OfferAcceptance> accept(String user,String order,String offer) async =>
    throw FirebaseException(plugin:'cloud_firestore',code:'unavailable');
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
void main() {
  ServiceRequest order({String owner='owner', OrderStatus status=OrderStatus.pending, String? offerId}) =>
    ServiceRequest(id:'order',customerId:owner,description:'test',city:'test',category:const ServiceCategory('test'),
      startDate:null,endDate:null,status:status,offerId:offerId);
  Offer offer({String orderId='order'}) => Offer(id:'offer',orderId:orderId,workerId:'worker',price:'100',endDate:'2030-01-04',workerName:'Example',workerImage:'');
  test('Acceptance requires ownership, matching order, pending status and no prior offer', () {
    expect(() => validateOfferAcceptance(order(),offer(),'owner'), returnsNormally);
    expect(() => validateOfferAcceptance(order(owner:'another'),offer(),'owner'), throwsA(isA<AppFailure>().having((e)=>e.code,'code','forbidden')));
    expect(() => validateOfferAcceptance(order(),offer(orderId:'another'),'owner'), throwsA(isA<AppFailure>().having((e)=>e.code,'code','invalid-offer')));
    for (final accepted in [order(status:OrderStatus.accepted),order(offerId:'first-offer')]) {
      expect(() => validateOfferAcceptance(accepted,offer(),'owner'), throwsA(isA<AppFailure>().having((e)=>e.code,'code','conflict')));
    }
  });
  test('Repository maps a Firebase failure to an application failure', () async {
    final accept = AcceptOffer(FirebaseOffersRepository(OfflineOffers(), ProfileAuth()));
    await expectLater(accept('order','offer'), throwsA(isA<AppFailure>().having((e)=>e.code,'code','unavailable')));
  });
  test('Invalid offer values never reach the data source', () {
    final submit = SubmitOffer(FirebaseOffersRepository(OfflineOffers(), ProfileAuth()));
    for (final price in ['0','-2','NaN','not-a-price']) {
      expect(() => submit(OfferDraft(orderId:'order',price:price,endDate:'2030-01-04')), throwsA(isA<AppFailure>()));
    }
  });
}
