import 'package:unlockd_assignment/features/auth/domain/entity/user.dart';

// Model class of User Entity

class UserModel extends UserEntity {
  const UserModel({required super.userToken});
  // Factory constructor to create a User from a JSON object
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(userToken: json["token"]);

  // Convert User instance to JSON object
  Map<String, dynamic> toJson() => {"token": userToken};

  // Convert User instance to entity
  UserEntity toEntity() => UserEntity(userToken: userToken);
}
