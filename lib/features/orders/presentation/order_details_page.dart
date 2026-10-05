import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/load_state.dart';
import '../../../orderlist.dart';
import '../domain/orders_repository.dart';
import '../domain/orders_use_cases.dart';
import 'orders_cubits.dart';
import 'order_view_data.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => OrderDetailsCubit(GetOrderDetails(context.read<OrdersRepository>()))..load(orderId),
    child: BlocBuilder<OrderDetailsCubit, LoadState<ServiceRequest>>(builder: (context, state) {
      if (state.data != null) return OrderDetailsScreen(data: state.data!.toViewMap());
      return Scaffold(appBar: AppBar(), body: Center(child: state.failure != null
        ? Text(state.failure!.message) : const CircularProgressIndicator()));
    }),
  );
}
