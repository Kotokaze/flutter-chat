import 'package:chat/infrastructure/entities/message_entity.dart';
import 'package:chat/infrastructure/models/message_model.dart';
import 'package:chat/infrastructure/wrapper/room_user_wrapper.dart';
import 'package:chat/infrastructure/wrapper/user_wrapper.dart';

class MessageWrapper {
  UserWrapper userWrapper = UserWrapper();
  RoomUserWrapper _roomUserWrapper = RoomUserWrapper();

  MessageEntity toEntity(MessageModel message) {
    if (message.content != null && message.downloadImageUrl != null) {
      return MessageEntity(
        message.msgId,
        message.roomUser.userId,
        message.content,
        message.downloadImageUrl,
        message.createdAt,
      );
    }

    if (message.content != null) {
      return MessageEntity.createContent(
        message.msgId,
        message.roomUser.userId,
        message.content,
        message.createdAt,
      );
    }

    if (message.downloadImageUrl != null) {
      return MessageEntity.createImage(
        message.msgId,
        message.roomUser.userId,
        message.downloadImageUrl,
        message.createdAt,
      );
    }

    throw ArgumentError("Wrong data type was selected");
  }

  MessageModel toModel(MessageEntity messageEntity) {
    return MessageModel(
      messageEntity.msgId,
      messageEntity.content,
      messageEntity.imageUrl,
      _roomUserWrapper.toModel(messageEntity.roomUser),
      messageEntity.createdAt,
    );
  }
}
