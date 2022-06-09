import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_home_dev/common/notificationservice.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class TestNotification extends StatefulWidget {
  const TestNotification({Key? key}) : super(key: key);

  @override
  State<TestNotification> createState() => _TestNotificationState();
}

class _TestNotificationState extends State<TestNotification> {
  TextEditingController Notification_title = TextEditingController();
  TextEditingController Notification_descrp = TextEditingController();

  @override
  initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("GeeksForGeeks"),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: Notification_title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Title",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: Notification_descrp,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Description",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  NotificationService().showNotification(
                      1, Notification_title.text, Notification_descrp.text);
                },
                child: Container(
                  height: 40,
                  width: 200,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      "Show Notification",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
