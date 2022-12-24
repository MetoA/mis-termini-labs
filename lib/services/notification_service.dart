import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin
        .initialize(const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher')));
  }

  Future<void> scheduleNotifications({id, title, body, time}) async {
    try {
      AndroidNotificationChannel channel = const AndroidNotificationChannel(
          'high_importance_channel', 'High Importance Notifications',
          description: 'This channel is used for important notifications.', importance: Importance.max);

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await flutterLocalNotificationsPlugin.zonedSchedule(
          1,
          title,
          body,
          tz.TZDateTime.from(time, tz.local),
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name, channelDescription: channel.description)),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
    } catch (e) {
      print('ERROR $e');
    }
  }
}
