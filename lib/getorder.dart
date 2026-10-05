
import 'package:flutter/material.dart';
class Response extends StatelessWidget {
  Response({super.key, dynamic  getorder}){
    order=getorder["order"];
    sDate=getorder["start_date"];
    eDate=getorder["end_date"];

  }
  late final String order;
  late final String sDate;
  late final String eDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:     SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text("order" ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal' ,
                fontSize: 25 ,
                color: Colors.white ,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: TextEditingController(text: order),
              maxLines: null,
              enabled: false,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),

              ),

            ),const SizedBox(
              height: 15,
            ),
            const Text("start date",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal' ,
                fontSize: 25 ,
                color: Colors.white ,
              ),

            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: TextEditingController(text: sDate),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              enabled: false,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),

              ),

            ),const SizedBox(
              height: 15,
            ),
            const Text("end date" ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal' ,
                fontSize: 25 ,
                color: Colors.white ,

            ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: TextEditingController(text: eDate),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              enabled: false,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),

              ),

            ),
            ElevatedButton(onPressed: (){}, child: const Text("ارسال عرض" ,

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
