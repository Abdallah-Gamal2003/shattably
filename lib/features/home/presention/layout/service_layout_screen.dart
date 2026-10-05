import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shattably/core/utils/styles.dart';
import 'package:shattably/features/home/presention/layout/cubit/cubit.dart';
import 'package:shattably/features/home/presention/layout/cubit/states.dart';

import '../../../../components/components.dart';
import '../../../../getorder.dart';
import '../../../../navigationservice.dart';

class ServiceLayout extends StatefulWidget {

  @override
  State<ServiceLayout> createState() => _ServiceLayoutState();
}

class _ServiceLayoutState extends State<ServiceLayout> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      'الخدمات',
      'طلباتك',
      'صفحتك الشخصية',
      'القائمة',
    ];
    return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
       listener: (context, state) {
       },
        builder: (context, state) {
          var cubit = ServiceCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                titles[cubit.currentIndex],
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.green,
                ),
              ),


            ),
            body: cubit.screens[cubit.currentIndex],
            backgroundColor: Colors.white,
            bottomNavigationBar: Container(
              color: Colors.black,
              child: BottomNavigationBar(

                backgroundColor: Colors.black38,
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.grey,
                elevation: 0,
                onTap: (index){
                  cubit.changeBottom(index);
                },
                currentIndex: cubit.currentIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                        Icons.home_filled,
                    ),
                    label: 'الصقحة الرئيسية',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_cart,
                      ),
                    label: 'الطلبات',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.account_circle_rounded,
                      ),
                    label: 'الصفحة الشخصية',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.menu,
                      ),
                    label: 'القائمة',
                  ),
                ],
              ),
            ),
          );
        },
       );
  }
}
