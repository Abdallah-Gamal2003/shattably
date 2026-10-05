import 'package:flutter/material.dart';
import 'package:shattably/core/utils/styles.dart';


class DialogBody extends StatelessWidget {
  DialogBody({required this.textTitle, required this.textContain});
  String textTitle;
  String textContain;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$textTitle',
          style: kTextDialogBody,
        ),
        Spacer(),
        Text(
          '$textContain',
          style: kTextDialogRightBody,
        ),
      ],
    );
  }
}
