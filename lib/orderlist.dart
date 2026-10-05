// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shattably/components/components.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'features/home/presention/layout/cubit/cubit.dart';
// import 'features/home/presention/widgets/login/service_login_screen.dart';
// import 'features/home/presention/widgets/profile/profile_screen.dart';
//
// enum MenuAction { signOut, profile, availableOrders,lastOrders }
//
// class OrdersList extends StatefulWidget {
//   bool last=false;
//   final dynamic workerCity;
//   final dynamic workerJobType;
//
//   OrdersList({required this.workerCity, required this.workerJobType,this.last=false});
//
//   @override
//   _OrdersListState createState() => _OrdersListState();
// }
//
// class _OrdersListState extends State<OrdersList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         bottomOpacity: 0,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//
//         title: Text(widget.last?"Last Orders":"Available Orders" ,
//           style: TextStyle(
//
//             fontFamily: 'Tajawal',
//             fontSize: 25,
//             color: Colors.deepOrange,
//             fontWeight: FontWeight.bold,
//
//           ),
//         ),
//
//         actions: [
//           PopupMenuButton<MenuAction>(
//             onSelected: (value) => _handleMenuAction(value),
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuAction>>[
//               PopupMenuItem<MenuAction>(
//                 value: MenuAction.signOut,
//                 child: Row(
//                   children: [
//                     Icon(Icons.exit_to_app, color: Colors.black38),
//                     SizedBox(width: 8),
//                     Text('Sign Out' ,   style: TextStyle(
//                       fontFamily: 'Tajawal',
//                       fontSize: 18,
//                       color: Colors.deepOrange,
//                       fontWeight: FontWeight.bold,
//                     ),),
//                   ],
//                 ),
//               ),
//               PopupMenuItem<MenuAction>(
//                 value: MenuAction.profile,
//                 child: Row(
//                   children: [
//                     Icon(Icons.person, color: Colors.black38),
//                     SizedBox(width: 8),
//                     Text('Profile',   style: TextStyle(
//                       fontFamily: 'Tajawal',
//                       fontSize: 18,
//                       color: Colors.deepOrange,
//                       fontWeight: FontWeight.bold,
//                     ),),
//                   ],
//                 ),
//               ),
//               PopupMenuItem<MenuAction>(
//                 value: MenuAction.availableOrders,
//                 child: Row(
//                   children: [
//                     Icon(Icons.list, color: Colors.black38),
//                     SizedBox(width: 8),
//                     Text('Available Orders',   style: TextStyle(
//                       fontFamily: 'Tajawal',
//                       fontSize: 18,
//                       color: Colors.deepOrange,
//                       fontWeight: FontWeight.bold,
//                     ),),
//                   ],
//                 ),
//               ),
//               PopupMenuItem<MenuAction>(
//                 value: MenuAction.lastOrders,
//                 child: Row(
//                   children: [
//                     Icon(Icons.timer, color: Colors.black38),
//                     SizedBox(width: 8),
//                     Text('Last Orders',   style: TextStyle(
//                       fontFamily: 'Tajawal',
//                       fontSize: 18,
//                       color: Colors.deepOrange,
//                       fontWeight: FontWeight.bold,
//                     ),),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: StreamBuilder(
//         stream:widget.last==false?
//
//
//         FirebaseFirestore.instance
//             .collection('orders')
//             .where('city', isEqualTo: widget.workerCity)
//             .where('jobType', isEqualTo: widget.workerJobType)
//             .where('status', isEqualTo: 'pending')
//             .snapshots():   FirebaseFirestore.instance
//             .collection('orders')
//             .where('city', isEqualTo: widget.workerCity)
//             .where('jobType', isEqualTo: widget.workerJobType)
//             .where('status', isEqualTo: 'completed')
//             .where('acceptedEmployeeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData)
//             return Center(child: CircularProgressIndicator());
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               DocumentSnapshot order = snapshot.data!.docs[index];
//               return OrderCard(order: order,last:widget.last);
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Future<void> _handleMenuAction(MenuAction value) async {
//     switch (value) {
//       case MenuAction.signOut:
//         await FirebaseAuth.instance.signOut();
//         navigateTo(context, ServiceLoginScreen());
//         break;
//       case MenuAction.profile:
//         navigateTo(context, ProfileScreen());
//         break;
//       case MenuAction.lastOrders:
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrdersList(workerCity: widget.workerCity, workerJobType: widget.workerJobType,last: true)));
//         // Navigate to orders page
//         break;
//       case MenuAction.availableOrders:
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrdersList(workerCity: widget.workerCity, workerJobType: widget.workerJobType,last: false)));
//         // Navigate to orders page
//         break;
//     }
//   }
// }
//
// class OrderCard extends StatelessWidget {
//   final DocumentSnapshot order;
//   bool last;
//
//   OrderCard({required this.order,required this.last});
//
//   @override
//   Widget build(BuildContext context) {
//     Map<String, dynamic> data = order.data() as Map<String, dynamic>;
//
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: Card(
//         color: Colors.deepOrange, // Set card color
//
//         child: InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => OrderDetailsScreen(data: data)),
//             );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text('Order :  ${data['order']}',
//                   style: TextStyle(
//                     fontFamily: 'Tajawal',
//                     fontSize: 25,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//
//
//
//
//                 ),
//
//                 SizedBox(height: 10,),
//                 Text('Start Date: ${data['start_date']}',  style: TextStyle(
//                   fontFamily: 'Tajawal',
//                   fontSize: 18,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),),
//                 Text('End Date: ${data['end_date']}' ,  style: TextStyle(
//                   fontFamily: 'Tajawal',
//                   fontSize: 18,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),),
//                 if (last)
//                   SizedBox(
//                     height: 5,
//                   ),
//                 if (last)
//                   Text("Status : You Accepted The Offer" ,  style: TextStyle(
//                     fontFamily: 'Tajawal',
//                     fontSize: 18,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),),
//                 SizedBox(height: 6,),
//                 if (last)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Price: ${data['price']}',  style: TextStyle(
//                         fontFamily: 'Tajawal',
//                         fontSize: 18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),),
//                     ],
//                   ),
//                 // Text('End Date: ${data['endData']}' ,  style: TextStyle(
//                 //   fontFamily: 'Tajawal',
//                 //   fontSize: 18,
//                 //   color: Colors.white,
//                 //   fontWeight: FontWeight.bold,
//                 // ),),
//
//                 if (last)
//                   SizedBox(
//                     height: 10,
//                   ),
//                 if (last)
//                   Center(
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(Colors.white),
//                       ),
//                       onPressed: () {
//                         ServiceCubit.get(context).showProfile(data['clientID']);
//
//                       },
//                       child: Text("Show Client Profile" ,  style: TextStyle(
//                         fontFamily: 'Tajawal',
//                         fontSize: 25,
//                         color: Colors.deepOrange,
//                         fontWeight: FontWeight.bold,
//                       ),),
//                     ),
//                   )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class OrderDetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> data;
//
//   OrderDetailsScreen({required this.data}) {
//     order = data["order"];
//     sDate = data["start_date"];
//     eDate = data["end_date"];
//     orderId = data["orderId"];
//     clientId = data["clientID"];
//   }
//
//   late String order;
//   late String sDate;
//   late String eDate;
//   late String orderId;
//   late String clientId;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 15,
//             ),
//             Text("order",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal' ,
//                 fontSize: 25 ,
//                 color: Colors.white ,
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: TextField(
//                 controller: TextEditingController(text: order),
//                 maxLines: null,
//                 enabled: false,
//                 keyboardType: TextInputType.multiline,
//                 style: TextStyle(
//                   color: Colors.deepOrange,
//                   fontFamily: 'Tajawal',
//                 ),
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.white,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.white,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.white,
//                     ),
//                   ),
//                   prefixIcon: Icon(Icons.message , color: Colors.white,),
//                 ),
//               ),
//             ),
//
//             SizedBox(
//               height: 15,
//             ),
//             Text("start date",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal' ,
//                 fontSize: 25 ,
//                 color: Colors.white ,
//               ) ,
//
//
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: TextField(
//                 controller: TextEditingController(text: sDate),
//                 maxLines: null,
//                 keyboardType: TextInputType.multiline,
//                 enabled: false,
//                 style: TextStyle(
//                   color: Colors.deepOrange,
//                   fontFamily: 'Tajawal',
//                 ),
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.white,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.white,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.white,
//                     ),
//                   ),
//                   prefixIcon: Icon(Icons.date_range_rounded , color: Colors.white,),
//                 ),
//               ),
//             ),
//
//             SizedBox(
//               height: 15,
//             ),
//             Text("end date" ,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Tajawal' ,
//                 fontSize: 25 ,
//                 color: Colors.white ,
//               ),
//
//
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: TextField(
//                 controller: TextEditingController(text: eDate),
//                 maxLines: null,
//                 keyboardType: TextInputType.multiline,
//                 enabled: false,
//                 style: TextStyle(
//                   color: Colors.deepOrange,
//                   fontFamily: 'Tajawal',
//                 ),
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.white,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.white,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.white,
//                     ),
//                   ),
//                   prefixIcon: Icon(Icons.date_range_outlined , color: Colors.white,),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 50,) ,
//
//             ElevatedButton(
//               onPressed: () {
//                 navigateTo(
//                   context,
//                   SetOfferPage(
//                     orderId: orderId,
//                     clientId: clientId,
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.deepOrange, // Set the button color
//               ),
//               child: Text(
//                 "ارسال عرض",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Tajawal',
//                   fontSize: 25,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/features/home/presention/layout/cubit/cubit.dart';
import 'features/home/presention/widgets/login/service_login_screen.dart';
import 'features/home/presention/widgets/profile/profile_screen.dart';

 enum MenuAction { signOut, profile, availableOrders, lastOrders }
class SetOfferPage extends StatefulWidget {
  final String orderId;
  final String clientId;

  SetOfferPage({required this.orderId, required this.clientId});

  @override
  _SetOfferPageState createState() => _SetOfferPageState();
}

class _SetOfferPageState extends State<SetOfferPage> {
  final _priceController = TextEditingController();
  final _dateController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        color: Colors.green,
        fontFamily: 'Tajawal',
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.green,
          fontFamily: 'Tajawal',
        ),
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.green),
        title: Text(
          'انشئ عرضك',
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Icon(
              Icons.attach_money_rounded,
              size: 100,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _priceController,
              style: TextStyle(
                color: Colors.green,
                fontFamily: 'Tajawal',
              ),
              decoration: InputDecoration(
                labelText: 'السعر',
                labelStyle: TextStyle(
                  color: Colors.green, // Optional: Change the label text color to deep orange
                  fontFamily: 'Tajawal',
                ),
                prefixIcon:Icon(Icons.money,color: Colors.green,) ,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 25,),

          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _dateController,
              style: TextStyle(
                color: Colors.green,
                fontFamily: 'Tajawal',
              ),
              decoration: InputDecoration(
                labelText: 'تاريخ النهاية',
                labelStyle: TextStyle(
                  color: Colors.green, // Optional: Change the label text color to deep orange
                  fontFamily: 'Tajawal',
                ),
                prefixIcon: Icon(Icons.date_range,color: Colors.green,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),

             child:
             ElevatedButton(
               onPressed: () async {
                 await FirebaseFirestore.instance.collection("orders").doc(widget.orderId).get().then((value) {
                   if (value.data()!["status"] != "pending") {
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                         content: Text('This order is already pending')));
                     return;
                   }
                   FirebaseFirestore.instance
                       .collection("offers")
                       .add({}).then((value) async {
                     var offerId = value.id;
                     var userId = FirebaseAuth.instance.currentUser!.uid;
                     var currentUser=await FirebaseFirestore.instance.collection("profiles").doc(userId).get();
                     var name=currentUser.data()!["name"];
                     return await FirebaseFirestore.instance
                         .collection("offers")
                         .doc(value.id)
                         .set({
                       'offerId': value.id,
                       "price": _priceController.text,
                       "endData": _dateController.text,
                       "orderId": widget.orderId,
                       "name":name,
                       "image":currentUser.data()!["image"],
                       "employeeId": userId
                     }).then((value) async {
                       // Outbound push delivery is disabled; the offer is saved normally.
                        Navigator.pop(context);
                       Navigator.pop(context);
                       ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text('Offer sent successfully')));

                     });
                   });
                 });
               },
               style: ElevatedButton.styleFrom(
                 primary: Colors.green,
                 padding: EdgeInsets.symmetric(vertical: 15),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(30),
                 ),
               ),
               child: Text(
                 'ارسال العرض',
                 style: TextStyle(
                   fontFamily: 'Tajawal',
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   color: Colors.white,
                 ),
               ),
             ),
            // ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.deepOrange, // Set the button color
            //     ),
            //     child: Text('Send Offer',
            //
            //       style: TextStyle(
            //         fontFamily: 'Tajawal',
            //         fontSize: 25 ,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white ,
            //       ),
            //
            //     ),
            //     onPressed: () async {
            //       await FirebaseFirestore.instance.collection("orders").doc(widget.orderId).get().then((value) {
            //         if (value.data()!["status"] != "pending") {
            //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //               content: Text('This order is already pending')));
            //           return;
            //         }
            //         FirebaseFirestore.instance
            //             .collection("offers")
            //             .add({}).then((value) async {
            //           var offerId = value.id;
            //           var userId = FirebaseAuth.instance.currentUser!.uid;
            //           var currentUser=await FirebaseFirestore.instance.collection("profiles").doc(userId).get();
            //           var name=currentUser.data()!["name"];
            //           return await FirebaseFirestore.instance
            //               .collection("offers")
            //               .doc(value.id)
            //               .set({
            //             'offerId': value.id,
            //             "price": _priceController.text,
            //             "endData": _dateController.text,
            //             "orderId": widget.orderId,
            //             "name":name,
            //             "image":currentUser.data()!["image"],
            //             "employeeId": userId
            //           }).then((value) async {
            //             var client=await FirebaseFirestore.instance.collection("profiles").doc(widget.clientId).get();
            //             List fcms=client.data()!["fcm"];
            //             for (var i in fcms) {
            //               const String fcmAPI =
            //                   'https://fcm.googleapis.com/fcm/send';
            //               final Dio dio = Dio();
            //               Options options = Options(
            //                   followRedirects: false,
            //                   validateStatus: (status) => true,
            //                   headers: {
            //                     'Content-Type': 'application/json',
            //                     'Authorization':
            //                   });
            //               dio
            //                   .post(fcmAPI,
            //                   data: {
            //                     "to": i,
            //                     "notification": {
            //                       "title": 'shattably',
            //                       "body": "${name}تم استقبال عرض لطلبك من ",
            //                       "mutable_content": true,
            //                     },
            //                     "data": {
            //                       "id":  widget.orderId,
            //                       "key":"offerEvent",
            //                       'click_action': 'FLUTTER_NOTIFICATION_CLICK'
            //                     }
            //                   },
            //                   options: options)
            //                   .then((value) {});
            //             }
            //             Navigator.pop(context);
            //             Navigator.pop(context);
            //             ScaffoldMessenger.of(context).showSnackBar(
            //                 SnackBar(content: Text('Offer sent successfully')));
            //
            //           });
            //         });
            //       });
            //
            //     }),
          ),
        ],
      ),
    );
  }
}
// class SetOfferPage extends StatefulWidget {
//   final String orderId;
//   final String clientId;
//
//   SetOfferPage({required this.orderId, required this.clientId});
//
//   @override
//   _SetOfferPageState createState() => _SetOfferPageState();
// }
//
// class _SetOfferPageState extends State<SetOfferPage> {
//   final _priceController = TextEditingController();
//   final _dateController = TextEditingController();
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//
//   @override
//    Widget build(BuildContext context) {
//      return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         iconTheme: IconThemeData(color: Colors.green),
//         title: Text(
//           'Set Your Offer',
//           style: TextStyle(
//             fontFamily: 'Tajawal',
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//             color: Colors.green,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 20),
//             Center(
//               child: Icon(
//                 Icons.attach_money_rounded,
//                 size: 100,
//                 color: Colors.green,
//               ),
//             ),
//             SizedBox(height: 30),
//             _buildInputField(
//               label: 'Price',
//               controller: _priceController,
//               keyboardType: TextInputType.number,
//               icon: Icons.money,
//             ),
//             SizedBox(height: 20),
//             _buildInputField(
//               label: 'End Date',
//               controller: _dateController,
//               keyboardType: TextInputType.datetime,
//               icon: Icons.date_range,
//             ),
//             SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: () async {
//                 await _sendOffer();
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.green,
//                 padding: EdgeInsets.symmetric(vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               child: Text(
//                 'Send Offer',
//                 style: TextStyle(
//                   fontFamily: 'Tajawal',
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInputField({
//     required String label,
//     required TextEditingController controller,
//     required TextInputType keyboardType,
//     required IconData icon,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       style: TextStyle(
//         color: Colors.green,
//         fontFamily: 'Tajawal',
//       ),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(
//           color: Colors.green,
//           fontFamily: 'Tajawal',
//         ),
//         prefixIcon: Icon(icon, color: Colors.green),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.green),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _sendOffer() async {
//     await FirebaseFirestore.instance
//         .collection("orders")
//         .doc(widget.orderId)
//         .get()
//         .then((value) {
//       if (value.data()!["status"] != "pending") {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('This order is already pending'),
//         ));
//         return;
//       }
//       FirebaseFirestore.instance.collection("offers").add({}).then((offerRef) async {
//         var offerId = offerRef.id;
//         var userId = FirebaseAuth.instance.currentUser!.uid;
//         var currentUser =
//         await FirebaseFirestore.instance.collection("profiles").doc(userId).get();
//         var name = currentUser.data()!["name"];
//         return await FirebaseFirestore.instance
//             .collection("offers")
//             .doc(offerId)
//             .set({
//           'offerId': offerId,
//           "price": _priceController.text,
//           "endDate": _dateController.text,
//           "orderId": widget.orderId,
//           "name": name,
//           "image": currentUser.data()!["image"],
//           "employeeId": userId
//         }).then((_) async {
//           var client =
//           await FirebaseFirestore.instance.collection("profiles").doc(widget.clientId).get();
//           List fcms = client.data()!["fcm"];
//           for (var fcmToken in fcms) {
//             const String fcmAPI = 'https://fcm.googleapis.com/fcm/send';
//             final Dio dio = Dio();
//             Options options = Options(
//                 followRedirects: false,
//                 validateStatus: (status) => true,
//                 headers: {
//                   'Content-Type': 'application/json',
//                   'Authorization':
//                   'key=YOUR_FCM_SERVER_KEY',
//                 });
//             dio.post(fcmAPI,
//                 data: {
//                   "to": fcmToken,
//                   "notification": {
//                     "title": 'Shattably',
//                     "body": "An offer from $name has been received for your order.",
//                     "mutable_content": true,
//                   },
//                   "data": {
//                     "id": widget.orderId,
//                     "key": "offerEvent",
//                     'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//                   }
//                 },
//                 options: options);
//           }
//           Navigator.pop(context);
//           ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Offer sent successfully')));
//         });
//       });
//     });
//   }
// }





class OrdersList extends StatefulWidget {
  final bool last;
  final dynamic workerCity;
  final dynamic workerJobType;

  OrdersList({required this.workerCity, required this.workerJobType, this.last = false});

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(

        backgroundColor: Colors.white,
        title: Text(
          widget.last ? "الطلبات المقبولة" : "الطلبات المتاحة",
          style: TextStyle(
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
              _buildMenuItem(MenuAction.signOut, Icons.exit_to_app, 'تسجيل خروج'),
              _buildMenuItem(MenuAction.profile, Icons.person, 'الصفحة الشخصية'),
              _buildMenuItem(MenuAction.availableOrders, Icons.list, 'الطلبات المتاحة'),
              _buildMenuItem(MenuAction.lastOrders, Icons.timer, 'الطلبات المقبولة'),
            ],
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _fetchOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot order = snapshot.data!.docs[index];
              return OrderCard(order: order, last: widget.last);
            },
          );
        },
      ),
    );
  }

  Stream<QuerySnapshot> _fetchOrders() {
    return widget.last
        ? FirebaseFirestore.instance
        .collection('orders')
        .where('city', isEqualTo: widget.workerCity)
        .where('jobType', isEqualTo: widget.workerJobType)
        .where('status', isEqualTo: 'completed')
        .where('acceptedEmployeeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        : FirebaseFirestore.instance
        .collection('orders')
        .where('city', isEqualTo: widget.workerCity)
        .where('jobType', isEqualTo: widget.workerJobType)
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }

  PopupMenuItem<MenuAction> _buildMenuItem(MenuAction action, IconData icon, String text) {
    return PopupMenuItem<MenuAction>(
      value: action,
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
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
        await FirebaseAuth.instance.signOut();
        navigateTo(context, ServiceLoginScreen());
        break;
      case MenuAction.profile:
        navigateTo(context, ProfileScreen());
        break;
      case MenuAction.lastOrders:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OrdersList(workerCity: widget.workerCity, workerJobType: widget.workerJobType, last: true),
          ),
        );
        break;
      case MenuAction.availableOrders:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OrdersList(workerCity: widget.workerCity, workerJobType: widget.workerJobType, last: false),
          ),
        );
        break;
    }
  }
}

class OrderCard extends StatelessWidget {
  final DocumentSnapshot order;
  final bool last;

  OrderCard({required this.order, required this.last});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = order.data() as Map<String, dynamic>;

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
                  builder: (context) => OrderDetailsScreen(data: data)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                SizedBox(height: 10),
                _buildOrderDetail(':تاريخ البداية', data['start_date'], 18),
                _buildOrderDetail(':تاريخ النهاية', data['end_date'], 18),
                if (last)
                  _buildOrderDetail(":الحالة", "تم قبول عرضك من العميل", 18),
                if (last)
                  SizedBox(height: 10),
                if (last)
                  ElevatedButton(
                    onPressed: () {
                      ServiceCubit.get(context).showProfile(data['clientID']);
                    },
                    child: Text(
                      'الصفحة الشخصية للعميل',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.green,
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
          "$value",
          style: TextStyle(
            fontFamily: 'Tajawal',
            color: Colors.black87,
          ),
        ),
        Text(
          '$label ',
          style: TextStyle(
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

  OrderDetailsScreen({required this.data}) {
    order = data["order"];
    sDate = data["start_date"];
    eDate = data["end_date"];
    orderId = data["orderId"];
    clientId = data["clientID"];
  }

  late String order;
  late String sDate;
  late String eDate;
  late String orderId;
  late String clientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'تفاصيل الطلب',
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.green), // Back button color
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Center(
              child: Icon(
                Icons.assignment,
                size: 100,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            _buildDetailText('الطلب', data['order']),
            _buildDetailText('تاريخ البداية', data['start_date']),
            _buildDetailText('تاريخ النهاية', data['end_date']),
            SizedBox(height: 50),
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
              child: Text(
                'انشاء عرض',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Spacer(),
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
        child: SingleChildScrollView( // This makes the content scrollable
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
              SizedBox(height: 20),
              // Order details
              _buildDetailItem('الطلب:', data['order']),
              SizedBox(height: 10),
              // Start Date
              _buildDetailItem('تاريخ البداية:', data['start_date']),
              SizedBox(height: 10),
              // End Date
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
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
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
      style: TextStyle(
        fontFamily: 'Tajawal',
        fontSize: 18,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    );
  }

