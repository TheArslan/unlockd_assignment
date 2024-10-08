import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unlockd_assignment/features/auth/domain/entity/user.dart';
import 'package:unlockd_assignment/features/auth/domain/usecases/login_user.dart';

import '../../../../../core/helpers/test_helpers.mocks.dart';

void main() {
  late LoginUser loginUser;
  late MockAuthRepository mockLoginRepository;
  const testUserName = "String";
  const testPassword = "String";

  const testUserDetail = UserEntity(userToken: "This_is_A_test_Token");
  setUp(
    () {
      mockLoginRepository = MockAuthRepository();
      loginUser = LoginUser(mockLoginRepository);
    },
  );
  test(
    "should login user and fetch token",
    () async {
      //arrange
      when(mockLoginRepository.loginUser(testUserName, testPassword))
          .thenAnswer(
        (_) async => const Right(testUserDetail),
      );

      //act
      final result = await loginUser.execute(testUserName, testPassword);

      //assert
      expect(result, const Right(testUserDetail));
    },
  );
}
