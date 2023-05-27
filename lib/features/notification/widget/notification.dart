import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wallpaper_pix/common/custom_app_bar.dart';
import 'package:wallpaper_pix/features/notification/service/local_notification.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Notification'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  await LocalNotification.showNotification(
                      message: 'Image downloaded Succesfully',heading: '');
                  // bool? isPermissionGranted =
                  //     await flutterLocalNotificationsPlugin
                  //         .resolvePlatformSpecificImplementation<
                  //             AndroidFlutterLocalNotificationsPlugin>()
                  //         ?.requestPermission();
                  // if (isPermissionGranted == true) {
                  //   await flutterLocalNotificationsPlugin.show(
                  //       1,
                  //       'Images PIX',
                  //       'Image downloaded successfully',
                  //       const NotificationDetails(
                  //           android: AndroidNotificationDetails(
                  //               'channelId', 'channelName',
                  //               enableVibration: true,
                  //               category: AndroidNotificationCategory.message,
                  //               importance: Importance.max)),
                  //       payload: 'Dokeofkp Payload');
                  // }
                },
                child: const Text('Notify')),
          )
        ],
      ),
    );
  }
}
