import 'offers_cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/core/presentation/load_state.dart';
import 'package:shattably/features/offers/domain/offers_repository.dart';
import 'package:shattably/features/offers/domain/offers_use_cases.dart';
import 'order_offers_screen.dart';

/// Compatibility with legacy notifications that carry an offer ID, not orderId.
class OfferNotificationPage extends StatelessWidget {
  const OfferNotificationPage({super.key, required this.offerId});
  final String offerId;
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => OfferNotificationCubit(
            ResolveOfferOrder(context.read<OffersRepository>()))
          ..load(offerId),
        child: BlocBuilder<OfferNotificationCubit, LoadState<String>>(
            builder: (context, state) {
          if (state.data != null) return OffersScreen(orderId: state.data!);
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                  child: state.failure == null
                      ? const CircularProgressIndicator()
                      : Text(state.failure!.message)));
        }),
      );
}
