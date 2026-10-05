// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'package:shattably/features/home/presention/layout/cubit/cubit.dart';
// // // import 'package:shattably/features/home/presention/layout/cubit/states.dart';
// // //
// // // import 'features/home/presention/widgets/orders/order_service_item.dart';
// // // class EmployeeHome extends StatelessWidget {
// // //   const EmployeeHome({Key? key}) : super(key: key);
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
// // //       listener: (context, state) {
// // //       },
// // //       builder: (context, state) {
// // //         return Scaffold(
// // //           backgroundColor: Colors.white70,
// // //           body:
// // //           SizedBox(),// ListView.builder(itemBuilder:(context, index) => OrderServiceItem(),itemCount: ),
// // //         );
// // //       },
// // //     );
// // //   }
// // // }
// // //
// //
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // import 'components/components.dart';
// // import 'getorder.dart';
// // import 'navigationservice.dart';
// //
// // void main() => runApp(MyApp());
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Orders'),
// //         ),
// //         body: OrdersList(),
// //       ),
// //     );
// //   }
// // }
// //
// // class OrdersList extends StatelessWidget {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: _firestore.collection('orders').snapshots(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) {
// //           return Center(child: CircularProgressIndicator());
// //         }
// //
// //         return ListView(
// //           children: snapshot.data!.docs.map((doc) {
// //             Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
// //             return Card(
// //               child: InkWell(
// //                 child:Column(children: [Row(children: [Text('Order: ${data['order']}'),],),
// //                 Row(children:[ Text('Start Date: ${data['start date']} - End Date: ${data['end date']}')],),],) ,
// //                 onTap: (){
// //                       FirebaseFirestore.instance.collection('orders').doc(data["orderId"]).get().then((value) {
// //                         navigateTo(context, Response(getorder: value.data()));
// //                       });
// //
// //
// //                 },
// //                 // Text('Order: ${data['order']}'),
// //                 // subtitle: Text('Start Date: ${data['start date']} - End Date: ${data['end date']}'),
// //               ),
// //
// //             );
// //           }).toList(),
// //         );
// //       },
// //     );
// //   }
// // }
//
//
import 'package:flutter/material.dart';
import 'package:shattably/orderlist.dart';
import 'features/home/presention/widgets/menu/menu_screen.dart';
import 'features/home/presention/widgets/profile/profile_screen.dart';

class BottomNav extends StatefulWidget {
  final dynamic workerCity;
  final dynamic workerJobType;

  const BottomNav({Key? key, this.workerCity, this.workerJobType}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selected = 0;
  late List<Widget> listWid;  // Declare listWid here without initializing

  @override
  void initState() {
    super.initState();
    // Initialize listWid here where you have access to widget properties
    listWid = [
      OrdersList(workerJobType: widget.workerJobType, workerCity: widget.workerCity),
      ProfileScreen(),
      MenuScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (val) {
          setState(() {
            selected = val;
          });
        },
        currentIndex: selected,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "menu"),
        ],
      ),
      body: ListView(children: [listWid.elementAt(selected)]),
    );
  }
}





//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shattably/getorder.dart';
//
// class OrdersPage extends StatelessWidget {
//   final dynamic workerCity;
//   final dynamic workerJobType;
//
//   OrdersPage({required this.workerCity, required this.workerJobType});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Available Orders'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('orders')
//             .where('city', isEqualTo: workerCity)
//             .where('jobType', isEqualTo: workerJobType)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           if (snapshot.data!.docs.isEmpty) {
//             return Text('No orders available in your city for your job type.');
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var order = snapshot.data!.docs[index].data() as Map<String, dynamic>;
//               return ListTile(
//                 title: Text('Order ID: ${order['orderId']}'),
//                 subtitle: Text('Start Date: ${order['start_date']} - End Date: ${order['end_date']}'),
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) =>Response(getorder: order['orderId'])));
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
//
