part of 'init_bloc.dart';

@immutable
abstract class InitEvent {}

class SetDefaultSettingsEvent extends InitEvent {}

class StartInitEvent extends InitEvent {}

class FinishedInitEvent extends InitEvent {}

class ErrorInitEvent extends InitEvent {}
