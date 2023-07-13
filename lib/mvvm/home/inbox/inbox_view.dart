import 'package:carryvibemobile/customviews/custom_inbox.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/home/inbox/chat/chat_view.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:flutter/material.dart';

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
    return CustomListView(service: Service.shared(), children: [
      CustomInbox(
        date: "Paz 25 Haziran, 23:10",
        departure: "Küçükçekmece",
        destination: "Pendik",
        name: "Yunus Emre",
        avatar:
            "https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png",
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatView()));
        },
      )
    ]);
  }
}
