part of 'settings_bloc.dart';

@immutable
abstract class SettingsState extends Equatable {
  final List<dynamic> properties;

  SettingsState([this.properties]);

  @override
  List<Object> get props => properties;
}

class Empty extends SettingsState {}

class HasError extends SettingsState {}
