import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  bool isSender;
  String text;

  MessageCard({required this.isSender, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: new BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 1 / 2),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10),
                      bottomLeft: isSender ? Radius.circular(10) : Radius.circular(0),
                      bottomRight: isSender? Radius.circular(0) : Radius.circular(10)),
                  color: isSender
                      ? Colors.orangeAccent
                      : Colors.grey.withOpacity(0.3)),
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 6, top: 6),
              child: Text('$text',
                  style: TextStyle(
                      fontSize: 16, color: Colors.black.withOpacity(0.9))),
            ),
          ],
        ),
      ],
    );
  }
}
