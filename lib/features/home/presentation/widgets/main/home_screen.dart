import 'package:flutter/material.dart';
import 'package:shattably/features/home/presentation/widgets/main/widgets/cards_view/card_home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: CardHomeScreen(),
    );
  }
}
