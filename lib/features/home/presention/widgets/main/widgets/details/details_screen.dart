import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/core/utils/styles.dart';
import 'package:shattably/features/home/presention/widgets/main/widgets/cost_service_item.dart';
import 'package:shattably/features/home/presention/widgets/main/widgets/details/camera/camera_screen.dart';
import 'package:shattably/features/home/presention/widgets/main/widgets/details/dialog_for_details_screen.dart';

class DetailsScreen extends StatelessWidget {
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: iconButtonHomeScreen(context),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Request Service',
          style: kStyleAppBar,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Electrician',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    fontFamily: 'Tajawal',
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const CircleAvatar(
                  radius: 70.0,
                  backgroundImage: AssetImage('assets/images/electrician.png'),
                  backgroundColor: Colors.white,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  'Ali',
                  style: kTextDialog,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const CostServiceItem(),
                const SizedBox(
                  height: 20.0,
                ),
                myDivider(),
                const SizedBox(
                  height: 30.0,
                ),
                defaultFormFieldDetails(
                  controller: amountController,
                  type: TextInputType.number,
                  label: 'amount',
                  prefix: Icons.add_box,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                defaultFormFieldDetails(
                  controller: descriptionController,
                  type: TextInputType.text,
                  label: 'descriptions',
                  prefix: Icons.description,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Row(
                  children: [
                    defaultDetailsScreenButton(
                      function: () async {
                        final value = await availableCameras();
                        if (!context.mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CameraScreen(
                                camera: value,
                              ),
                            ),
                        );
                      },
                      text: 'pic image',
                      radius: 20.0,
                      width: 150.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50.0,
                ),
                defaultButton(
                  function: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => const DialogForDetailsScreen(),
                    );
                  },
                  text: 'request',
                  radius: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
