import 'package:carryvibemobile/customviews/custom_chat.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChatScreen();
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;

    final double usableScreenHeight = screenHeight - appBarHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                LeftChatMessage(text: "Benim kargomu ne zaman alacksınız?"),
                RightChatMessage(text: "Merhabalar"),
                RightChatMessage(
                    text:
                        "Senin kargonu alırım amaKargocuğunuz sizemi ağitttiriiiiiii")
                // Diğer mesajları buraya ekleyin
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: ChatTextField(),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Mesaj gönderme işlemini burada gerçekleştirin
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
