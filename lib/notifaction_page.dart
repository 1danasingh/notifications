import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:signin/login_controller.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'main.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  LogInController logInController = Get.find<LogInController>();
  List<String> title = ["Nice to meet you.","All good ?","Stay hydrated","Here is your notification","How you doing ?","Welcome to this app","Have a nice day"];
  TextEditingController name = TextEditingController();
  TextEditingController seconds = TextEditingController();
  FlutterLocalNotificationsPlugin notification = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    var initializationSettingAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingAndroid, iOS: initializationSettingIOS);
    notification.initialize(
      initializationSettings,
    );
  }

  NotificationDetails _showN() {
    var android = const AndroidNotificationDetails('channel Id', 'Anonymous',
      importance: Importance.max,
    );
    var ios = const IOSNotificationDetails();
    var generalNotification = NotificationDetails(android: android, iOS: ios);
    return generalNotification;
  }

  Future shownInstantNotification({
    int id = 0,
    String title = 'Hello',
    String? body,
  }) async {
    await notification.show(id, title, body, _showN());
  }

  Future showScheduledNotification(
      {int id = 1, String title = 'Hello', String? body, int? s
      }) async{
    var scheduled_ = DateTime.now().add(Duration(seconds: s!));
    notification.zonedSchedule(id, title, body, tz.TZDateTime.from(scheduled_,tz.local), _showN(), uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime , androidAllowWhileIdle: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Notifications'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            SizedBox(
              height: 240,
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 15,
                            offset: const Offset(5, 5),
                            color: Colors.grey[700]!),
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 15,
                            offset: const Offset(-5, -5),
                            color: Colors.grey[400]!)
                      ]),
                  child: Center(
                    child: Icon(Icons.notifications,size: 100,color: Colors.grey[900],),),
                ),
              ),
            ),
            TextField(
              controller: name,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            InkWell(
              onTap: () {
                String name_ = (name.text == '') ? 'Anonymous' : name.text;
                shownInstantNotification(
                    body: 'Hello! $name_ .${title[randomBetween(0, title.length-1)]}');
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 40),
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 15,
                          offset: const Offset(5, 5),
                          color: Colors.grey[700]!),
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 15,
                          offset: const Offset(-5, -5),
                          color: Colors.grey[400]!)
                    ]),
                child: const Center(
                    child: Text(
                      'Instant Notification',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    )),
              ),
            ),
            const Text('After how many seconds you want a notification ?'),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: seconds,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter seconds',
              ),
            ),
            InkWell(
              onTap: () {
                String seconds_ = seconds.text;
                int s = (seconds_ == '') ? 2 : int.parse(seconds_);
                showScheduledNotification(
                    body: "Hey! I'm back after $s seconds",
                    s: s);
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 30,20 ),
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 15,
                          offset: const Offset(5, 5),
                          color: Colors.grey[700]!),
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 15,
                          offset: const Offset(-5, -5),
                          color: Colors.grey[400]!)
                    ]),
                child: const Center(
                    child: Text(
                      'Scheduled Notification',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    )),
              ),
            ),
            TextButton(onPressed: (){
              Get.off(()=>const MyApp());
              logInController.changeStatus(false);
            }, child: const Text('Log out',style: TextStyle(color: Colors.blue,fontSize: 16),))
          ],
        ),
      ),
    );
  }
}
