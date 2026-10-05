import 'package:shattably/features/profile/presentation/worker_profile_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shattably/features/home/presention/widgets/orders/order_service_item.dart';
// import 'package:shattably/offers.dart';
//
// import '../../../../../components/components.dart';
// import '../../layout/cubit/cubit.dart';
// import '../../layout/cubit/states.dart';
// import '../Rate/rate_page.dart';
//
//
// class OrderScreen extends StatefulWidget {
//   @override
//   State<OrderScreen> createState() => _OrderScreenState();
// }
//
// class _OrderScreenState extends State<OrderScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     ServiceCubit.get(context).getOrders();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
//       listener:(context, state) {},
//       builder: (context, state) {
//         if (state is ServiceGetOrdersErrorState) {
//           return Scaffold(
//             body: Center(
//               child: Text('Error' + state.error),
//             ),
//           );
//         }
//         if (state is ServiceGetOrdersLoadingState) {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//         List allOrders = ServiceCubit.get(context).myOrders;
//         List pendingOrders = allOrders.where((order) => order.data()['status'] == 'pending').toList();
//         List completedOrders = allOrders.where((order) => order.data()['status'] == 'completed').toList();
//
//         return DefaultTabController(
//           length: 2,
//           child: Scaffold(
//             appBar: AppBar(
//               title: const TabBar(
//                 indicatorColor: Colors.green, // Set custom indicator color here
//
//                 tabs: [
//
//                   Tab( child: Text('pinding orders ', style: TextStyle(
//                     fontSize: 20 ,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal' ,
//                     color: Colors.green
//
//                   ),),
//
//
//                   ),
//                   Tab(child: Text('completed orders ', style: TextStyle(
//                     fontSize: 18 ,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Tajawal' ,
//                       color: Colors.green
//
//                   ),),),
//                 ],
//               ),
//             ),
//             body: TabBarView(
//               children: [
//                 buildPOrderList(pendingOrders),
//                 buildCOrderList(completedOrders),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//   Widget buildPOrderList(List orders) {
//     if (orders.isEmpty) {
//       return Center(
//         child: Text('No orders found' ,
//           style: TextStyle(
//             fontFamily: 'Tajawal',
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             fontSize: 32,
//
//           ),
//         ),
//       );
//     }
//     return ListView.builder(
//       itemCount: orders.length,
//       itemBuilder: (context, index) {
//         return OrderItem(
//           order: orders[index].data(),
//         );
//       },
//     );
//   }
//   Widget buildCOrderList(List orders) {
//     if (orders.isEmpty) {
//       return Center(
//         child: Text('No orders found'),
//       );
//     }
//     return ListView.builder(
//       itemCount: orders.length,
//       itemBuilder: (context, index) {
//         return CompletedOrderItem(
//           order: orders[index].data(),
//         );
//       },
//     );
//   }
//
// }
//
// class OrderItem extends StatelessWidget {
//   final Map<String, dynamic> order;
//   const OrderItem({required this.order});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OffersScreen(orderId: order['orderId']),
//           ),
//         );
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         elevation: 5,
//         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // First row with Start Date and End Date
//               Column(
//
//                 children: [
//                   Text(
//                     ' Start Date: ${order['start_date']}',
//                     style: TextStyle(
//                       fontFamily: 'Tajawal',
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   Text(
//                     'End Date: ${order['end_date']}',
//                     style: TextStyle(
//                       fontFamily: 'Tajawal',
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//
//               // Second row with Job Type and City
//               Column(
//
//                 children: [
//                   Text(
//                     'Job Type: ${order['jobType']}',
//                     style: TextStyle(
//                       fontFamily: 'Tajawal',
//                       fontSize: 16,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   Text(
//                     'City: ${order['city']}',
//                     style: TextStyle(
//                       fontFamily: 'Tajawal',
//                       fontSize: 16,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//
//               // Centered order text
//               Center(
//                 child: Text(
//                   'Order: ${order['order']}',
//                   style: TextStyle(
//                     fontFamily: 'Tajawal',
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
// }
// class CompletedOrderItem extends StatelessWidget {
//   final Map<String, dynamic> order;
//   const CompletedOrderItem({required this.order});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         openProfile(context, order["acceptedEmployeeId"]);
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Card(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: NetworkImage(
//                         order['image'] != null && order['image'] != "null"
//                             ? order['image']
//                             : 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
//                       ),
//                     ),
//
//                     SizedBox(width: 10,),
//                     Text(order['name'],
//                       style: TextStyle(
//                         fontSize: 25 ,
//                         fontWeight: FontWeight.bold ,
//                         fontFamily: 'Tajawal',
//                         color: Colors.deepOrange ,
//                       ),
//                     ),
//
//                     SizedBox(width: 5,),
//                     Icon(Icons.verified, color: Colors.grey, size: 19,)
//                   ],
//                 ),
//
//                 SizedBox(height: 30,) ,
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Start Date: ${order['start_date']}',
//                       style: TextStyle(
//                         fontSize: 18 ,
//                         fontWeight: FontWeight.bold ,
//                         fontFamily: 'Tajawal',
//                         color: Colors.deepOrange ,
//
//                       ),
//                     ),
//
//                   ],
//                 ),
//                 SizedBox(height: 6,),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//
//                     Text('End Date: ${order['end_date']}',
//                       style: TextStyle(
//                         fontSize: 18 ,
//                         fontWeight: FontWeight.bold ,
//                         fontFamily: 'Tajawal',
//                         color: Colors.deepOrange ,
//
//                       ),),
//                   ],
//                 ),
//                 SizedBox(height: 6,),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Job Type: ${order['jobType']}',
//                   style: TextStyle(
//                   fontSize: 18 ,
//                   fontWeight: FontWeight.bold ,
//                 fontFamily: 'Tajawal',
//                   color: Colors.deepOrange ,
//
//                 ),),
//
//                   ],
//                 ),
//                 SizedBox(height: 6,),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//
//                     Text('City: ${order['city']}' ,
//                       style: TextStyle(
//                         fontSize: 18 ,
//                         fontWeight: FontWeight.bold ,
//                         fontFamily: 'Tajawal',
//                         color: Colors.deepOrange ,
//
//                       ),),
//                   ],
//                 ),
//                 SizedBox(height: 6,) ,
//                 Center(child: Text(' ${order['order']}',
//     style: TextStyle(
//     fontSize: 25 ,
//     fontWeight: FontWeight.bold ,
//     fontFamily: 'Tajawal',
//     color: Colors.black87 ,
//
//     ),  ), ),
//                 SizedBox(height: 10,),
//                 Text("Accepted Offer:" ,
//                 style: TextStyle(
//                   fontSize: 18 ,
//                   fontWeight: FontWeight.bold ,
//                   fontFamily: 'Tajawal',
//                   color: Colors.grey ,
//
//                 )
//                 ),
//                 SizedBox(height: 10,),
//
//                 Row (
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Price   : "+order['price'],
//                         style: TextStyle(
//                           fontSize: 18 ,
//                           fontWeight: FontWeight.bold ,
//                           fontFamily: 'Tajawal',
//                           color: Colors.deepOrange ,
//
//                         )),
//
//                   ],
//                 ),
//                 Row (
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//
//                     Text("End date: "+order['endData'],
//                         style: TextStyle(
//                           fontSize: 18 ,
//                           fontWeight: FontWeight.bold ,
//                           fontFamily: 'Tajawal',
//                           color: Colors.deepOrange ,
//
//                         )),
//                   ],
//                 ),
//                 SizedBox(height: 20,),
//                 Row(
//                   children: [
//                     Text('rate the worker here  ',
//                       style: TextStyle(
//                         fontFamily: 'Tajawal', // Font family
//                         fontWeight: FontWeight.w900,
//                         fontSize: 15, // Font size
//                         color: Colors.grey,
//
//                       ),),
//                   ],
//                 ),
//                 Row(
//                   children:
//                   [
//                      Center(
//                        child: ElevatedButton(
//                           onPressed: () {
//                             navigateTo(context, RatePage());
//
//
//
//
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.deepOrange, // Background color
//                             foregroundColor: Colors.white, // Text color
//                             textStyle: TextStyle(
//                               fontFamily: 'Tajawal', // Font family
//                               fontWeight: FontWeight.bold,
//                               // Font weight
//                               fontSize: 20.0, // Font size
//                             ),
//                           ),
//                           child: Text('Rate'),
//                         ),
//                      ),
//
//                   ],
//                 )
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/offers.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    ServiceCubit.get(context).getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ServiceGetOrdersErrorState) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${state.error}'),
            ),
          );
        }
        if (state is ServiceGetOrdersLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        List allOrders = ServiceCubit.get(context).myOrders;
        List pendingOrders = allOrders.where((order) => order.data()['status'] == 'pending').toList();
        List completedOrders = allOrders.where((order) => order.data()['status'] == 'completed').toList();

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

  Widget buildOrderList(List orders, String emptyMessage) {
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
        final order = orders[index].data();
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

