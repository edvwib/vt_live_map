import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vt_live_map/core/application/presentation/bloc/init_bloc.dart';
import 'package:vt_live_map/injection_container.dart';

class AppInit extends StatefulWidget {
  @override
  _AppInitState createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> {
  InitBloc _bloc;

  @override
  void initState() {
    _bloc = sl<InitBloc>();

    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }

  void _reRouteIfFinished() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/menu');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InitBloc, InitState>(
        bloc: _bloc,
        builder: (BuildContext context, InitState state) {
          if (state is Empty) {
            _bloc.add(
              StartInitEvent(),
            );
            return SizedBox();
          } else if (state is Finished) {
            _reRouteIfFinished();
            return Waiting();
          } else if (state is InProgress) {
            return Waiting();
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}

class Waiting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
