class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class UserData {
  final String id;
  final String username;
  final String? avatar;

  const UserData({
    required this.id,
    required this.username,
    this.avatar,
  });
  static UserData fromJson(dynamic json) => UserData(
    id: json['id'],
    username: json['username'],
    avatar: json['avatar'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'avatar': avatar,
  };
}