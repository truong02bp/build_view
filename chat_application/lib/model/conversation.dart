import 'package:chat_application/firestore_constants.dart';
import 'package:chat_application/model/user_data.dart';

class Conversation {
  final String? id;
  final UserData creator;
  final UserData receiver;
  final List<String> members;

  const Conversation({
    this.id,
    required this.creator,
    required this.receiver,
    required this.members,
  });

  Conversation copyWith({
    String? id,
    UserData? creator,
    UserData? receiver,
    List<String>? members,
  }) {
    return Conversation(
      id: id ?? this.id,
      creator: creator ?? this.creator,
      receiver: receiver ?? this.receiver,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ConversationKey.id: id,
      ConversationKey.creator: creator.toJson(),
      ConversationKey.receiver: receiver.toJson(),
      ConversationKey.members: members,
    };
  }

  factory Conversation.fromJson(Map<String, dynamic> map) {
    return Conversation(
      id: map[ConversationKey.id]?.toString(),
      creator: UserData.fromJson(
          map[ConversationKey.creator] as Map<String, dynamic>),
      receiver: UserData.fromJson(
        map[ConversationKey.receiver] as Map<String, dynamic>,
      ),
      members: List<String>.from(map[ConversationKey.members] as List<dynamic>),
    );
  }

  @override
  String toString() {
    return 'Conversation(id: $id, creator: $creator, receiver: $receiver, members: $members)';
  }

  @override
  List<Object> get props => [creator, receiver, members];
}
