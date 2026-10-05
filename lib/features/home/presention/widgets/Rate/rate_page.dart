import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RatePage extends StatelessWidget {
  const RatePage({super.key});

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

          debugPrint('Rate set to: $rateInput for worker with email: $workerEmail');
        } else {
          debugPrint('Worker with email: $workerEmail not found.');
        }
      } else {
        debugPrint('User not authenticated.');
      }
    } catch (e) {
      debugPrint('Error setting rate: $e');
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
      debugPrint('Error getting rate: $e');
      return 'Error getting rate';
    }
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController rateController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
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
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.all(15),
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
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: '',
                hintStyle: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ),
          const SizedBox(height: 25,),
          ElevatedButton(
            onPressed: () {
              String workerEmail = ''; // Rating prototype is not configured. // Replace with actual worker's email
              if (workerEmail.isEmpty) return;
              setRate(rateController.text, workerEmail);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Rate is modified, thanks',
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
                        child: const Text('Done',
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
              backgroundColor: Colors.deepOrange,
              textStyle: const TextStyle(
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
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
