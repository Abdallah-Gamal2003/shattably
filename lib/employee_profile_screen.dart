// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:shattably/features/home/presention/widgets/payment/payment.dart';
//
// import 'components/components.dart';
//
// class EmployeeProfileScreen extends StatefulWidget {
//   final dynamic employee;
//
//   const EmployeeProfileScreen({Key? key, required this.employee}) : super(key: key);
//
//   @override
//   _EmployeeProfileScreenState createState() => _EmployeeProfileScreenState();
// }
//
// class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
//   String rate = 'Loading...'; // Default rate text
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch worker's rate when the widget initializes
//     fetchRate();
//   }
//
//   Future<String> getRate(String workerEmail) async {
//     try {
//       // Query the Firestore collection 'profiles' to find the worker by email
//       QuerySnapshot workerSnapshot = await FirebaseFirestore.instance
//           .collection('profiles')
//           .where('email', isEqualTo: workerEmail)
//           .limit(1)
//           .get();
//
//       // If worker profile found, retrieve their rate
//       if (workerSnapshot.docs.isNotEmpty) {
//         String workerUid = workerSnapshot.docs.first.id;
//
//
//         // Query the 'workerRates' collection to get the rate for this worker
//         DocumentSnapshot rateSnapshot = await FirebaseFirestore.instance
//             .collection('workerRates')
//             .doc(workerUid)
//             .get();
//
//         // If rate document exists, return the rate as a string
//         if (rateSnapshot.exists) {
//           return rateSnapshot['rate'].toString();
//         } else {
//           return 'Rate not available';
//         }
//       } else {
//         return 'Worker not found';
//       }
//     } catch (e) {
//       print('Error getting rate: $e');
//       return 'Error getting rate';
//     }
//   }
//
//
//   void fetchRate() async {
//     // Replace 'workerEmail' with the actual field name that stores worker's email
//     String workerEmail = widget.employee['email']; // Assuming email is used to identify the worker
//     String fetchedRate = await getRate(workerEmail);
//     setState(() {
//       rate = fetchedRate;
//     });
//   }
//
//   void updateRate() {
//     // Implement rate update logic here if needed
//     // For example, show a dialog or navigate to a page to update the rate
//     // This depends on your application's workflow for updating the rate
//     // Example:
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Update Rate'),
//           content: Text('Implement rate update logic here.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white24,
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               Center(
//                 child: Column(
//                   children: [
//                     Stack(
//                       alignment: AlignmentDirectional.bottomEnd,
//                       children: [
//                         SizedBox(height: 200,),
//                         CircleAvatar(
//                           radius: 71, // Adjust the radius as needed
//                           backgroundColor: Colors.white,
//                           backgroundImage: NetworkImage(
//                             widget.employee['image'] != null && widget.employee['image'] != "null"
//                                 ? widget.employee['image']
//                                 : 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 40,),
//                     Text(
//                       widget.employee['name'],
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Tajawal',
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 40.0,),
//               Column(
//                 children: [
//                   itemProfile('Name', widget.employee['name'], Icons.person),
//                   const SizedBox(height: 10),
//                   itemProfile('Phone', widget.employee['phone'], Icons.phone),
//                   const SizedBox(height: 10),
//                   itemProfile('Address', widget.employee['address'], Icons.home),
//                   const SizedBox(height: 10),
//                   itemProfile('Email', widget.employee['email'], Icons.mail),
//                   const SizedBox(height: 10),
//                   itemProfile('City', widget.employee['city'], Icons.location_city),
//                   const SizedBox(height: 10),
//                   itemProfile('Job', widget.employee['job'], Icons.engineering),
//                   const SizedBox(height: 20,),
//                   itemProfile('WhatsApp', widget.employee['whatsapp'], Icons.messenger_outlined),
//                   const SizedBox(height: 20,),
//                   SizedBox(height: 20.0,),
//                   Center(
//                     child: Column(
//                       children: [
//
//                         ElevatedButton(
//                         onPressed: () {
//
//                           navigateTo(context, payment());
//
//
//
//                         },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.deepOrange, // Background color of button
//                       onPrimary: Colors.white, // Text color of button
//                       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'payment',
//                         style: TextStyle(
//                           fontFamily: 'Tajawal',
//                           fontSize: 20 ,
//                           fontWeight: FontWeight.bold,
//
//                         ),
//                       ),
//                     ) ,
//                   ),
//
//                         SizedBox(height: 50,),
//
//
//                         Text(
//                           'Rate of the worker out of 10',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontFamily: 'Tajawal',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           rate,
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontFamily: 'Tajawal',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.deepOrange, // Adjust color as needed
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'الاتصال بالصنايعي',
//                           style: TextStyle(
//                             fontFamily: 'Tajawal',
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             FlutterPhoneDirectCaller.callNumber(widget.employee['phone']);
//                           },
//                           icon: Icon(Icons.call, color: Colors.deepOrange),
//                         ),
//                       ],
//                     ),
//                   ),
//
//
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget itemProfile(String title, String subtitle, IconData iconData) {
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.deepOrange,
//       borderRadius: BorderRadius.circular(50),
//     ),
//     clipBehavior: Clip.antiAlias, // This will ensure the border radius applies to its child
//     child: ListTile(
//       title: Text(
//         title,
//         style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//           fontFamily: 'Tajawal',
//         ),
//       ),
//       subtitle: Text(
//         subtitle,
//         style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//           fontFamily: 'Tajawal',
//         ),
//       ),
//       leading: Icon(
//         iconData,
//         color: Colors.white, // Ensuring icon color matches the design
//       ),
//       trailing: Icon(
//         Icons.arrow_forward,
//         color: Colors.white,
//       ),
//       tileColor: Colors.transparent, // Make sure the tile color is transparent
//     ),
//   );
// }
// /*
// Row(
//                       children: [
//
//                         CircleAvatar(
//                           radius: 50, // Adjust the radius as needed
//                           backgroundColor: Colors.white,
//                           backgroundImage: NetworkImage(
//                             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9qyxEUTrmMjLkuYB3nF0uU5FzB4XjimHU-A&s'
//                           ),
//
//                         ),
//
//
//                         Text(
//                           'Click',
//                           style: TextStyle(
//                             fontFamily: 'Tajawal',
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ],
//                     ),*/


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:shattably/features/home/presention/widgets/payment/payment.dart';
import 'components/components.dart';

class EmployeeProfileScreen extends StatefulWidget {
  final dynamic employee;

  const EmployeeProfileScreen({Key? key, required this.employee}) : super(key: key);

  @override
  _EmployeeProfileScreenState createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  String rate = 'Loading...'; // Default rate text

  @override
  void initState() {
    super.initState();
    fetchRate();
  }

  Future<String> getRate(String workerEmail) async {
    try {
      QuerySnapshot workerSnapshot = await FirebaseFirestore.instance
          .collection('profiles')
          .where('email', isEqualTo: workerEmail)
          .limit(1)
          .get();

      if (workerSnapshot.docs.isNotEmpty) {
        String workerUid = workerSnapshot.docs.first.id;

        DocumentSnapshot rateSnapshot = await FirebaseFirestore.instance
            .collection('workerRates')
            .doc(workerUid)
            .get();

        if (rateSnapshot.exists) {
          return rateSnapshot['rate'].toString();
        } else {
          return 'Rate not available';
        }
      } else {
        return 'Worker not found';
      }
    } catch (e) {
      print('Error getting rate: $e');
      return 'Error getting rate';
    }
  }

  void fetchRate() async {
    String workerEmail = widget.employee['email'];
    String fetchedRate = await getRate(workerEmail);
    setState(() {
      rate = fetchedRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.green),
        title: Text(
          'Employee Profile',
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileHeader(),
            SizedBox(height: 30),
            _buildProfileInfo('Name', widget.employee['name'], Icons.person),
            _buildProfileInfo('Phone', widget.employee['phone'], Icons.phone),
            _buildProfileInfo('Address', widget.employee['address'], Icons.home),
            _buildProfileInfo('Email', widget.employee['email'], Icons.mail),
            _buildProfileInfo('City', widget.employee['city'], Icons.location_city),
            _buildProfileInfo('Job', widget.employee['job'], Icons.work),
            _buildProfileInfo('WhatsApp', widget.employee['whatsapp'], Icons.messenger_outlined),
            SizedBox(height: 40),
            _buildCallButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 60.0,
          backgroundImage: NetworkImage(
            widget.employee['image'] != null && widget.employee['image'] != "null"
                ? widget.employee['image']
                : 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
          ),
          backgroundColor: Colors.white,
        ),
        SizedBox(height: 20),
        Text(
          widget.employee['name'],
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(String title, String subtitle, IconData iconData) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(iconData, size: 30, color: Colors.green),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRateSection() {
    return Column(
      children: [
        Text(
          'Rate of the worker out of 10',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Text(
          rate,
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ],
    );
  }

  Widget _buildCallButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Call the worker',
          style: TextStyle(
            fontFamily: 'Tajawal',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        IconButton(
          onPressed: () {
            FlutterPhoneDirectCaller.callNumber(widget.employee['phone']);
          },
          icon: Icon(Icons.call, color: Colors.green),
        ),
      ],
    );
  }
}
