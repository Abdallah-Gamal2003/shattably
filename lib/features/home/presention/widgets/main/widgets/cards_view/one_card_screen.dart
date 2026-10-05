import 'package:flutter/material.dart';

import 'package:shattably/core/utils/styles.dart';

class OneCard extends StatelessWidget {

  final String imageForCard ;
  final String textTitle;
  GestureTapCallback function;
   OneCard({super.key, required this.imageForCard, required this.textTitle, required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        function();
      },
      child: Container(
        decoration: kDecoration,
        child: Column(
          children: [
            Image(
              image: AssetImage('$kBaseImage$imageForCard'),
              height: 120.0,
              width: 90.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              textTitle,
               style: kTitleStyle,
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}

