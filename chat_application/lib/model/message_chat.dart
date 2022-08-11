import 'package:chat_application/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Message {
  final String idFrom;
  final String idTo;
  final String lastMessage;
  final String timestamp;
  final int type;
  Message({
    required this.idFrom,
    required this.idTo,
    required this.lastMessage,
    required this.timestamp,
    required this.type,
  });

  factory Message.formDocument(DocumentSnapshot snapshot) {
    String idFrom = "";
    String idTo = "";
    String lastMessage = "";
    String timestamp = "";
    int type = 0;
    try {
      idFrom = snapshot.get(FirestoreConstants.idFrom);
      idTo = snapshot.get(FirestoreConstants.idTo);
      lastMessage = snapshot.get(FirestoreConstants.lastMessage);
      timestamp = snapshot.get(FirestoreConstants.timestamp);
      type = snapshot.get(FirestoreConstants.type);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return Message(
      idFrom: idFrom,
      idTo: idTo,
      lastMessage: lastMessage,
      timestamp: timestamp,
      type: type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.lastMessage: lastMessage,
      FirestoreConstants.type: type,
    };
  }
}

enum ChatType {
  text,
  image,
}

extension ChatTypeExtension on ChatType {
  int get value {
    switch (this) {
      case ChatType.text:
        return 0;
      case ChatType.image:
        return 1;
      default:
        return 0;
    }
  }
}