import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class TestNotification extends StatefulWidget {
  const TestNotification({Key? key}) : super(key: key);

  @override
  State<TestNotification> createState() => _TestNotificationState();
}

class _TestNotificationState extends State<TestNotification> {

  void _showNotification() {
    FlutterLocalNotificationsPlugin _localNotify = FlutterLocalNotificationsPlugin();
    _localNotify.show(
        (DateTime
            .now()
            .millisecondsSinceEpoch / 1000).round(),
        'Hello',
        'text notification',
        const NotificationDetails(android: AndroidNotificationDetails(
            'high_importance_channel', 'High Importance Notifications',
            channelDescription: 'This channel is used for important notifications.',
            color: Color(0xFFD2201E),
            importance: Importance.high,
            priority: Priority.high,
            //icon: 'ic_launcher'
        )),
        );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Show noti'),
      ),
      body: Container(
        child:  Center(
          child: GestureDetector(
              onTap: (){
                _showNotification();
              },
              child: Text('Show notification')),

        ),
      ),
    );
  }
}
