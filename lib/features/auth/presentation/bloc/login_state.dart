part of 'login_bloc.dart';

// States of Login Screen
@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

//initial state of logiin screen
class LoginInitial extends LoginState {}

// loading state of login screen
class LoadingState extends LoginState {}

// state when login is success
class LoginSuccess extends LoginState {
  final UserEntity user;
  LoginSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

// login failed state
class LoginFailed extends LoginState {
  final String message;

  LoginFailed(this.message);
  @override
  List<Object> get props => [message];
}
