import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

/// Notification transport only. Views own routing; a trusted backend owns sending.
class NotificationService {
  static final _opened = StreamController<Map<String,dynamic>>.broadcast();
  static Stream<Map<String,dynamic>> get opened => _opened.stream;
  static Map<String,dynamic>? _pending;
  static Map<String,dynamic>? takePending() { final value = _pending; _pending = null; return value; }
  static final _local = FlutterLocalNotificationsPlugin();

  @pragma('vm:entry-point')
  static Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // Background isolates must never navigate or depend on a mounted widget tree.
  }
  static void _open(Map<String,dynamic> payload) {
    if (_opened.hasListener) { _opened.add(payload); } else { _pending = payload; }
  }
  static Future<void> initMessagingServices() async {
    const channel = AndroidNotificationChannel('shattably', 'shattably Notifications', importance: Importance.max);
    await _local.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
    await _local.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'), iOS: DarwinInitializationSettings()),
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload == null) return;
        try { final data = jsonDecode(payload); if (data is Map<String,dynamic>) _open(data); }
        on FormatException { /* Ignore malformed external payloads. */ }
      });
    await FirebaseMessaging.instance.requestPermission();
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) _pending = initial.data;
    FirebaseMessaging.onMessageOpenedApp.listen((message) => _open(message.data));
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _local.show(message.hashCode, notification.title, notification.body,
        const NotificationDetails(android: AndroidNotificationDetails('shattably', 'shattably Notifications',
          importance: Importance.max, priority: Priority.high)), payload: jsonEncode(message.data));
    });
  }
}