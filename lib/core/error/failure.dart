import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  Failure({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  CacheFailure({required super.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}
