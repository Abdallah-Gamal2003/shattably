import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/features/home/presention/widgets/menu/cubit/cubit.dart';
import 'package:shattably/features/home/presention/widgets/menu/cubit/states.dart';

class Languages_item_screen extends StatelessWidget {
  Languages_item_screen(
      {required this.flag, required this.text, required this.value});


  void changeOption(newValue, BuildContext context) {
    if (newValue != null) {
      context.read<ServiceMenuCubit>().changeOption(newValue);
    }
  }
  String flag;
  int value;
  String text;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceMenuCubit, ServiceMenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ServiceMenuCubit.get(context);
        int groupValue = cubit.value;
        return Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 20.0,
            bottom: 0.0,
            right: 20.0,
          ),
          child: Container(
            height: 60.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    '${flag}',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    '${text}',
                  ),
                  Spacer(),
                  Radio(

                    value: value,
                    groupValue: groupValue,
                    onChanged: (newValue) {
                      // cubit.onChange(newValue);
                     changeOption(newValue, context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
