import 'package:flutter/material.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/core/utils/styles.dart';
import 'package:shattably/features/home/presention/widgets/menu/widgets/languages/languages_item_screen.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white70,
      appBar: AppBar(
        leading: IconButtonHomeScreen(context),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Languages',
          style: kStyleAppBar,
        ),
      ),
      body: Column(
        children: [
          Languages_item_screen(
            flag: '🇸🇦',
            text: 'arabic',
            value: 1,
          ),
          Languages_item_screen(
            flag: '🇺🇸',
            text: 'english',
            value: 2,
          ),
        ],
      ),
    );
  }
}

