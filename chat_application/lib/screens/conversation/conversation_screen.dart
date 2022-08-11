import 'package:chat_application/screens/conversation/components/header.dart';
import 'package:chat_application/screens/conversation/components/message_card.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatelessWidget {
  ScrollController _scrollController = ScrollController();

  final texts = [
    {"isSender": true, "text": "ASDJKHASDHASJKDHASKJDHASDJKAHSJKSADDHAS"},
    {"isSender": false, "text": "CXVCXVCXVXCVXVXCVXVXVCXVCXVXVXCASDASDASD"},
    {"isSender": false ,"text": "ASDASCX231DSFCVCXVXV"},
    {"isSender": true, "text": "12312312312312434543534534543"},
    {"isSender": false, "text": "1231254645645DCGDSFDFGVCB"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Header(),
              ListView.builder(
                  controller: _scrollController,
                  addAutomaticKeepAlives: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: texts.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    bool isSender = texts[index]["isSender"] as bool;
                    String text = texts[index]["text"] as String;
                    return Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: MessageCard(isSender: isSender, text: text)
                    );
                  }),
              Spacer(),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10,),
                    Container(
                      child: Icon(Icons.add, color: Colors.orangeAccent,),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Container(
                      width: 2,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    const SizedBox(width: 20,),
                    const SizedBox(width: 40, child: Text('Type', style: TextStyle(color: Colors.grey, fontSize: 16),),),
                    Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'something...',
                            hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)
                          ),
                    )),
                    Container(
                      child: Icon(Icons.arrow_upward, color: Colors.orange,),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
