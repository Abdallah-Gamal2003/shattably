import 'package:flutter/material.dart';
import 'package:shattably/features/orders/presentation/request_form.dart';

class CardHomeScreen extends StatelessWidget {
  const CardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildServiceCardRow(context, 'electrician.png', "كهربائي",
                  'كهربائي', 'plumber.png', "سباك", 'سباك'),
              const SizedBox(height: 20),
              _buildServiceCardRow(context, 'carpenter.png', "نجار", 'نجار',
                  'painter.png', "نقاش", 'نقاش'),
              const SizedBox(height: 20),
              _buildServiceCardRow(context, 'ceramic_tiles.png', "سيراميك",
                  'سيراميك', 'simth.png', "حداد", 'حداد'),
              const SizedBox(height: 20),
              _buildServiceCardRow(context, 'conditioning.png', "تكييف",
                  'تكييف', 'parquet.png', "باركيه", 'باركية'),
              const SizedBox(height: 20),
              _buildServiceCardRow(context, 'portal.png', "الموتال", 'الموتال',
                  'marble.png', "رخام", 'رخام'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCardRow(BuildContext context, String image1,
      String title1, String job1, String image2, String title2, String job2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildServiceCard(context, image1, title1, job1),
        _buildServiceCard(context, image2, title2, job2),
      ],
    );
  }

  Widget _buildServiceCard(
      BuildContext context, String image, String title, String jobTitle) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RequestForm(jobTitle)),
          );
        },
        child: Container(
          height: 180,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/$image',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
