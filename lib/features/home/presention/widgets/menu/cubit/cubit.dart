import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shattably/features/home/presention/widgets/menu/cubit/states.dart';

class ServiceMenuCubit extends Cubit<ServiceMenuStates>
{
  ServiceMenuCubit() : super(ServiceMenuInitialState());
  static ServiceMenuCubit get(context)=> BlocProvider.of(context);

  int value = 2;
  void changeOption(int newOption)
  {
    value = newOption;
    emit(ServiceMenuChangeBottomNavState());
  }

}