import 'package:bloc/bloc.dart';

class ShellCubit extends Cubit<int> {
  ShellCubit() : super(0);
  void select(int index) => emit(index);
}
