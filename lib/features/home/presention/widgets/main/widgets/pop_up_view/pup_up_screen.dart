import 'package:flutter/material.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/core/utils/styles.dart';
import 'package:shattably/features/home/presention/widgets/main/widgets/cost_service_item.dart';
import 'package:shattably/features/home/presention/widgets/main/widgets/details/details_screen.dart';
import 'package:shattably/features/home/presention/widgets/main/widgets/pop_up_view/pop_up_body_screen.dart';

class DialogExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      title:  Center(
        child: Text(
            'Electrician',
            style:kTextDialog,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5.0,
                ),
                CircleAvatar(
                  radius: 45.0,
                  backgroundImage: AssetImage('assets/images/electrician.png'),
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                    'Ali',
                  style: kTextDialog,
                ),
                SizedBox(
                  height: 10.0,
                ),
                CostServiceItem(),
                SizedBox(
                  height: 10.0,
                ),
                DialogBody(
                  textTitle: 'City',
                  textContain: 'Giza',
                ),
                SizedBox(
                  height: 10.0,
                ),
                DialogBody(
          textTitle: 'Area',
          textContain: 'Dokki',
        ),
              ],
            ),
          ],

        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: Row(
            children: [
              defaultDialogButton(
                text: 'Request',
                width: 100.0,
                radius: 50.0,
                function: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(),),);
                },
              ),
             SizedBox(
               width: 50.0,
             ),
              defaultDialogButton(
                text: 'Discard',
                background: Colors.grey,
                width: 100.0,
                radius: 50.0,
                function: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}


