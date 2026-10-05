import 'package:flutter/material.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/core/utils/styles.dart';
import 'package:shattably/features/home/presention/widgets/menu/widgets/languages/languages_item_screen.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white70,
      appBar: AppBar(
        leading: iconButtonHomeScreen(context),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Languages',
          style: kStyleAppBar,
        ),
      ),
      body: const Column(
        children: [
          LanguagesItemScreen(
            flag: '🇸🇦',
            text: 'arabic',
            value: 1,
          ),
          LanguagesItemScreen(
            flag: '🇺🇸',
            text: 'english',
            value: 2,
          ),
        ],
      ),
    );
  }
}

