

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shattably/components/components.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../cards_view/card_home_screen.dart';


class RequestForm extends StatefulWidget {

  const RequestForm(this.job, {super.key});
  final String job;
  @override
  State<RequestForm> createState() => _RequestFormState();
  final String order="";
}

class _RequestFormState extends State<RequestForm> {
  String? deliveryDate;
  String? rentingPeriod;
  DateTime? deliverySelectedDate = DateTime.now();
  DateTime? rentingPeriodSelectedDate;
final cityController =TextEditingController();
final orderController =TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'تسجيل الطلب',
          style: TextStyle(
            color: Colors.green,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body:
      SingleChildScrollView(
        child: Column
          (children: [
          Padding(
            padding: const EdgeInsets.all(17),
            child: TextField(
              controller: orderController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                fontFamily: 'Tajawal', // Set text style to Tajawal font
                color: Colors.green, // Set text color to white
              ),
              decoration: const InputDecoration(
                labelText: "اكتب طلبك",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Set border color to deepOrange
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Set border color to white when enabled (not focused)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2), // Set border color to deepOrange when focused
                ),
                prefixIcon: Icon(Icons.message , color: Colors.green,),
                labelStyle: TextStyle(
                  fontFamily: 'Tajawal', // Set label text style to Tajawal font
                  color: Colors.green, // Set label text color to deepOrange
                ),
                // Optional: You can customize other properties of InputDecoration here
              ),
            ),
          ),

          const SizedBox(height: 15,) ,


          Padding(
            padding: const EdgeInsets.all(17),
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedDate: DateTime.now(),
              rangeSelectionColor: Colors.green,
              rangeTextStyle: const TextStyle(color: Colors.green),

              toggleDaySelection: true,
              todayHighlightColor: Colors.green,
              endRangeSelectionColor: Colors.green,
              startRangeSelectionColor: Colors.green,
              selectionColor: Colors.green,

              monthCellStyle: const DateRangePickerMonthCellStyle(
                textStyle: TextStyle(color: Colors.green), // Set text color to white for date numbers
              ),

              // Customize the header style to set the color of day headers to white
              headerStyle: const DateRangePickerHeaderStyle(
                textStyle: TextStyle(color: Colors.white), // Set text color to white for day headers
              ),


              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                setState(() {
                  deliverySelectedDate = args.value.startDate;
                  rentingPeriodSelectedDate = args.value.endDate;
                  deliveryDate = args.value.startDate.toString().substring(0, 11);
                  rentingPeriod = args.value.endDate.toString().substring(0, 11);

                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: TextField(
              controller: TextEditingController(text: deliveryDate),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                fontFamily: 'Tajawal', // Set text style to Tajawal font
                color: Colors.green, // Set text color to white
              ),
              decoration: const InputDecoration(
                labelText: "بدايه المده",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Set border color to deepOrange
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Set border color to white when enabled (not focused)
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2), // Set border color to deepOrange when focused
                ),
                prefixIcon: Icon(Icons.message , color: Colors.green,),
                labelStyle: TextStyle(
                  fontFamily: 'Tajawal', // Set label text style to Tajawal font
                  color: Colors.green, // Set label text color to deepOrange
                ),
                // Optional: You can customize other properties of InputDecoration here
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17 , right: 17),
            child: TextField(
              controller: TextEditingController(text: rentingPeriod),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                fontFamily: 'Tajawal', // Set text style to Tajawal font
                color: Colors.green, // Set text color to white
              ),
              decoration: const InputDecoration(
                labelText: "نهايه المده",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Set border color to deepOrange
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey), // Set border color to white when enabled (not focused)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2), // Set border color to deepOrange when focused
                ),
                prefixIcon: Icon(Icons.message , color: Colors.green,),
                labelStyle: TextStyle(
                  fontFamily: 'Tajawal', // Set label text style to Tajawal font
                  color: Colors.green, // Set label text color to deepOrange
                ),
                // Optional: You can customize other properties of InputDecoration here
              ),

            ),
          ),
          AppTextField(
          textEditingController: cityController,
          title: "",
          hintTextStyle: const TextStyle(color: Colors.deepOrange , fontFamily: 'Tajawal' , fontSize: 25),
          titleTextStyle: const TextStyle(color: Colors.deepOrange , fontFamily: 'Tajawal' , fontSize: 25),
          hint: "المحافظة",
          isCitySelected: true,
          dataList: [
            SelectedListItem(name: "القاهرة"),
            SelectedListItem(name: "الجيزة"),
            SelectedListItem(name: "الاسكندرية"),
            SelectedListItem(name: "اسيوط"),
            SelectedListItem(name: "دمياط"),
            SelectedListItem(name: "الجميع")
          ],
        ),ElevatedButton(

              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.green), // Set background color
                // You can add more styling options here if needed
              ),
              onPressed: () async {

          
            await FirebaseFirestore.instance.collection("orders")
                .add({}).then((value) async {
              
              var userId= FirebaseAuth.instance.currentUser!.uid;
              return await FirebaseFirestore.instance.collection("orders").doc(value.id).set({
                'orderId': value.id,
                "order":orderController.text,
                "start_date": deliveryDate.toString(),
                "end_date":rentingPeriod.toString(),
                "jobType":job,
                "city":cityController.text,
                "clientID":userId,
                "status":"pending",
              }).then((value) async {
                // Outbound push delivery is disabled until a trusted backend is deployed.
                if (!context.mounted) return true;
                final messenger = ScaffoldMessenger.of(context);
                Navigator.pop(context);
                messenger.showSnackBar(const SnackBar(
                  content: Text('تم ارسال الطلب بنجاح'),
                  duration: Duration(seconds: 3),
                ));

                return true;
              }).catchError((error) {
                debugPrint("Failed to add user: $error");
                return false;
              });
            });

        }, child: const Text("ارسال طلب" , style: TextStyle(color: Colors.white , fontFamily: 'Tajawal' , fontSize: 20),))],),
      )
    );
  }
}


//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dio/dio.dart';
// import 'package:drop_down_list/model/selected_list_item.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// 
// import 'package:shattably/components/components.dart';
// import 'package:shattably/core/utils/styles.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
//
//
//
// class FormScreen extends StatefulWidget {
//   final String job;
//   FormScreen(this.job);
//
//   @override
//   State<FormScreen> createState() => _FormScreenState();
// }
//
// class _FormScreenState extends State<FormScreen> {
//   String? deliveryDate;
//   String? rentingPeriod;
//   DateTime? deliverySelectedDate = DateTime.now();
//   DateTime? rentingPeriodSelectedDate;
//   final cityController = TextEditingController();
//   final orderController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: iconButtonHomeScreen(context),
//         title: Text(
//           'Order Service',
//           style: TextStyle(
//             color: Colors.green,
//             fontFamily: 'Tajawal',
//             fontWeight: FontWeight.bold,
//             fontSize: 25,
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.green),
//       ),
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildTextField(
//                 controller: orderController,
//                 label: 'Describe Your Order',
//                 icon: Icons.message,
//               ),
//               SizedBox(height: 20),
//               _buildDatePicker(context),
//               SizedBox(height: 20),
//               _buildTextField(
//                 controller: TextEditingController(text: deliveryDate),
//                 label: 'Start Date',
//                 icon: Icons.date_range,
//               ),
//               SizedBox(height: 20),
//               _buildTextField(
//                 controller: TextEditingController(text: rentingPeriod),
//                 label: 'End Date',
//                 icon: Icons.date_range_outlined,
//               ),
//               SizedBox(height: 20),
//               AppTextField(
//                 textEditingController: cityController,
//                 title: '',
//                 hint: 'Select City',
//                 titleTextStyle: TextStyle(
//                   fontFamily: 'Tajawal',
//                   fontSize: 18,
//                   color: Colors.green,
//                 ),
//                 hintTextStyle: TextStyle(
//                   fontFamily: 'Tajawal',
//                   fontSize: 18,
//                   color: Colors.green,
//                 ),
//                 isCitySelected: true,
//                 dataList: [
//                   SelectedListItem(name: "Cairo"),
//                   SelectedListItem(name: "Giza"),
//                   SelectedListItem(name: "Alexandria"),
//                   SelectedListItem(name: "Assiut"),
//                   SelectedListItem(name: "Damietta"),
//                   SelectedListItem(name: "All Cities"),
//                 ],
//               ),
//               SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: _submitOrder,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 child: Text(
//                   'Send Request',
//                   style: TextStyle(
//                     fontFamily: 'Tajawal',
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//   }) {
//     return TextField(
//       controller: controller,
//       maxLines: null,
//       style: TextStyle(
//         fontFamily: 'Tajawal',
//         color: Colors.green,
//       ),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(
//           fontFamily: 'Tajawal',
//           color: Colors.green,
//         ),
//         prefixIcon: Icon(icon, color: Colors.green),
//         border: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.green),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.green),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.green),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDatePicker(BuildContext context) {
//     return SfDateRangePicker(
//       view: DateRangePickerView.month,
//       selectionMode: DateRangePickerSelectionMode.range,
//       initialSelectedDate: DateTime.now(),
//       rangeSelectionColor: Colors.green,
//       rangeTextStyle: const TextStyle(color: Colors.white),
//       toggleDaySelection: true,
//       todayHighlightColor: Colors.green,
//       endRangeSelectionColor: Colors.grey,
//       startRangeSelectionColor: Colors.green,
//       selectionColor: Colors.white,
//       monthCellStyle: DateRangePickerMonthCellStyle(
//         textStyle: TextStyle(color: Colors.green),
//       ),
//       headerStyle: DateRangePickerHeaderStyle(
//         textStyle: TextStyle(color: Colors.green),
//       ),
//       onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
//         setState(() {
//           deliverySelectedDate = args.value.startDate;
//           rentingPeriodSelectedDate = args.value.endDate;
//           deliveryDate = args.value.startDate.toString().substring(0, 10);
//           rentingPeriod = args.value.endDate.toString().substring(0, 10);
//         });
//       },
//     );
//   }
//
//   Future<void> _submitOrder() async {
//     String orderId = "";
//     await FirebaseFirestore.instance.collection("orders").add({}).then((value) async {
//       orderId = value.id;
//       var userId = FirebaseAuth.instance.currentUser!.uid;
//       await FirebaseFirestore.instance.collection("orders").doc(value.id).set({
//         'orderId': value.id,
//         'order': orderController.text,
//         'start_date': deliveryDate.toString(),
//         'end_date': rentingPeriod.toString(),
//         'jobType': widget.job,
//         'city': cityController.text,
//         'clientID': userId,
//         'status': 'pending',
//       }).then((value) async {
//         FirebaseFirestore firestore = FirebaseFirestore.instance;
//         QuerySnapshot querySnapshot = await firestore
//             .collection('profiles')
//             .where('city', isEqualTo: cityController.text)
//             .where('job', isEqualTo: widget.job)
//             .get();
//
//         String name = await firestore
//             .collection('profiles')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .get()
//             .then((value) => value['name']);
//
//         for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
//           List fcms = documentSnapshot['fcm'] ?? [];
//           for (var i in fcms) {
//             const String fcmAPI = 'https://fcm.googleapis.com/fcm/send';
//             final Dio dio = Dio();
//             Options options = Options(
//               followRedirects: false,
//               validateStatus: (status) => true,
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization':
//               },
//             );
//             dio.post(
//               fcmAPI,
//               data: {
//                 "to": i,
//                 "notification": {
//                   "title": 'Shattably',
//                   "body": "A new order has been received from $name.",
//                   "mutable_content": true,
//                 },
//                 "data": {
//                   "id": orderId,
//                   'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//                   "key": "orderEvent"
//                 }
//               },
//               options: options,
//             );
//           }
//         }
//
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Order sent successfully'),
//           duration: Duration(seconds: 3),
//         ));
//       }).catchError((error) {
//         debugPrint("Failed to add order: $error");
//       });
//     });
//   }
// }
//
