import 'package:flutter/material.dart';
import 'package:shattably/core/utils/styles.dart';


class DialogBody extends StatelessWidget {
  const DialogBody({super.key, required this.textTitle, required this.textContain});
  final String textTitle;
  final String textContain;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          textTitle,
          style: kTextDialogBody,
        ),
        const Spacer(),
        Text(
          textContain,
          style: kTextDialogRightBody,
        ),
      ],
    );
  }
}
