import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unlockd_assignment/core/error/failure.dart';
import 'package:unlockd_assignment/features/auth/data/models/user_model.dart';
import 'package:unlockd_assignment/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:unlockd_assignment/features/auth/domain/entity/user.dart';
import '../../../../../core/helpers/test_helpers.mocks.dart';

void main() {
  late MockAuthRemoteDataSource mockUserRemoteDataSource;
  late MockSecureStorage mockSecureStorage;
  late AuthRepositoryImp authRepositoryImp;
  const testUserModel = UserModel(userToken: "This_is_A_test_Token");
  const testUserEntity = UserEntity(userToken: "This_is_A_test_Token");
  const testUserName = "String";
  const testPassword = "String";
  const dummyTokken = "This_is_A_test_Token";
  setUp(
    () {
      mockUserRemoteDataSource = MockAuthRemoteDataSource();
      mockSecureStorage = MockSecureStorage();
      authRepositoryImp = AuthRepositoryImp(
          userRemoteDataSource: mockUserRemoteDataSource,
          secureStorage: mockSecureStorage);
    },
  );
  group(
    "loggin user",
    () {
      test(
        "should return user when remote data source is success",
        () async {
          // arrange
          when(mockUserRemoteDataSource.userLogin(testUserName, testPassword))
              .thenAnswer((_) async => testUserModel);

          //act

          final result =
              await authRepositoryImp.loginUser(testUserName, testPassword);

          //assert

          expect(result, equals(const Right(testUserEntity)));
        },
      );
      test(
        "should return Connection Failure",
        () async {
          // arrange
          when(mockUserRemoteDataSource.userLogin(testUserName, testPassword))
              .thenThrow(
                  const SocketException("Failed to connect to internet"));

          //act

          final result =
              await authRepositoryImp.loginUser(testUserName, testPassword);

          //assert

          expect(
              result,
              equals(const Left(
                  ConnectionFailure("Failed to connect to internet"))));
        },
      );
    },
  );

  group(
    " Logout user",
    () {
      test(
        "Should logout success",
        () async {
          // arrange
          when(mockSecureStorage.getToken())
              .thenAnswer((_) async => dummyTokken);
          when(mockUserRemoteDataSource.logOutUser(dummyTokken))
              .thenAnswer((_) async => true);

          //act

          final result = await authRepositoryImp.logOut();

          //assert

          expect(result, equals(const Right(true)));
        },
      );
      test(
        "should return Connection Failure",
        () async {
          // arrange
          when(mockUserRemoteDataSource.userLogin(testUserName, testPassword))
              .thenThrow(
                  const SocketException("Failed to connect to internet"));

          //act

          final result =
              await authRepositoryImp.loginUser(testUserName, testPassword);

          //assert

          expect(
              result,
              equals(const Left(
                  ConnectionFailure("Failed to connect to internet"))));
        },
      );
    },
  );
}
