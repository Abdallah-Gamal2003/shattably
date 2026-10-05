import 'package:flutter/material.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/core/utils/styles.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( leading: iconButtonHomeScreen(context),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Terms and Condition',
          style: kStyleAppBar,
        ),),
      body: const Column(
        children: [
          Text(
            'Terms And Conditions Screen',
          ),
        ],
      ),
    );
  }
}
