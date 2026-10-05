import 'package:flutter/material.dart';

class DialogForDetailsScreen extends StatelessWidget {
  const DialogForDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        title: const Text('Information'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const [
              Text('Request Saved'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ]
    );
  }
}
