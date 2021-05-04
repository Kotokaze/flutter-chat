class RoomUserEntity {
  RoomUserEntity({this.userId, this.userName, this.photoUrl, this.isMine});
  String userId;
  String userName;
  String photoUrl;
  bool isMine;

  RoomUserEntity.fromJson(String userId, Map json) {

    this.userId = json['userId'];
    this.userName = json['userName'];
    this.photoUrl = json['photoUrl'];
  }

  toObject() {
    return <String, dynamic>{
      'userId': userId,
      'name': userName,
      'photoUrl': photoUrl,
    };
  }
}
