part of 'init_bloc.dart';

@immutable
abstract class InitState extends Equatable {
  final List<dynamic> properties;

  InitState([this.properties]);

  @override
  List<Object> get props => properties;
}

class Empty extends InitState {}

class InProgress extends InitState {}

class Update extends InitState {
  Update(String flavorText, bool success) : super([success, flavorText]);
}

class Finished extends InitState {}

class HasError extends InitState {}
