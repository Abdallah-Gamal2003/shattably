import 'dart:convert';

import 'package:flutter/material.dart';
class Response extends StatelessWidget {
  Response({dynamic  getorder}){
    order=getorder["order"];
    sDate=getorder["start_date"];
    eDate=getorder["end_date"];

  }
  late String order;
  late String sDate;
  late String eDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:     SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text("order" ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal' ,
                fontSize: 25 ,
                color: Colors.white ,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: TextEditingController(text: order),
              maxLines: null,
              enabled: false,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),

              ),

            ),SizedBox(
              height: 15,
            ),
            Text("start date",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal' ,
                fontSize: 25 ,
                color: Colors.white ,
              ),

            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: TextEditingController(text: sDate),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              enabled: false,

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),

              ),

            ),SizedBox(
              height: 15,
            ),
            Text("end date" ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal' ,
                fontSize: 25 ,
                color: Colors.white ,

            ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: TextEditingController(text: eDate),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              enabled: false,

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),

              ),

            ),
            ElevatedButton(onPressed: (){}, child: Text("ارسال عرض" ,

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal' ,
                  fontSize: 25 ,
                  color: Colors.white ,
                ),

            )),
          ],
        ),
      ),
    );
  }
}
