import 'dart:io';

import 'package:chat_application/firestore_constants.dart';
import 'package:chat_application/model/conversation.dart';
import 'package:chat_application/model/message_chat.dart';
import 'package:chat_application/model/user_data.dart';
import 'package:chat_application/repository/conversation_firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseRepository {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseStorage fireStorage = FirebaseStorage.instance;
  final ConversationFirebaseRepository conversationFirebaseRepository = ConversationFirebaseRepository();

  Future<Conversation?> getConversation({
    required String senderUID,
    required String receiverUID,
  }) async {
    final json = await conversationFirebaseRepository.getConversationId(
      senderUID: senderUID,
      receiverUID: receiverUID,
    );
    if (json == null) {
      return null;
    } else {
      return Conversation.fromJson(json);
    }
  }

  Future<List<UserData>> getUserList() async {
    final users =
        await fireStore.collection(FirestoreConstants.pathUserCollection).get();
    return users.docs.map((e) => UserData.fromJson(e)).toList();
  }

  Stream<QuerySnapshot> getLastMessage(String groupId) {
    return fireStore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(groupId)
        .collection(groupId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(1)
        .snapshots();
  }

  UploadTask upLoadImageFile(File image, String filename) {
    Reference reference = fireStorage.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Stream<QuerySnapshot> getChatMessage(String groupChatId, int limit) {
    return fireStore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendMessage(String lastMessage, int type, String groupId, String idFrom,
      String idTo) {
    DocumentReference documentReference = fireStore
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(groupId)
        .collection(groupId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    Message message = Message(
      idFrom: idFrom,
      idTo: idTo,
      lastMessage: lastMessage,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
    );

    fireStore.runTransaction(
      (transaction) async => transaction.set(
        documentReference,
        message.toJson(),
      ),
    );
  }
}
