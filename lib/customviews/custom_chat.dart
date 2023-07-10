import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';

class LeftChatMessage extends StatelessWidget {
  final String text;

  const LeftChatMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [ChatMessage(start: true, text: text), Spacer()],
    );
  }
}

class RightChatMessage extends StatelessWidget {
  final String text;

  const RightChatMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Spacer(), ChatMessage(start: false, text: text)],
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool start;

  const ChatMessage({required this.text, required this.start});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: appColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
            crossAxisAlignment:
                start ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "22:10",
                style: TextStyle(color: Colors.black),
              ),
            ]));
  }
}

class ChatTextField extends StatefulWidget {
  @override
  _ChatTextFieldState createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  TextEditingController _textEditingController = TextEditingController();
  double _textFieldWidth = 0;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(updateTextFieldWidth);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(updateTextFieldWidth);
    _textEditingController.dispose();
    super.dispose();
  }

  void updateTextFieldWidth() {
    final textPainter = TextPainter(
      text: TextSpan(
        text: _textEditingController.text,
        style: TextStyle(fontSize: 16),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    setState(() {
      _textFieldWidth =
          textPainter.width + 20; // Ekstra bir boşluk ekleyebilirsiniz
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _textFieldWidth,
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: 'Mesajınızı girin',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
