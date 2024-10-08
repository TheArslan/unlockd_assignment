import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:unlockd_assignment/features/auth/data/models/user_model.dart';
import 'package:unlockd_assignment/features/auth/domain/entity/user.dart';

import '../../../../../core/helpers/helper_functions.dart';

void main() {
  const testUserModel = UserModel(userToken: "This_is_A_test_Token");
  test(
    "should be subclass of user entity ",
    () {
      //assert
      expect(testUserModel, isA<UserEntity>());
    },
  );

  test(
    "should return a valid model from json",
    () {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson("core/dummy_data/dummy_user_response.json"));
      //act

      final result = UserModel.fromJson(jsonMap);
      //assert
      expect(result, equals(testUserModel));
    },
  );

  test(
    "should return a valid json from model;",
    () {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson("core/dummy_data/dummy_user_response.json"));
      //act

      final result = testUserModel.toJson();
      //assert
      expect(result, equals(jsonMap));
    },
  );
}
