import 'dart:async';
import 'notificationservice.dart';
import 'offers.dart';
import 'features/orders/presentation/order_details_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/profile/domain/profile_repository.dart';
import 'features/profile/presentation/profile_cubits.dart';
import 'core/presentation/load_state.dart';
import 'package:shattably/features/home/presention/layout/service_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:shattably/orderlist.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<Map<String,dynamic>>? _notifications;
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().load();
    _notifications = NotificationService.opened.listen(_openNotification);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final payload = NotificationService.takePending();
      if (payload != null) _openNotification(payload);
    });
  }

  void _openNotification(Map<String,dynamic> payload) {
    if (!mounted) return;
    final id = payload['orderId'] ?? (payload['key'] == 'orderEvent' ? payload['id'] : null);
    if (id is! String || id.isEmpty) return;
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => payload['key'] == 'offerEvent'
      ? OffersScreen(orderId: id) : OrderDetailsPage(orderId: id)));
  }
  @override
  void dispose() { _notifications?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, LoadState<UserProfile>>(builder: (context, state) {
      final profile = state.data;
      if (profile != null) {
        return profile.isCustomer ? const ServiceLayout() : OrdersList(workerCity: profile.city, workerJobType: profile.job);
      }
      return Scaffold(body: Center(child: state.failure != null
        ? Column(mainAxisSize: MainAxisSize.min, children: [Text(state.failure!.message),
            TextButton(onPressed: () => context.read<ProfileCubit>().load(), child: const Text('Retry'))])
        : const CircularProgressIndicator()));
    });
  }
}