import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/features/home/presentation/widgets/menu/cubit/cubit.dart';
import 'package:shattably/features/home/presentation/widgets/menu/cubit/states.dart';

class LanguagesItemScreen extends StatelessWidget {
  const LanguagesItemScreen(
      {super.key, required this.flag, required this.text, required this.value});

  void changeOption(newValue, BuildContext context) {
    if (newValue != null) {
      context.read<ServiceMenuCubit>().changeOption(newValue);
    }
  }

  final String flag;
  final int value;
  final String text;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceMenuCubit, ServiceMenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<ServiceMenuCubit>();
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
              boxShadow: const [
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
                    flag,
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    text,
                  ),
                  const Spacer(),
                  Radio(
                    value: value,
                    groupValue: groupValue,
                    onChanged: (newValue) {
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
