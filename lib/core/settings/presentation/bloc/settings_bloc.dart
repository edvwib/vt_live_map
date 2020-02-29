import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vt_live_map/core/settings/domain/use_cases/manage_settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ManageSettings manageSettings;

  SettingsBloc({
    @required this.manageSettings,
  }) : assert(manageSettings != null);

  @override
  SettingsState get initialState => Empty();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is ErrorSettingsEvent) {
      yield HasError();
    }
  }
}
