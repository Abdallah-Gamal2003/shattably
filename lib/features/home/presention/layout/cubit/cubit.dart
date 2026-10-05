
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shattably/features/home/presention/layout/cubit/states.dart';
import 'package:shattably/features/home/presention/widgets/main/home_screen.dart';
import 'package:shattably/features/home/presention/widgets/menu/menu_screen.dart';
import 'package:shattably/features/home/presention/widgets/orders/order_screen.dart';
import 'package:shattably/features/home/presention/widgets/profile/profile_screen.dart';

import '../../../../../navigationservice.dart';

class ServiceCubit extends Cubit<ServiceLayoutStates>
{
  ServiceCubit() : super(ServiceLayoutInitialStates());

  static ServiceCubit get(context) => BlocProvider.of(context);

  List myOrders = [];
  void getOrders() {
    emit(ServiceGetOrdersLoadingState());
    var uID = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('orders').where('clientID', isEqualTo: uID).get().then((value) {
      myOrders = value.docs;
      emit(ServiceGetOrdersSuccessState());
    }).catchError((error){
      emit(ServiceGetOrdersErrorState(error.toString()));
    });
  }
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const OrderScreen(),
    const ProfileScreen(),
    const MenuScreen(),

  ];


  void changeBottom(int index) {
    currentIndex = index;
   emit(ServiceLayoutChangeBottomNavState());
  }

  List offers = [];

  void getOffers({required orderId}) {
    emit(ServiceGetOffersLoadingState());
    FirebaseFirestore.instance.collection('offers').where('orderId', isEqualTo: orderId).get().then((value) {
      offers = value.docs;
      emit(ServiceGetOffersSuccessState());
    }).catchError((error){
      emit(ServiceGetOffersErrorState(error.toString()));
    });
  }

  void acceptOffer({required orderId, required offerId}) {
    emit(ServiceAcceptOfferLoadingState());
    FirebaseFirestore.instance.collection("offers").doc(offerId).get().then((offerData) {
      var employeeId = offerData.data()!['employeeId'];
      var price = offerData.data()!['price'];
      var endData = offerData.data()!['endData'];
      var name = offerData.data()!['name'];
var image = offerData.data()!['image'];
 FirebaseFirestore.instance.collection("profiles").doc(FirebaseAuth.instance.currentUser!.uid).get().then((clientProfile) {
         FirebaseFirestore.instance.collection('orders').doc(orderId).update({'status': 'completed', 'offerId': offerId, 'acceptedEmployeeId': employeeId, 'price': price, 'endData': endData, 'name': name, 'image': image}).then((value) {
           // Outbound push delivery awaits a trusted backend.
             Navigator.pop(NavigationService.context!);
             currentIndex = 0;
             ScaffoldMessenger.of(NavigationService.context!).showSnackBar(const SnackBar(content: Text('Offer accepted successfully')));

             emit(ServiceAcceptOfferSuccessState());


         }).catchError((error){
           emit(ServiceAcceptOfferErrorState(error.toString()));
         });
 });



    });

  }



}