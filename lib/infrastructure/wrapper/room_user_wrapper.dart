import 'package:chat/infrastructure/entities/room_user_entity.dart';
import 'package:chat/infrastructure/models/room_model.dart';

class RoomUserWrapper {
  RoomUserEntity toEntity(RoomModel room, RoomUserModel user) {
    return RoomUserEntity(
      userId: user.userId,
      userName: user.userName,
      photoUrl: user.photoUrl,
      isMine: user.isMine,
    );
  }

  RoomUserEntity roomUserToEntity(RoomUserModel roomUser) {
    return RoomUserEntity(
      userId: roomUser.userId,
      userName: roomUser.userName,
      photoUrl: roomUser.photoUrl,
      isMine: roomUser.isMine,
    );
  }

  RoomUserModel toModel(RoomUserEntity roomUserEntity) {
    return RoomUserModel(
      userId: roomUserEntity.userId,
      userName: roomUserEntity.userName,
      photoUrl: roomUserEntity.photoUrl,
      isMine: roomUserEntity.isMine,
    );
  }
}
