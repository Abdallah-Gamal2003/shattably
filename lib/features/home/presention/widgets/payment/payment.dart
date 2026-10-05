import 'package:flutter/material.dart';






class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent ,
        title: const Text(
          'PaymentScreen ' ,

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

          const SizedBox(height: 30,),

          ElevatedButton(
            onPressed: () {




            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Background color of button
              foregroundColor: Colors.white, // Text color of button
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: const Center(
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
          const SizedBox(height: 25,),

          ElevatedButton(
            onPressed: () {




            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Background color of button
              foregroundColor: Colors.white, // Text color of button
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: const Center(
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
          const SizedBox(height: 25,),

          ElevatedButton(
            onPressed: () {




            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber, // Background color of button
              foregroundColor: Colors.white, // Text color of button
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: const Center(
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

          const SizedBox(height: 50,) ,


          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: Text('قم بتحويل المبلغ علي هذا الرقم', style: TextStyle(
                fontSize: 22 ,
                fontFamily: 'Tajawal' ,
                fontWeight: FontWeight.bold ,
                color: Colors.white
              ),),
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 12 , right: 12),
            child: Center(
              child: Text('من خلال اي تطبيق دفع مناسب ', style: TextStyle(
                  fontSize: 22 ,
                  fontFamily: 'Tajawal' ,
                  fontWeight: FontWeight.bold ,
                  color: Colors.white
              ),),
            ),
          ),

          const SizedBox(height: 40,),
          
          const Text('Payment recipient not configured' , style: TextStyle(
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
