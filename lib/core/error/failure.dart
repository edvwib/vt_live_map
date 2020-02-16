import 'package:equatable/equatable.dart';

const SERVER_FAILURE_MESSAGE = "The Server failed";
const NETWORK_FAILURE_MESSAGE = "Network not available";
const CACHE_FAILURE_MESSAGE = "Getting/Retriving an item from Cache failed";
const ERROR_UNKNOWN = "Unexpected Error Occured";
const UNAUTHORIZED_FAILURE_MESSAGE = "Unauthorized";

abstract class Failure extends Equatable {
  final List<dynamic> properties;
  Failure([this.properties]) : super();

  @override
  List<Object> get props => [this.properties];
}

class ServerFailure extends Failure{}

class NetworkFailure extends Failure{}

class CachedFailure extends Failure{}

class UnknownFailure extends Failure{}

class UnauthorizedFailure extends Failure{}


mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CachedFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return ERROR_UNKNOWN;
  }
}
