import 'package:flutter/material.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/core/utils/styles.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( leading: IconButtonHomeScreen(context),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Terms and Condition',
          style: kStyleAppBar,
        ),),
      body: Column(
        children: [
          Text(
            'Terms And Conditions Screen',
          ),
        ],
      ),
    );
  }
}
