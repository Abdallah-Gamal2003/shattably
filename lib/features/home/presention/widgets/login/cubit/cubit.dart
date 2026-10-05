import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/features/home/presention/widgets/login/cubit/states.dart';

class ServiceLoginCubit extends Cubit<ServiceLoginStates>
{
  ServiceLoginCubit() : super(ServiceLoginInitialState());
  static ServiceLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
}){
    emit(ServiceLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      emit(ServiceLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(ServiceLoginErrorState(error.toString()));
    });

  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword?  Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ServiceChangePasswordVisibilityState());
  }
}