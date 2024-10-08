import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unlockd_assignment/features/auth/domain/entity/user.dart';
import 'package:unlockd_assignment/features/auth/domain/usecases/login_user.dart';

part 'login_state.dart';
part 'login_event.dart';

// bloc of Login Screen to handle states
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser _loginUser;
  LoginBloc(this._loginUser) : super(LoginInitial()) {
    // handle OnLoginButtonPressed event
    on<OnLoginButtonPressed>(
      (event, emit) async {
        // emit loading state
        emit(LoadingState());
        //login user
        final result = await _loginUser.execute(event.username, event.password);
        // check response either failure or success
        result.fold(
          (failure) {
            // if response is failes emit LogouFailed with error  message
            emit(LoginFailed(failure.message));
          },
          // if response is sucees emit LogOutSuccess with true value
          (result) {
            emit(LoginSuccess(user: result));
          },
        );
      },
    );
  }
}
