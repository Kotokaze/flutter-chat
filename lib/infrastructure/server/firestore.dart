import 'package:chat/infrastructure/entities/room_entity.dart';
import 'package:chat/infrastructure/entities/room_user_entity.dart';
import 'package:chat/infrastructure/entities/user_entity.dart';
import 'package:chat/infrastructure/models/message_model.dart';
import 'package:chat/infrastructure/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat/infrastructure/models/room_model.dart';
import 'package:chat/infrastructure/wrapper/message_wrapper.dart';
import 'package:chat/infrastructure/wrapper/room_user_wrapper.dart';
import 'package:chat/infrastructure/wrapper/room_wrapper.dart';
import 'package:chat/infrastructure/wrapper/user_wrapper.dart';

class FirestoreStorage {
  FirestoreStorage(this._firestore);
  final FirebaseFirestore _firestore;

  final UserWrapper _userWrapper = UserWrapper();
  final RoomWrapper _roomWrapper = RoomWrapper();
  final RoomUserWrapper _roomUserWrapper = RoomUserWrapper();
  final MessageWrapper _messageWrapper = MessageWrapper();

  Future<bool> createNewRoom(RoomModel room, UserModel user) async {
    await this
        ._firestore
        .collection('rooms')
        .doc(room.roomId)
        .set(_roomWrapper.toEntity(room).toObject());

    return addInitialMemberToRoom(room, user);
  }

  Future<bool> updateRoom(RoomModel room) async {
    RoomEntity _roomEntity = _roomWrapper.toEntity(room);
    DocumentReference _documentReference = this
        ._firestore
        .collection("rooms")
        .doc(_roomEntity.roomId);

    await this._firestore.runTransaction((Transaction tx) async {
      DocumentSnapshot _roomSnapshot = await tx.get(_documentReference);

      if (_roomSnapshot.exists)
        tx.update(_documentReference, _roomEntity.toObject());
    });

    return Future.value(true);
  }

  Future<bool> addInitialMemberToRoom(RoomModel room, UserModel user) async {
    UserEntity _userEntity = _userWrapper.toEntity(user);
    RoomUserModel _roomUser = user.toRoomUser(isMine: true);
    RoomUserEntity _roomUserEntity = _roomUserWrapper.roomUserToEntity(_roomUser);

    try {
      await this
          ._firestore
          .collection('rooms')
          .doc(room.roomId)
          .collection('members')
          .doc(_userEntity.userId)
          .set(_roomUserEntity.toObject());

      return Future.value(true);
    } catch (e) {
      print(e);
      return Future.value(false);
    }
  }

  Future<RoomUserModel> updateRoomUser(RoomModel room) async {
    final RoomEntity _roomEntity = _roomWrapper.toEntity(room);
    final RoomUserEntity _roomUserEntity = _roomUserWrapper.toEntity(room, room.myRoomUser);

    DocumentReference _documentReference = this
        ._firestore
        .collection('rooms')
        .doc(_roomEntity.roomId)
        .collection('members')
        .doc(_roomUserEntity.userId);

    await this._firestore.runTransaction((Transaction tx) async {
      DocumentSnapshot _memberSnapshot = await tx.get(_documentReference);

      if (_memberSnapshot.exists)
        tx.update(_documentReference, _roomUserEntity.toObject());
    });

    DocumentSnapshot _memberDocumentSnapshot = await _documentReference.get();
    RoomUserEntity _newRoomUserEntity = RoomUserEntity.fromJson(
      _memberDocumentSnapshot.id,
      _memberDocumentSnapshot.data(),
    );

    return _roomUserWrapper.toModel(_newRoomUserEntity)
        ..isMine=true;
  }

  Future<bool> postMessage(RoomModel room, MessageModel message) async {
    Future<void> _createMessageFuture = this
        ._firestore
        .collection("rooms")
        .doc(room.roomId)
        .collection("messages")
        .doc()
        .set(_messageWrapper.toEntity(message).toObject());

    await Future.wait([_createMessageFuture, updateLastMsg(room, message)]);
    return Future.value(true);
  }

  Future<bool> updateLastMsg(RoomModel room, MessageModel message) async {
    DocumentReference _documentReference =
        this._firestore.collection('rooms').doc(room.roomId);

    final TransactionHandler _transactionHandler = (Transaction tx) async {
      DocumentSnapshot _roomSnapshot = await tx.get(_documentReference);

      if (_roomSnapshot.exists) {
        RoomEntity roomEntity = RoomEntity.fromJson(
          _roomSnapshot.data(),
          _roomSnapshot.id,
        )..lastMessage = _messageWrapper.toEntity(message);

        tx.update(_documentReference, roomEntity.toObject());
      }
    };

    await this._firestore.runTransaction(_transactionHandler);
    return Future.value(true);
  }

  Future<bool> deleteMemberFromRoom(RoomModel room, UserModel user) async {
    UserEntity _userEntity = _userWrapper.toEntity(user);

    try {
      await this
          ._firestore
          .collection("rooms")
          .doc(room.roomId)
          .collection("members")
          .doc(_userEntity.userId)
          .delete();

      return Future.value(true);
    } catch (e) {
      print(e);
      return Future.value(false);
    }
  }

  Future<UserModel> registerUser(UserModel user) async {
    UserEntity _userEntity = _userWrapper.toEntity(user);

    await this
        ._firestore
        .collection('users')
        .doc(user.userId)
        .set(_userEntity.toObject());

    return Future.value(_userWrapper.toModel(_userEntity));
  }

  Future<bool> updateUser(UserModel user) async {
    DocumentReference _documentReference = this
        ._firestore
        .collection('users')
        .doc(user.userId);

    await this._firestore.runTransaction((Transaction tx) async {
      DocumentSnapshot _documentSnapshot = await tx.get(_documentReference);

      if (_documentSnapshot.exists) {
        UserEntity _userEntity = UserEntity.fromJson(_documentSnapshot.data());

        _userEntity = _userWrapper.toEntity(user);
        tx.update(_documentReference, _userEntity.toObject());
      }
    });

    return Future.value(true);
  }
}
