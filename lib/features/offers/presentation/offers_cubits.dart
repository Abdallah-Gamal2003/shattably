import 'package:bloc/bloc.dart';
import 'package:shattably/core/errors/app_failure.dart';
import 'package:shattably/core/presentation/load_state.dart';
import 'package:shattably/features/offers/domain/offers_repository.dart';
import 'package:shattably/features/offers/domain/offers_use_cases.dart';

class SubmitOfferCubit extends Cubit<LoadState<String>> {
  SubmitOfferCubit(this.submitOffer) : super(const LoadState());
  final SubmitOffer submitOffer;
  Future<void> submit(OfferDraft draft) async {
    if (state.status == LoadStatus.loading) return;
    emit(const LoadState(status: LoadStatus.loading));
    try {
      final id = await submitOffer(draft);
      if (!isClosed) emit(LoadState(status: LoadStatus.success, data: id));
    } on AppFailure catch (error) {
      if (!isClosed)
        emit(LoadState(status: LoadStatus.failure, failure: error));
    }
  }
}

class OrderOffersState {
  const OrderOffersState(
      {this.offers = const [],
      this.loading = false,
      this.acceptance,
      this.failure});
  final List<Offer> offers;
  final bool loading;
  final OfferAcceptance? acceptance;
  final AppFailure? failure;
}

class OrderOffersCubit extends Cubit<OrderOffersState> {
  OrderOffersCubit(this.getOffers, this.acceptOffer)
      : super(const OrderOffersState());
  final GetOrderOffers getOffers;
  final AcceptOffer acceptOffer;
  Future<void> load(String orderId) async {
    emit(const OrderOffersState(loading: true));
    try {
      final offers = await getOffers(orderId);
      if (!isClosed) emit(OrderOffersState(offers: offers));
    } on AppFailure catch (error) {
      if (!isClosed) emit(OrderOffersState(failure: error));
    }
  }

  Future<void> accept(String orderId, String offerId) async {
    if (state.loading || state.acceptance != null) return;
    final offers = state.offers;
    emit(OrderOffersState(offers: offers, loading: true));
    try {
      final receipt = await acceptOffer(orderId, offerId);
      if (!isClosed)
        emit(OrderOffersState(offers: offers, acceptance: receipt));
    } on AppFailure catch (error) {
      if (!isClosed) emit(OrderOffersState(offers: offers, failure: error));
    }
  }
}

class OfferNotificationCubit extends Cubit<LoadState<String>> {
  OfferNotificationCubit(this.resolve) : super(const LoadState());
  final ResolveOfferOrder resolve;
  Future<void> load(String id) async {
    try {
      final orderId = await resolve(id);
      if (!isClosed) emit(LoadState(status: LoadStatus.success, data: orderId));
    } on AppFailure catch (error) {
      if (!isClosed)
        emit(LoadState(status: LoadStatus.failure, failure: error));
    }
  }
}
