import 'package:chat/infrastructure/entities/room_user_entity.dart';
import 'package:chat/utils/date_time_util.dart';

class MessageEntity {
  MessageEntity(this.msgId, this.sentBy, this.content, this.imageUrl, this.createdAt);
  String msgId;
  String sentBy;
  String content;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;

  RoomUserEntity roomUser;

  MessageEntity.createContent(this.msgId, this.sentBy, this.content, this.createdAt);
  MessageEntity.createImage(this.msgId, this.sentBy, this.imageUrl, this.createdAt);
  MessageEntity.fromJson(Map json, String msgId) {
    this.msgId = msgId;
    this.content = json['content'];
    this.imageUrl = json['imageUrl'];
    this.sentBy = json['sentBy'];
    this.createdAt = DateTimeUtil().parseTime(json['updatedAt']);
    this.updatedAt = DateTimeUtil().parseTime(json['updatedAt']);
  }

  toObject() {
    return {
      'content': content,
      'imageUrl': imageUrl != null ? imageUrl.toString() : null,
      'sentBy': sentBy,
      'createdAt': createdAt,
      'updatedAt': DateTime.now(),
    };
  }
}
