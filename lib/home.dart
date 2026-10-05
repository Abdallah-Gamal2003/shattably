import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shattably/employee.dart';
import 'package:shattably/features/home/presention/layout/service_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:shattably/features/home/presention/widgets/main/widgets/cards_view/card_home_screen.dart';
import 'package:shattably/orderlist.dart';

import 'components/components.dart';
import 'features/home/presention/widgets/register/service_register_screen.dart';
import 'getorder.dart';
import 'navigationservice.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String jobTitle;
  late String city;
  @override
  void initState() {
    // TODO: implement initState
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        FirebaseFirestore.instance
            .collection('orders')
            .doc(value.data['id'])
            .get()
            .then((value) {
          navigateTo(NavigationService.context, Response(getorder: value.data()));
        });


      }
    });
    super.initState();
  }

  Future init() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

// Query the "users" collection to get users above a certain age (e.g., 18)
    String token = await FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot querySnapshot = await firestore
        .collection('profiles')
        .where('uId', isEqualTo: token)
        .get();


    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      jobTitle = doc['job'];
      city = doc['city'];
      return jobTitle;
    }


  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data) {
            case 'مستخدم':
              return ServiceLayout();
            default:
              return OrdersList(workerCity: city,workerJobType: jobTitle,);
          }
        }
        return Scaffold(body:Text(""));
      },
    );
  }
}