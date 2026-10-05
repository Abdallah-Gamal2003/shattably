import 'package:flutter/material.dart';

class DialogForDetailsScreen extends StatelessWidget {
  const DialogForDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        title: const Text('Information'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: [
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
