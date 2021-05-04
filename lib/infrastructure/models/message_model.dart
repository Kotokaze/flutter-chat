import 'package:chat/infrastructure/models/room_model.dart';
import 'package:chat/utils/date_time_util.dart';

class MessageModel {
  MessageModel(this.msgId, this.content, this.downloadImageUrl, this.roomUser, this.createdAt);
  String msgId;
  String roomId;
  String content;
  String downloadImageUrl;
  RoomUserModel roomUser;
  DateTime createdAt = DateTime.now();

  String get createdAtStr => DateTimeUtil().dateTime2str(createdAt);

  MessageModel.create(this.content, this.roomUser);
  MessageModel.createImage(this.downloadImageUrl, this.roomUser);
}
