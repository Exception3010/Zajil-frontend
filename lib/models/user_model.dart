class UserModel {
  final String uid;              // Firebase Auth ID
  final String username;         // Unique handle
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String appLanguage;
  final String appTheme;
  final DateTime createdAt;
  final List<String> friendsUids;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.displayName,
    this.photoUrl,
    required this.appLanguage,
    required this.appTheme,
    required this.createdAt,
    required this.friendsUids,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      appLanguage: json['appLanguage'] ?? 'ar',
      appTheme: json['appTheme'] ?? 'system',
      createdAt: DateTime.parse(json['createdAt'] as String),
      friendsUids: List<String>.from(json['friendsUids'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'appLanguage': appLanguage,
      'appTheme': appTheme,
      'createdAt': createdAt.toIso8601String(),
      'friendsUids': friendsUids,
    };
  }

  // Keeping these for backward compatibility if needed during transition
  Map<String, dynamic> toMap() => toJson();
}
