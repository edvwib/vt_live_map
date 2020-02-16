import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vt_live_map/core/application/domain/use_cases/set_defaults.dart';
import 'package:vt_live_map/core/error/failure.dart';

part 'init_event.dart';
part 'init_state.dart';

class InitBloc extends Bloc<InitEvent, InitState> {
  final SetDefaults setDefaults;

  InitBloc({
    @required this.setDefaults,
  }) : assert(setDefaults != null);

  @override
  InitState get initialState => Empty();

  @override
  Stream<InitState> mapEventToState(InitEvent event) async* {
    if (event is StartInitEvent) {
      yield InProgress();
      add(SetDefaultSettingsEvent());
    } else if (event is SetDefaultSettingsEvent) {
      await setDefaults();
      add(FinishedInitEvent());
    } else if (event is FinishedInitEvent) {
      yield Finished();
    } else if (event is ErrorInitEvent) {
      yield HasError();
    }
  }

  Stream<InitState> _savedOrFailed(Either<Failure, dynamic> result) async* {
    yield result.fold((failure) => HasError(), (success) => InProgress());
  }
}
