import 'package:chat/infrastructure/models/room_model.dart';
import 'package:chat/infrastructure/entities/room_entity.dart';
import 'package:chat/infrastructure/entities/room_user_entity.dart';
import 'package:chat/infrastructure/wrapper/message_wrapper.dart';
import 'package:chat/infrastructure/wrapper/room_user_wrapper.dart';

class RoomWrapper {
  RoomUserWrapper _roomUserWrapper = RoomUserWrapper();

  RoomEntity toEntity(RoomModel room) {
    List<RoomUserEntity> roomUserEntityList = room.members.map(
      (member) => _roomUserWrapper.toEntity(room, member)
    ).toList();

    return RoomEntity(
      room.roomId,
      room.title,
      room.createdAt,
      roomUserEntityList,
      room.lastMsg != null ? MessageWrapper().toEntity(room.lastMsg) : null,
      photoUrl: room.photoUrl,
    );
  }

  List<RoomModel> toModelList(List<RoomEntity> roomEntityList) {
    return roomEntityList.map((roomEntity) => toModel(roomEntity)).toList();
  }

  RoomModel toModel(RoomEntity roomEntity) {
    return RoomModel(
      title: roomEntity.title,
      roomId: roomEntity.roomId,
      createdAt: roomEntity.createdAt,
      members: roomEntity.members.map((member) => _roomUserWrapper.toModel(member)).toList(),
      photoUrl: roomEntity.photoUrl,
      lastMsg: roomEntity.lastMessage != null ? MessageWrapper().toModel(roomEntity.lastMessage) : null,
    );
  }
}
