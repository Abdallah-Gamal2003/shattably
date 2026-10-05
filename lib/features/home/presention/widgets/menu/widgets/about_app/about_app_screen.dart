import 'package:flutter/material.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/core/utils/styles.dart';


class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: iconButtonHomeScreen(context),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'About App',
          style: kStyleAppBar,
        ),
      ),
      body: const Column(
        children: [
          Text(
            'About App Screen',
          ),
        ],
      ),
    );
  }
}
