import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vt_live_map/core/app_drawer/presentation/app_drawer.dart';
import 'package:vt_live_map/core/lang/lang.dart';
import 'package:vt_live_map/core/settings/presentation/bloc/settings_bloc.dart';
import 'package:vt_live_map/injection_container.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsBloc _bloc;

  @override
  void initState() {
    _bloc = sl<SettingsBloc>();

    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate(Lang.APP_VIEW_SETTINGS)),
      ),
      drawer: AppDrawer(),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        bloc: _bloc,
        builder: (BuildContext context, SettingsState state) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text("This is a ListPreference"),
                subtitle: Text("Subtitle goes here"),
                onTap: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}
