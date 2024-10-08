part of 'login_bloc.dart';

// events of Login screen
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

// event to login user
class OnLoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  const OnLoginButtonPressed({required this.username, required this.password});
  @override
  List<Object?> get props => [username, password];
}
