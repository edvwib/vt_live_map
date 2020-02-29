import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vt_live_map/core/app_drawer/presentation/app_drawer.dart';
import 'package:vt_live_map/core/lang/lang.dart';
import 'package:vt_live_map/core/settings/presentation/bloc/settings_bloc.dart';
import 'package:vt_live_map/injection_container.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                title: Text(translate(Lang.APP_VIEW_ABOUT_TITLE)),
                subtitle: Text(translate(Lang.APP_VIEW_ABOUT_SUBTITLE)),
                onTap: () => Navigator.of(context).pushNamed("/about"),
              ),
            ],
          );
        },
      ),
    );
  }
}
