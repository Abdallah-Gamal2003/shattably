
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shattably/core/utils/constants.dart';
import 'package:shattably/features/home/data/models/service_user_model.dart';
import 'dart:io';
import 'package:shattably/features/home/presention/layout/cubit/states.dart';
import 'package:shattably/features/home/presention/widgets/main/home_screen.dart';
import 'package:shattably/features/home/presention/widgets/menu/menu_screen.dart';
import 'package:shattably/features/home/presention/widgets/orders/order_screen.dart';
import 'package:shattably/features/home/presention/widgets/profile/profile_screen.dart';

import '../../../../../components/components.dart';
import '../../../../../employee_profile_screen.dart';
import '../../../../../navigationservice.dart';

class ServiceCubit extends Cubit<ServiceLayoutStates>
{
  ServiceCubit() : super(ServiceLayoutInitialStates());

  static ServiceCubit get(context) => BlocProvider.of(context);

  ServiceUserModel? userModel;
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
  void getUserData(){

    emit(ServiceGetUserLoadingState());
    FirebaseFirestore.instance.collection('profiles').doc(uId).get().then((value) {
      userModel = ServiceUserModel.fromJson(value.data()!);
      emit(ServiceGetUserSuccessState());
    }).catchError((error){
      emit(ServiceGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    OrderScreen(),
    ProfileScreen(),
    MenuScreen(),

  ];


  void changeBottom(int index) {
    currentIndex = index;
   emit(ServiceLayoutChangeBottomNavState());
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
      {
        profileImage = File(pickedFile.path);
        emit(ServiceProfileImagePickedSuccessState());

      }
    else
      {
        emit(ServiceProfileImagePickedErrorState());
      }
  }


  void updateUser({
    required String name,
    required String email,
    required String phone,
    String? image,
    required address,
    required String job,
    required String city,
    required String whatsapp,
   // required String locationlink,
}){
    ServiceUserModel model = ServiceUserModel(
        uId: userModel!.uId,
        email: userModel!.email,
        name: name,
        image: image??userModel!.image,
        phone: phone,
        isEmailVerified: false,
        address: address,
        job: job,
      city: city,
      whatsapp: whatsapp,
     // locationlink: locationlink,
    );

    FirebaseFirestore.instance.collection('profiles').doc(userModel!.uId).update(model.toMap()).then((value) {
      getUserData();
    }).catchError((error){
      emit(ServiceUserUpdateErrorState());
    });
  }

  void uploadProfileImage({
    required String name,
    required String email,
    required String phone,
    required String job,
    required String address,
    required String city,
    required String whatsapp,
   // required String locationlink,
}){
    emit(ServiceUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref()
    .child('profiles/${Uri.file(profileImage!.path).pathSegments.last}').putFile(profileImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          email: email,
          image: value,
          address: address,
          job: job,
          city: city,
          whatsapp: whatsapp,
         // locationlink: locationlink,
        );
      }).catchError((error){
        emit(ServiceUploadProfileImageErrorState());
      });
    }).catchError((error){
      emit(ServiceUploadProfileImageErrorState());
    });
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

  void showProfile(employeeId) {

      FirebaseFirestore.instance.collection('profiles').doc(employeeId).get().then((value) {
        navigateTo(NavigationService.context, EmployeeProfileScreen(employee: value.data()!));
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
         var clientName = clientProfile.data()!['name'];
         FirebaseFirestore.instance.collection('orders').doc(orderId).update({'status': 'completed', 'offerId': offerId, 'acceptedEmployeeId': employeeId, 'price': price, 'endData': endData, 'name': name, 'image': image}).then((value) {
           // Outbound push delivery awaits a trusted backend.
             Navigator.pop(NavigationService.context!);
             currentIndex = 0;
             ScaffoldMessenger.of(NavigationService.context!).showSnackBar(SnackBar(content: Text('Offer accepted successfully')));

             emit(ServiceAcceptOfferSuccessState());


         }).catchError((error){
           emit(ServiceAcceptOfferErrorState(error.toString()));
         });
 });



    });

  }



}
