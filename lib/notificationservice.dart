import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:logger/logger.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/firebase_options.dart';
import 'package:shattably/getorder.dart';
import 'package:shattably/navigationservice.dart';

import 'offers.dart';

@pragma('vm:entry-point')
class NotificationService{
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
    openNotification(message.data);

  }
  static void openNotification(Map payloadObj) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (payloadObj['id'] != null) {
      switch(payloadObj['key']){
        case "orderEvent":
          FirebaseFirestore.instance.collection('orders')
              .doc(payloadObj['id'])
              .get()
              .then((value) {
            navigateTo(NavigationService.context, Response(getorder: value.data().toString()));
          });
          break;
        case "offerEvent":
          FirebaseFirestore.instance.collection('offers')
              .doc(payloadObj['id'])
              .get()
              .then((value) {
            navigateTo(NavigationService.context,OffersScreen(orderId: value.data()));
          });
          break;
      }

    }
  }

    static initMessagingServices() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      late AndroidNotificationChannel channel = const AndroidNotificationChannel(
        'shattably',
        'shattably Notifications',
        showBadge: true,
        importance: Importance.max,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);



      const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

      var initializationSettingsIOS = DarwinInitializationSettings(
          requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true,
          onDidReceiveLocalNotification: (id, title, body, payload) async {
          }
      );

      InitializationSettings initializationSettings =
      InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,

          onDidReceiveNotificationResponse: (response) async {
            var payloadObj = jsonDecode(response.payload!);

            if (payloadObj['id'] != null) {
              switch(payloadObj['key']){
                case "orderEvent":
                  FirebaseFirestore.instance.collection('orders')
                      .doc(payloadObj['id'])
                      .get()
                      .then((value) {
                    navigateTo(NavigationService.context, Response(getorder: value.data().toString()));
                  });
                  break;
                case "offerEvent":
                  FirebaseFirestore.instance.collection('offers')
                      .doc(payloadObj['id'])
                      .get()
                      .then((value) {
                    navigateTo(NavigationService.context,OffersScreen(orderId: value.data()));
                  });
                  break;
              }

            }
            }

      );

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      FirebaseMessaging.instance.getInitialMessage().then((value) {
        if (value != null) {
          var key= value.data!['key'];
          switch(key){
            case "orderEvent":
              FirebaseFirestore.instance.collection('orders')
                  .doc( value.data!['id'])
                  .get()
                  .then((value) {
                navigateTo(NavigationService.context, Response(getorder: value.data().toString()));
              });
              break;
            case "offerEvent":
              FirebaseFirestore.instance.collection('offers')
                  .doc( value.data!['id'])
                  .get()
                  .then((value) {
                navigateTo(NavigationService.context,OffersScreen(orderId: value.data()));
              });
              break;
          }


        }
      });
      FirebaseMessaging.onMessage.listen((event) {
        flutterLocalNotificationsPlugin.show(
            event.hashCode,
            event.notification!.title,
            event.notification!.body,
            const NotificationDetails(
                android: AndroidNotificationDetails(
                  'shattably',
                  'shattably Notifications',
                  channelDescription: 'shattably Notifications',
                  importance: Importance.max,
                  priority: Priority.high,
                  showWhen: false,
                ),
                iOS: DarwinNotificationDetails(
                  sound: 'default',
                  subtitle: 'shattably',
                  badgeNumber: 1,
                  categoryIdentifier: 'shattably',
                  threadIdentifier: 'shattably',
                ),

            ),
            payload: jsonEncode(event.data)
        );

      });
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print('Received FCM message: ${event.data}');

        if(event.data['id'] != null){

          var key= event.data!['key'];
          switch(key){
            case "orderEvent":
              FirebaseFirestore.instance.collection('orders')
                  .doc( event.data['id'])
                  .get()
                  .then((value) {
                navigateTo(NavigationService.context, Response(getorder: value.data().toString()));
              });
              break;
            case "offerEvent":
              FirebaseFirestore.instance.collection('offers')
                  .doc( event.data['id'])
                  .get()
                  .then((value) {
                navigateTo(NavigationService.context, OffersScreen(orderId: value.data()));
              });
              break;
          }
        }
      });

    } catch (e) {
      if (kDebugMode) {}
    }


  }


}