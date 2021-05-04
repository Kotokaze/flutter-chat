import 'package:chat/infrastructure/models/user_model.dart';
import 'package:chat/infrastructure/entities/user_entity.dart';

class UserWrapper {
  UserEntity toEntity(UserModel user) {
    return UserEntity(
      userId: user.userId,
      userName: user.userName,
      email: user.email,
      photoUrl: user.photoUrl != null ? user.photoUrl.toString() : null,
    );
  }

  UserModel toModel(UserEntity userEntity) {
    return UserModel(userEntity.userId, userEntity.userName, userEntity.email, userEntity.photoUrl);
  }

  List<UserModel> toModelList(List<UserEntity> userEntityList) {
    return userEntityList.map((userEntity) => toModel(userEntity)).toList();
  }
}
