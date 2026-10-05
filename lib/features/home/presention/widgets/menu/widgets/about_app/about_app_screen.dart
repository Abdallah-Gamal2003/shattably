import 'package:flutter/material.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/core/utils/styles.dart';


class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButtonHomeScreen(context),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'About App',
          style: kStyleAppBar,
        ),
      ),
      body: Column(
        children: [
          Text(
            'About App Screen',
          ),
        ],
      ),
    );
  }
}
