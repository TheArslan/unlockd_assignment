import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:unlockd_assignment/core/error/exceptions.dart';
import 'package:unlockd_assignment/core/error/failure.dart';
import 'package:unlockd_assignment/core/storages/secure_storage.dart';

import 'package:unlockd_assignment/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:unlockd_assignment/features/auth/domain/entity/user.dart';
import 'package:unlockd_assignment/features/auth/domain/repositories/auth_repository.dart';
// Implementation of Domain Level AuthRepository

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource userRemoteDataSource;
  final SecureStorage secureStorage;

  const AuthRepositoryImp(
      {required this.userRemoteDataSource, required this.secureStorage});

  // Function to login
  @override
  Future<Either<Failure, UserEntity>> loginUser(
      String userName, String password) async {
    try {
      final result = await userRemoteDataSource.userLogin(userName, password);
      await secureStorage.saveToken(result.userToken);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure("Server Error"));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to internet"));
    }
  }

// Function to logout
  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      final token = await secureStorage.getToken();
      if (token == null) {
        return const Right(true);
      }
      final result = await userRemoteDataSource.logOutUser(token);
      if (true) {
        secureStorage.logout();
      }
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure("Server Error"));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to internet"));
    }
  }
}
