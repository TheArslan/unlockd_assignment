import 'package:equatable/equatable.dart';

// User Entity class
class UserEntity extends Equatable {
  final String userToken;
  const UserEntity({required this.userToken});

  @override
  List<Object?> get props => [userToken];
}
