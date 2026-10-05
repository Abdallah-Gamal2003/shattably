 import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/features/home/data/models/service_user_model.dart';
import 'package:shattably/features/home/presention/widgets/register/cubit/states.dart';

class ServiceRegisterCubit extends Cubit<ServiceRegisterStates>
{
  bool isCubitClosed = false;
  ServiceRegisterCubit():super(ServiceRegisterInitialState());
  void closeCubit() {
    isCubitClosed = true;
    close();
  }
  static ServiceRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
    required job,
    required city,
    required String image,
    required String whatsapp,
   // required String locationlink,
     // String ? locationlink,
}){
    emit(ServiceRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){
      if(!FirebaseAuth.instance.currentUser!.emailVerified) {
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
      }
      userCreate(
        uId: FirebaseAuth.instance.currentUser!.uid,
        name: name,
        email: email,
        phone: phone,
        address: address,
          job: job,
        city: city,
        image: image,
        whatsapp: whatsapp,
        // locationlink: locationlink,
      );
    }).catchError((error){
      emit(ServiceRegisterErrorState(error.toString()));
    });
  }
  void userCreate({
    required String name,
    required String email,
  //  required String password,
    required String phone,
    required String uId,
    required String address,
    required String job,
    required String city,
    required String image,
    required String whatsapp,
     //required String locationlink,
  }){
    FirebaseMessaging.instance.getToken().then((value){
      ServiceUserModel model = ServiceUserModel(
        phone: phone,
        whatsapp: whatsapp,
        email: email,
        image: image,
        isEmailVerified: false,
        name: name,
        address: address,
        city: city,
        uId: uId,
        job: job,
       // locationlink: locationlink,
        fcmToken: [value!],
      );
      print(model.image);
      print("-------------------------------------------");
      print("-------------------------------------------");
      print("-------------------------------------------");
      print("-------------------------------------------");
      print("-------------------------------------------");
      print("-------------------------------------------");
      FirebaseFirestore.instance.collection("profiles").doc(uId).set(model.toMap()) .onError((e, _) => print("Error writing document: $e")).then((value) {
        print("success");
        emit(ServiceRegisterCreateUserSuccessState());
      });
      // .collection("data")
      //     .doc("one")
      //     .set(docData)
      //     .onError((e, _) => print("Error writing document: $e"));
      // jobCollection.doc(uId).set(model.toMap()).then((value) {
      //     emit(ServiceRegisterCreateUserSuccessState());
      //   }).catchError((error) {
      //     emit(ServiceCreateUserErrorState(error.toString()));
      //     print(error.toString());
      // });
    });

    // FirebaseFirestore.instance.collection(job).doc(uId).set(model.toMap()).then((value){
    //   emit(ServiceRegisterCreateUserSuccessState());
    // }).catchError((error){
    //   emit(ServiceCreateUserErrorState(error.toString()));
    // });

   
}
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ServiceRegisterChangePasswordVisibilityState());
  }
}