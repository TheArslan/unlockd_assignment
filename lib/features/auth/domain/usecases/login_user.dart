import 'package:dartz/dartz.dart';
import 'package:unlockd_assignment/core/error/failure.dart';
import 'package:unlockd_assignment/features/auth/domain/entity/user.dart';
import 'package:unlockd_assignment/features/auth/domain/repositories/auth_repository.dart';

// UseCase to login user
class LoginUser {
  final AuthRepository _loginRepository;
  LoginUser(this._loginRepository);
  Future<Either<Failure, UserEntity>> execute(
      String userName, String password) {
    return _loginRepository.loginUser(userName, password);
  }
}
