import 'package:dartz/dartz.dart';
import 'package:unlockd_assignment/core/error/failure.dart';
import 'package:unlockd_assignment/features/auth/domain/entity/user.dart';

// Auth Repository to just define function
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> loginUser(
      String userName, String password);
  Future<Either<Failure, bool>> logOut();
}
