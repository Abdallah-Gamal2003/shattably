
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shattably/features/home/presention/layout/cubit/states.dart';
import 'package:shattably/features/home/presention/widgets/main/home_screen.dart';
import 'package:shattably/features/home/presention/widgets/menu/menu_screen.dart';
import 'package:shattably/features/home/presention/widgets/orders/order_screen.dart';
import 'package:shattably/features/home/presention/widgets/profile/profile_screen.dart';


class ServiceCubit extends Cubit<ServiceLayoutStates>
{
  ServiceCubit() : super(ServiceLayoutInitialStates());

  static ServiceCubit get(context) => BlocProvider.of(context);

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

}