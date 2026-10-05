import 'package:flutter/material.dart';

import 'package:shattably/core/utils/styles.dart';

class one_card extends StatelessWidget {

  String imageForCard ;
  String textTitle;
  GestureTapCallback function;
   one_card({Key? key, required this.imageForCard, required this.textTitle, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        function();
      },
      child: Container(
        child: Column(
          children: [
            Image(
              image: AssetImage('${kBaseImage}${imageForCard}'),
              height: 120.0,
              width: 90.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '${textTitle}',
               style: kTitleStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
        decoration: kDecoration,
      ),
    );
  }
}

