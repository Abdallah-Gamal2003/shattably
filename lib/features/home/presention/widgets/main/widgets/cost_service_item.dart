import 'package:flutter/material.dart';
import 'package:shattably/core/utils/styles.dart';


class CostServiceItem extends StatelessWidget {
  const CostServiceItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Cost',
          style: kTextDialogBody,
        ),
        Spacer(),
        Text(
          '20.0',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
