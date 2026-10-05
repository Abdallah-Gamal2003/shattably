import 'package:shattably/features/offers/presentation/submit_offer_page.dart';
import 'package:shattably/features/orders/domain/orders_repository.dart';
import 'package:shattably/features/orders/domain/orders_use_cases.dart';
import 'package:shattably/features/orders/presentation/orders_cubits.dart';
import 'package:shattably/features/orders/presentation/order_view_data.dart';
import 'package:shattably/core/presentation/load_state.dart';
import 'package:shattably/features/orders/presentation/order_details_page.dart';
import 'package:shattably/features/profile/presentation/worker_profile_page.dart';
import 'package:shattably/features/auth/presentation/auth_cubits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/features/auth/presentation/login_screen.dart';
import 'package:shattably/features/profile/presentation/profile_screen.dart';

enum MenuAction { signOut, profile, availableOrders, lastOrders }

class OrdersList extends StatefulWidget {
  final bool last;
  final dynamic workerCity;
  final dynamic workerJobType;

  const OrdersList(
      {super.key,
      required this.workerCity,
      required this.workerJobType,
      this.last = false});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  late final WorkerOrdersCubit _orders;
  @override
  void initState() {
    super.initState();
    final repository = context.read<OrdersRepository>();
    _orders = WorkerOrdersCubit(
        WatchAvailableOrders(repository), WatchWorkerOrders(repository))
      ..watch(widget.workerCity, ServiceCategory(widget.workerJobType),
          last: widget.last);
  }

  @override
  void dispose() {
    _orders.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.last ? "الطلبات المقبولة" : "الطلبات المتاحة",
          style: const TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 25,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<MenuAction>(
            color: Colors.green,
            onSelected: (value) => _handleMenuAction(value),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuAction>>[
              _buildMenuItem(
                  MenuAction.signOut, Icons.exit_to_app, 'تسجيل خروج'),
              _buildMenuItem(
                  MenuAction.profile, Icons.person, 'الصفحة الشخصية'),
              _buildMenuItem(
                  MenuAction.availableOrders, Icons.list, 'الطلبات المتاحة'),
              _buildMenuItem(
                  MenuAction.lastOrders, Icons.timer, 'الطلبات المقبولة'),
            ],
          ),
        ],
      ),
      body: BlocBuilder<WorkerOrdersCubit, LoadState<List<ServiceRequest>>>(
        bloc: _orders,
        builder: (context, snapshot) {
          if (snapshot.failure != null)
            return Center(child: Text(snapshot.failure!.message));
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              ServiceRequest order = snapshot.data![index];
              return OrderCard(order: order, last: widget.last);
            },
          );
        },
      ),
    );
  }

  PopupMenuItem<MenuAction> _buildMenuItem(
      MenuAction action, IconData icon, String text) {
    return PopupMenuItem<MenuAction>(
      value: action,
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleMenuAction(MenuAction value) async {
    switch (value) {
      case MenuAction.signOut:
        await context.read<SessionCubit>().logout();
        if (!mounted) return;
        if (context.read<SessionCubit>().state.data == null) {
          navigateAndFinish(context, const ServiceLoginScreen());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Unable to sign out. Please retry.')));
        }
        break;
      case MenuAction.profile:
        navigateTo(context, const ProfileScreen());
        break;
      case MenuAction.lastOrders:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OrdersList(
                workerCity: widget.workerCity,
                workerJobType: widget.workerJobType,
                last: true),
          ),
        );
        break;
      case MenuAction.availableOrders:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OrdersList(
                workerCity: widget.workerCity,
                workerJobType: widget.workerJobType,
                last: false),
          ),
        );
        break;
    }
  }
}

class OrderCard extends StatelessWidget {
  final ServiceRequest order;
  final bool last;

  const OrderCard({super.key, required this.order, required this.last});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = order.toViewMap();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderDetailsPage(orderId: order.id)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                _buildOrderDetail(':تاريخ البداية', data['start_date'], 18),
                _buildOrderDetail(':تاريخ النهاية', data['end_date'], 18),
                if (last)
                  _buildOrderDetail(":الحالة", "تم قبول عرضك من العميل", 18),
                if (last) const SizedBox(height: 10),
                if (last)
                  ElevatedButton(
                    onPressed: () {
                      openProfile(context, data['clientID']);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                    ),
                    child: const Text(
                      'الصفحة الشخصية للعميل',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetail(String label, String value, double fontSize) {
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
          '$label ',
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

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  OrderDetailsScreen({super.key, required this.data}) {
    order = data["order"];
    sDate = data["start_date"];
    eDate = data["end_date"];
    orderId = data["orderId"];
    clientId = data["clientID"];
  }

  late final String order;
  late final String sDate;
  late final String eDate;
  late final String orderId;
  late final String clientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'تفاصيل الطلب',
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        iconTheme:
            const IconThemeData(color: Colors.green), // Back button color
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Icon(
                Icons.assignment,
                size: 100,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailText('الطلب', data['order']),
            _buildDetailText('تاريخ البداية', data['start_date']),
            _buildDetailText('تاريخ النهاية', data['end_date']),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                navigateTo(
                  context,
                  SetOfferPage(
                    orderId: orderId,
                    clientId: clientId,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'انشاء عرض',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            _buildSummaryCard(data),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> data) {
    return Card(
      color: Colors.green[50],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          // This makes the content scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'ملخص الطلب',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildDetailItem('الطلب:', data['order']),
              const SizedBox(height: 10),
              _buildDetailItem('تاريخ البداية:', data['start_date']),
              const SizedBox(height: 10),
              _buildDetailItem('تاريخ النهاية:', data['end_date']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 18,
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          softWrap: true, // Enables wrapping for long texts
        ),
      ],
    );
  }
}

Text _buildDetailText(String label, String value) {
  return Text(
    '$label: $value',
    style: const TextStyle(
      fontFamily: 'Tajawal',
      fontSize: 18,
      color: Colors.green,
      fontWeight: FontWeight.bold,
    ),
  );
}
