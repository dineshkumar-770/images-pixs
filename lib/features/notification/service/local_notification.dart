import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uuid/uuid.dart';

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static var uuid = const Uuid();

  static Future showNotification({required String message,required String heading}) async {
    bool? isPermissionGranted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    if (isPermissionGranted == true) {
      await flutterLocalNotificationsPlugin.show(
          2,
          heading,
          message,
          NotificationDetails(
              android: AndroidNotificationDetails(uuid.v1(), uuid.v4(),
                  enableVibration: true,
                  category: AndroidNotificationCategory.message,
                  importance: Importance.max,
                  channelShowBadge: true,
                  playSound: true)),
          payload: 'Dokeofkp Payload');
    }
  }
}
