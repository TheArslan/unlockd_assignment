import 'package:equatable/equatable.dart';

// Different types of failures

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

// Failure emitt when there is status code other than 200

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// Failure emit when there is socket exception in app

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}


// Note: we can more sub failures