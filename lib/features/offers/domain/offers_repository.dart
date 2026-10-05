import '../../../core/errors/app_failure.dart';
import '../../orders/domain/orders_repository.dart';

class Offer {
  const Offer({required this.id, required this.orderId, required this.workerId,
    required this.price, required this.endDate, required this.workerName, required this.workerImage});
  final String id, orderId, workerId, price, endDate, workerName, workerImage;
}
class OfferDraft {
  const OfferDraft({required this.orderId, required this.price, required this.endDate});
  final String orderId, price, endDate;
}
class OfferAcceptance {
  const OfferAcceptance(this.orderId, this.offerId, this.workerId);
  final String orderId, offerId, workerId;
}

/// Evaluated again against transaction reads, never against a stale screen model.
void validateOfferAcceptance(ServiceRequest order, Offer offer, String customerId) {
  if (order.customerId != customerId) throw const AppFailure('forbidden', 'Only the order owner can accept an offer.');
  if (offer.orderId != order.id || offer.workerId.isEmpty) throw const AppFailure('invalid-offer', 'This offer does not belong to this order.');
  if (order.status != OrderStatus.pending || (order.offerId?.isNotEmpty ?? false)) {
    throw const AppFailure('conflict', 'An offer has already been accepted or this order is no longer available.');
  }
}
abstract interface class OffersRepository {
  Future<String> submit(OfferDraft draft);
  Future<List<Offer>> orderOffers(String orderId);
  Future<OfferAcceptance> accept(String orderId, String offerId);
  Future<String> orderForOffer(String offerId);
}
