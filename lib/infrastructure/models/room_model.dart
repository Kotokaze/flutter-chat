import 'package:uuid/uuid.dart';
import 'package:chat/infrastructure/models/message_model.dart';

class RoomModel {
  RoomModel({this.roomId, this.title, this.photoUrl, this.createdAt, this.members, this.lastMsg}) {
    this.roomId = this.roomId ?? Uuid().v4();
    this.createdAt = this.createdAt ?? DateTime.now();
  }

  String roomId;
  String title;
  DateTime createdAt;
  List<RoomUserModel> members;
  String photoUrl;
  MessageModel lastMsg;
  int msgCount;
  RoomUserModel get myRoomUser => members.firstWhere((member) => member.isMine, orElse: () => RoomUserModel());
}


class RoomUserModel {
  RoomUserModel({this.userId, this.userName, this.photoUrl, this.isMine = false});

  String userId;
  String userName;
  String photoUrl;
  bool isMine;
}
