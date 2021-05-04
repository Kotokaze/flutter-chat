import 'package:chat/infrastructure/models/room_model.dart';

class UserModel {
  UserModel(this.userId, this.userName, this.email, this.photoUrl);

  String userId;
  String userName;
  String email;
  String photoUrl;

  UserModel.member(this.userId);

  RoomUserModel toRoomUser({bool isMine = false}) {
    return RoomUserModel(
      userId: userId,
      userName: userName,
      photoUrl: photoUrl,
      isMine: isMine,
    );
  }
}
