import 'package:shattably/features/orders/domain/orders_repository.dart';
import 'package:shattably/features/orders/domain/orders_use_cases.dart';
import 'package:shattably/features/orders/presentation/orders_cubits.dart';
import 'package:shattably/features/orders/presentation/order_view_data.dart';
import 'package:shattably/core/presentation/load_state.dart';
import 'package:shattably/features/profile/presentation/worker_profile_page.dart';



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/offers.dart';


class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerOrdersCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerOrdersCubit, LoadState<List<ServiceRequest>>>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == LoadStatus.failure) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${state.failure!.message}'),
            ),
          );
        }
        if (state.status == LoadStatus.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        List<ServiceRequest> allOrders = state.data ?? <ServiceRequest>[];
        List<ServiceRequest> pendingOrders = allOrders.where((order) => order.toViewMap()['status'] == 'pending').toList();
        List<ServiceRequest> completedOrders = allOrders.where((order) => order.toViewMap()['status'] == 'completed').toList();

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const TabBar(
                indicatorColor: Colors.green,
                tabs: [
                  Tab(
                    child: Text(
                      'الطلبات المنتظرة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'الطلبات المكتملة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                buildOrderList(pendingOrders, 'لا توجد طلبات منتظرة'),
                buildOrderList(completedOrders, 'لا توجد طبات مكتملة'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildOrderList(List<ServiceRequest> orders, String emptyMessage) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: const TextStyle(
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index].toViewMap();
        return order['status'] == 'completed'
            ? CompletedOrderItem(order: order)
            : OrderItem(order: order);
      },
    );
  }
}

class OrderItem extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OffersScreen(orderId: order['orderId']),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderRow('تاريخ البداية', order['start_date']),
              const SizedBox(height: 8),
              _buildOrderRow('تاريخ النهاية', order['end_date']),
              const SizedBox(height: 8),
              _buildOrderRow('الوظيفة', order['jobType']),
              const SizedBox(height: 8),
              _buildOrderRow('المحافظة', order['city']),
              const SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Tajawal',
            color: Colors.black87,
          ),
        ),
        Text(
          ':$label ',
          style: const TextStyle(
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),

      ],
    );
  }
}

class CompletedOrderItem extends StatelessWidget {
  final Map<String, dynamic> order;
  const CompletedOrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openProfile(context, order["acceptedEmployeeId"]);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileRow(order),
              const SizedBox(height: 20),
              _buildOrderDetail(':تاريخ البداية', order['start_date']),
              const SizedBox(height: 10),
              _buildOrderDetail(':تاريخ النهاية', order['end_date']),
              const SizedBox(height: 10),
              _buildOrderDetail(':الوظيفة', order['jobType']),
              const SizedBox(height: 10),
              _buildOrderDetail(':المحافظة', order['city']),
              const SizedBox(height: 20),
              const Center(
                child: Text('العرض المقبول',
                  style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                  color: Colors.green,
                ),),
              ),
              const SizedBox(height: 10),
              _buildOrderDetail( ':السعر', order['price']),
              const SizedBox(height: 10),
              _buildOrderDetail( ':تايخ نهاية العرض', order['endData']),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileRow(Map<String, dynamic> order) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            order['image'] != null && order['image'] != "null"
                ? order['image']
                : 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
          ),
        ),
        const SizedBox(width: 10),
        Text(
          order['name'],
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal',
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 5),
        const Icon(Icons.verified, color: Colors.grey, size: 19),
      ],
    );
  }

  Widget _buildOrderDetail(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Tajawal',
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal',
            color: Colors.green,
          ),
        ),

      ],
    );
  }
}
