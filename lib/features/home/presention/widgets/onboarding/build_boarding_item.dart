import 'package:flutter/material.dart';
import 'package:shattably/features/home/presention/widgets/onboarding/onboarding_model.dart';

Widget buildBoardingItem(BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image: AssetImage('${model.image}'),
      ),
    ),
    SizedBox(
      height:30.0,
    ),
    Text(
      '${model.title}',
      style: TextStyle(
        fontSize:24.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(
      height:15.0,
    ),
    Text(
      '${model.body}',
      style: TextStyle(
        fontSize:14.0,
        fontWeight: FontWeight.bold,

      ),
    ),
    SizedBox(
      height:30.0,
    ),
  ],
);
