import 'package:dartz/dartz.dart';
import 'package:unlockd_assignment/core/error/failure.dart';

import 'package:unlockd_assignment/features/auth/domain/repositories/auth_repository.dart';

// UseCase to logout user
class LogOutUser {
  final AuthRepository _authRepository;
  LogOutUser(this._authRepository);
  Future<Either<Failure, bool>> execute() {
    return _authRepository.logOut();
  }
}
