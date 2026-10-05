import 'package:flutter/material.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/core/utils/styles.dart';
import'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shattably/getorder.dart';


class OrderServiceItem extends StatelessWidget {
dynamic order;
OrderServiceItem({this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){
      navigateTo(context,Response(getorder: order,) );

    },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              right: 20.0,
              left: 20.0,
              bottom: 10.0,
            ),
            child: Container(
              height: 120.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '20.0',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.00,
                              ),
                            ),
                            SizedBox(
                              width: 80.0,
                            ),
                            Text(
                              'ali',
                              style: kTextOrder,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '12/3/2023',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.00,
                              ),
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Text(
                              '${AppLocalizations.of(context)!.electrician}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage: AssetImage('assets/images/user.png'),
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
