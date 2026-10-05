import 'package:shattably/core/errors/app_failure.dart';
import 'package:shattably/features/offers/domain/offers_repository.dart';

class SubmitOffer {
  const SubmitOffer(this.repository);
  final OffersRepository repository;
  Future<String> call(OfferDraft draft) {
    final price = double.tryParse(draft.price.trim());
    if (draft.orderId.isEmpty ||
        price == null ||
        !price.isFinite ||
        price <= 0 ||
        draft.endDate.trim().isEmpty) {
      throw const AppFailure(
          'validation', 'Enter a positive price and an end date.');
    }
    return repository.submit(draft);
  }
}

class GetOrderOffers {
  const GetOrderOffers(this.repository);
  final OffersRepository repository;
  Future<List<Offer>> call(String orderId) => repository.orderOffers(orderId);
}

class AcceptOffer {
  const AcceptOffer(this.repository);
  final OffersRepository repository;
  Future<OfferAcceptance> call(String orderId, String offerId) =>
      repository.accept(orderId, offerId);
}

class ResolveOfferOrder {
  const ResolveOfferOrder(this.repository);
  final OffersRepository repository;
  Future<String> call(String offerId) => repository.orderForOffer(offerId);
}
