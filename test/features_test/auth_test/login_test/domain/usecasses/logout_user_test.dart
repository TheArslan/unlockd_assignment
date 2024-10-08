import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:unlockd_assignment/features/auth/domain/usecases/logout_user.dart';

import '../../../../../core/helpers/test_helpers.mocks.dart';

void main() {
  late LogOutUser logOutUser;
  late MockSecureStorage mockSecureStorage;
  late MockAuthRepository mockLoginRepository;

  const dummyTokken = "This_is_A_test_Token";

  setUp(
    () {
      mockLoginRepository = MockAuthRepository();
      mockSecureStorage = MockSecureStorage();
      logOutUser = LogOutUser(mockLoginRepository);
    },
  );
  test(
    "should login user and fetch token",
    () async {
      //arrange
      when(mockSecureStorage.getToken()).thenAnswer((_) async => dummyTokken);
      when(mockLoginRepository.logOut()).thenAnswer(
        (_) async => const Right(true),
      );

      //act
      final result = await logOutUser.execute();

      //assert
      expect(result, const Right(true));
    },
  );
}
