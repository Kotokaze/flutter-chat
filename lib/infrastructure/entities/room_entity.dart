import 'package:chat/infrastructure/entities/message_entity.dart';
import 'package:chat/infrastructure/entities/room_user_entity.dart';
import 'package:chat/utils/date_time_util.dart';

class RoomEntity {
  RoomEntity(this.roomId, this.title, this.createdAt, this.members, this._lastMsg, { this.photoUrl });
  String roomId;
  String title;
  String photoUrl;
  DateTime createdAt;
  DateTime updatedAt;
  List<RoomUserEntity> members;
  MessageEntity _lastMsg;

  set lastMessage(MessageEntity messageEntity) {

    _lastMsg = messageEntity;
  }

  MessageEntity get lastMessage {
    if (_lastMsg == null) return null;

    return _lastMsg
      ..roomUser = members.firstWhere((member) => _lastMsg.sentBy == member.userId, orElse: () => RoomUserEntity());
  }

  RoomEntity.only({this.roomId, this.title, this.createdAt});

  RoomEntity.fromJson(Map json, String roomId) {
    List<RoomUserEntity> roomMembers = json['members'].keys.map<RoomUserEntity>(
      (uid) => RoomUserEntity(userId: uid)
    ).toList();

    this.roomId = roomId;
    this.title = json['title'];
    this.createdAt = DateTimeUtil().parseTime(json['created_at']);
    this.members = roomMembers;
    this.photoUrl = json['photoUrl'] != 'null' ? json['photoUrl'] : null;
    this.updatedAt = DateTimeUtil().parseTime(json['updated_at']);
    this._lastMsg = json['lastMsg'] != null ? MessageEntity.fromJson(json['lastMsg'], null) : null;
  }

  toObject() => <String, dynamic>{
    'roomId': roomId,
    'title': title,
    'createdAt': createdAt,
    'members': toMembersObj(),
    'photoUrl': photoUrl,
    'updatedAt': DateTime.now(),
    'lastMsg': lastMessage != null ? lastMessage.toObject() : null,
  };

  toMembersObj() => Map.fromIterable(members, key: (member) => member.userId, value: (_) => true);
}
