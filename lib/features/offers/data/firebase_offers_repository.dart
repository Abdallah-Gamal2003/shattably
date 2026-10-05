import 'package:shattably/core/data/firebase_guard.dart';
import 'package:shattably/core/errors/app_failure.dart';
import 'package:shattably/features/auth/domain/auth_repository.dart';
import 'package:shattably/features/offers/domain/offers_repository.dart';
import 'package:shattably/features/offers/data/firestore_offers_data_source.dart';

class FirebaseOffersRepository implements OffersRepository {
  FirebaseOffersRepository(this.source, this.auth);
  final FirestoreOffersDataSource source;
  final AuthRepository auth;
  String get _id =>
      auth.currentUser?.id ??
      (throw const AppFailure('unauthenticated', 'Please sign in.'));
  @override
  Future<String> submit(OfferDraft draft) =>
      firebaseGuard(() => source.submit(_id, draft));
  @override
  Future<List<Offer>> orderOffers(String orderId) =>
      firebaseGuard(() => source.orderOffers(orderId));
  @override
  Future<OfferAcceptance> accept(String orderId, String offerId) =>
      firebaseGuard(() => source.accept(_id, orderId, offerId));
  @override
  Future<String> orderForOffer(String id) =>
      firebaseGuard(() => source.orderForOffer(id));
}
