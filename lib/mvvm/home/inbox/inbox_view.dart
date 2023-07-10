import 'package:carryvibemobile/customviews/custom_inbox.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class InboxView extends StatelessWidget {
  const InboxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InboxScreen();
  }
}

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return CustomInbox(
              date: "Paz 25 Haziran, 23:10",
              departure: "Küçükçekmece",
              destination: "Pendik",
              name: "Yunus Emre",
              avatar:
                  "https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png");
        },
      ),
    );
  }
}
