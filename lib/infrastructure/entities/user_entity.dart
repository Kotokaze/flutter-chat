class UserEntity {
  UserEntity({this.userId, this.userName, this.email, this.photoUrl});
  String userId;
  String userName;
  String email;
  String photoUrl;

  UserEntity.fromJson(Map json) {
    this.userId = json['userId'];
    this.userName = json['userName'];
    this.email = json['email'];
    this.photoUrl = json['photoUrl'];
  }

  toObject() {
    return {
      'userId': userId,
      'userName': userName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}
