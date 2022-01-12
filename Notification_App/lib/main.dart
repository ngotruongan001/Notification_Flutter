import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/cardNotification.dart';
import 'package:notification_app/models/pushNotification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notification Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class _MyHomePageState extends State<MyHomePage> {
  List<PushNotification> _listNotification  = [];

  void registerNotification() async {
    await Firebase.initializeApp();
    FirebaseMessaging.instance.getToken().then((token){
      print('FCM TOKEN');
      print(token);
      print('end.');
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.title);
      print(event.notification!.body);
      PushNotification newNotification = PushNotification(
        title: event.notification?.title,
        body: event.notification?.body,
      );
      setState(() {
        _listNotification = List.from(_listNotification)
          ..add(newNotification);
      });

      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: Text("Notification"),
      //         content: Text(event.notification!.body!),
      //         actions: [
      //           TextButton(
      //             child: Text("Ok"),
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //             },
      //           )
      //         ],
      //       );
      //     });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerNotification();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: _listNotification.length,
          itemBuilder: (BuildContext context, int index) {
            return CardNotification(_listNotification[index].title, _listNotification[index].body);
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        )
    );
  }
}