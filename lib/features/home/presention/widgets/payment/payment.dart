import 'package:flutter/material.dart';

import '../../../../../components/components.dart';





class payment extends StatelessWidget {
  const payment({super.key});



  @override
  Widget build(BuildContext context) {
    var widget;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent ,
        title: Text(
          'payment ' ,

          style: TextStyle(
            fontWeight: FontWeight.bold ,
            fontFamily: 'Tajawal',
            fontSize: 25 ,
            color: Colors.white ,

          ),
        ),
      ),

      body: Column(
        children: [

          SizedBox(height: 30,),

          ElevatedButton(
            onPressed: () {




            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // Background color of button
              onPrimary: Colors.white, // Text color of button
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: Center(
              child: Row(
                children: [

                  CircleAvatar(
                    radius: 25, // Adjust the radius as needed
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9qyxEUTrmMjLkuYB3nF0uU5FzB4XjimHU-A&s'
                    ),

                  ),

                  SizedBox(width: 15,) ,


                  Text(
                    'Vodafone Cash',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ) ,
          ),
          SizedBox(height: 25,),

          ElevatedButton(
            onPressed: () {




            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // Background color of button
              onPrimary: Colors.white, // Text color of button
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: Center(
              child: Row(
                children: [

                  CircleAvatar(
                    radius: 25, // Adjust the radius as needed
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      'https://image.similarpng.com/very-thumbnail/2020/06/Logo-etisalat-vector-download-free-PNG.png',
                    ),

                  ),

                  SizedBox(width: 15,) ,



                  Text(
                    'Etisalat Cash',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ) ,
          ),
          SizedBox(height: 25,),

          ElevatedButton(
            onPressed: () {




            },
            style: ElevatedButton.styleFrom(
              primary: Colors.amber, // Background color of button
              onPrimary: Colors.white, // Text color of button
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: Center(
              child: Row(
                children: [

                  CircleAvatar(
                    radius: 25, // Adjust the radius as needed
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Orange_logo.svg/2048px-Orange_logo.svg.png'
                    ),

                  ),

                  SizedBox(width: 15,) ,



                  Text(
                    'Orange Cash',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ) ,
          ),

          SizedBox(height: 50,) ,


          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text('قم بتحويل المبلغ علي هذا الرقم', style: TextStyle(
                fontSize: 22 ,
                fontFamily: 'Tajawal' ,
                fontWeight: FontWeight.bold ,
                color: Colors.white
              ),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12 , right: 12),
            child: Center(
              child: Text('من خلال اي تطبيق دفع مناسب ', style: TextStyle(
                  fontSize: 22 ,
                  fontFamily: 'Tajawal' ,
                  fontWeight: FontWeight.bold ,
                  color: Colors.white
              ),),
            ),
          ),

          SizedBox(height: 40,),
          
          Text('Payment recipient not configured' , style: TextStyle(
              fontSize: 30 ,
              fontFamily: 'Tajawal' ,
              fontWeight: FontWeight.bold ,
              color: Colors.white
          ),)








        ],
      ),



    );

  }
}
