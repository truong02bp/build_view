import 'dart:developer';

import 'package:chat_application/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationFirebaseRepository {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getConversationId({
    required String senderUID,
    required String receiverUID,
  }) async {
    final members = [senderUID, receiverUID];

    final conversationQuerySnap =
        await fireStore.collection(ConversationKey.collectionName).where(
      ConversationKey.members,
      whereIn: [
        members,
        members.reversed.toList(),
      ],
    ).get();
    log(conversationQuerySnap.docs.length.toString());
    if (conversationQuerySnap.docs.isNotEmpty) {
      return conversationQuerySnap.docs.first.data();
    }
    createConversation(conversation: conversation);
    return null;
  }

  Future<String> createConversation({
    required Map<String, dynamic> conversation,
  }) async {
    print(conversation);
    final conversationRef = await fireStore
        .collection(ConversationKey.collectionName)
        .add(conversation);
    await conversationRef.update({ConversationKey.id: conversationRef.id});
    return conversationRef.id;
  }
}
