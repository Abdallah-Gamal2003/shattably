import 'package:shattably/features/offers/presentation/offer_notification_page.dart';
import 'dart:async';
import 'package:shattably/notificationservice.dart';
import 'package:shattably/features/offers/presentation/order_offers_screen.dart';
import 'package:shattably/features/orders/presentation/order_details_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/features/profile/domain/profile_repository.dart';
import 'package:shattably/features/profile/presentation/profile_cubits.dart';
import 'package:shattably/core/presentation/load_state.dart';
import 'package:shattably/features/home/presentation/layout/service_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:shattably/features/orders/presentation/worker_orders_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<Map<String, dynamic>>? _notifications;
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().load(clear: true);
    _notifications = NotificationService.opened.listen(_openNotification);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final payload = NotificationService.takePending();
      if (payload != null) _openNotification(payload);
    });
  }

  void _openNotification(Map<String, dynamic> payload) {
    if (!mounted) return;
    if (payload['key'] == 'offerEvent' &&
        payload['orderId'] == null &&
        payload['id'] is String) {
      Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (_) =>
              OfferNotificationPage(offerId: payload['id'] as String)));
      return;
    }
    final id = payload['orderId'] ??
        (payload['key'] == 'orderEvent' ? payload['id'] : null);
    if (id is! String || id.isEmpty) return;
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (_) => payload['key'] == 'offerEvent'
            ? OffersScreen(orderId: id)
            : OrderDetailsPage(orderId: id)));
  }

  @override
  void dispose() {
    _notifications?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, LoadState<UserProfile>>(
        builder: (context, state) {
      final profile = state.data;
      if (profile != null) {
        return profile.isCustomer
            ? const ServiceLayout()
            : OrdersList(workerCity: profile.city, workerJobType: profile.job);
      }
      return Scaffold(
          body: Center(
              child: state.failure != null
                  ? Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(state.failure!.message),
                      TextButton(
                          onPressed: () => context.read<ProfileCubit>().load(),
                          child: const Text('Retry'))
                    ])
                  : const CircularProgressIndicator()));
    });
  }
}
