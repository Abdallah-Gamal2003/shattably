import 'package:bloc/bloc.dart';

import 'package:shattably/features/home/presentation/widgets/menu/cubit/states.dart';

class ServiceMenuCubit extends Cubit<ServiceMenuStates> {
  ServiceMenuCubit() : super(ServiceMenuInitialState());

  int value = 2;
  void changeOption(int newOption) {
    value = newOption;
    emit(ServiceMenuChangeBottomNavState());
  }
}
