import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ratePage extends StatelessWidget {
  const ratePage({Key? key}) : super(key: key);

  // Function to set rate and store in database
  void setRate(String rateInput, String workerEmail) async {
    try {
      // Get the current user
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Query the worker's profile using their email
        QuerySnapshot workerSnapshot = await FirebaseFirestore.instance
            .collection('profiles')
            .where('email', isEqualTo: workerEmail)
            .limit(1)
            .get();

        // If worker profile found, update their rate
        if (workerSnapshot.docs.isNotEmpty) {
          String workerUid = workerSnapshot.docs.first.id;

          // Update or create a new document for the rate
          await FirebaseFirestore.instance
              .collection('workerRates')
              .doc(workerUid)
              .set({
            'userId': currentUser.uid,
            'rate': int.parse(rateInput),
            'timestamp': FieldValue.serverTimestamp(),
          });

          print('Rate set to: $rateInput for worker with email: $workerEmail');
        } else {
          print('Worker with email: $workerEmail not found.');
        }
      } else {
        print('User not authenticated.');
      }
    } catch (e) {
      print('Error setting rate: $e');
    }
  }
  // Function to get rate of the worker using ID
  Future<String> getRate(String workerEmail) async {
    try {
      // Query the Firestore collection 'profiles' to find the worker by email
      QuerySnapshot workerSnapshot = await FirebaseFirestore.instance
          .collection('profiles')
          .where('email', isEqualTo: workerEmail)
          .limit(1)
          .get();

      // If worker profile found, retrieve their rate
      if (workerSnapshot.docs.isNotEmpty) {
        String workerUid = workerSnapshot.docs.first.id;

        // Query the 'workerRates' collection to get the rate for this worker
        DocumentSnapshot rateSnapshot = await FirebaseFirestore.instance
            .collection('workerRates')
            .doc(workerUid)
            .get();

        // If rate document exists, return the rate as a string
        if (rateSnapshot.exists) {
          return rateSnapshot['rate'].toString();
        } else {
          return 'Rate not available';
        }
      } else {
        return 'Worker not found';
      }
    } catch (e) {
      print('Error getting rate: $e');
      return 'Error getting rate';
    }
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController rateController = TextEditingController();
    String workerId = '123'; // Replace with actual worker ID from your data

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Rate',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ),
      backgroundColor: Colors.white24,
      body: Column(
        children: [
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Rate the worker out of 10',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: '',
                hintStyle: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ),
          SizedBox(height: 25,),
          ElevatedButton(
            onPressed: () {
              String workerEmail = ''; // Rating prototype is not configured. // Replace with actual worker's email
              if (workerEmail.isEmpty) return;
              setRate(rateController.text, workerEmail);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Rate is modified, thanks',
                      style: TextStyle(
                        fontWeight: FontWeight.bold ,
                        fontSize: 25 ,
                        fontFamily: 'Tajawal',
                        color: Colors.grey,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Done',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Tajawal',
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
              textStyle: TextStyle(
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Done',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajawal' ,
                fontSize: 25 ,
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
