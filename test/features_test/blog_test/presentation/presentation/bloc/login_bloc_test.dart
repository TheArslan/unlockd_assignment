import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unlockd_assignment/core/error/failure.dart';

import 'package:unlockd_assignment/features/auth/domain/entity/user.dart';
import 'package:unlockd_assignment/features/auth/presentation/bloc/login_bloc.dart';

import '../../../../../core/helpers/test_helpers.mocks.dart';

void main() {
  late MockLoginUser mockLoginUser;
  late LoginBloc loginBloc;

  const testUserEntity = UserEntity(userToken: "This_is_A_test_Token");
  const testUserName = "String";
  const testPassword = "String";
  setUp(
    () {
      mockLoginUser = MockLoginUser();
      loginBloc = LoginBloc(mockLoginUser);
    },
  );

  test(
    "Initial State",
    () {
      expect(loginBloc.state, LoginInitial());
    },
  );
  blocTest<LoginBloc, LoginState>("should emit [Loading State,LogginSuccess]",
      build: () {
        when(mockLoginUser.execute(testUserName, testPassword)).thenAnswer(
          (_) async => const Right(testUserEntity),
        );
        return loginBloc;
      },
      act: (bloc) => bloc.add(const OnLoginButtonPressed(
          username: testUserName, password: testPassword)),
      expect: () => [LoadingState(), LoginSuccess(user: testUserEntity)]);

  blocTest<LoginBloc, LoginState>("should emit [Loading State,Loggin Failed]",
      build: () {
        when(mockLoginUser.execute(testUserName, testPassword)).thenAnswer(
          (_) async => const Left(ServerFailure("Server failure")),
        );
        return loginBloc;
      },
      act: (bloc) => bloc.add(const OnLoginButtonPressed(
          username: testUserName, password: testPassword)),
      expect: () => [LoadingState(), LoginFailed("Server failure")]);
}
