import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vt_live_map/core/lang/lang.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(translate(Lang.APP_NAME)),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/appbar_header.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
              color: Color(0xff009ddb),
            ),
          ),
          ListTile(
            title: Text(translate(Lang.APP_VIEW_TRIP)),
            onTap: () => null,
          ),
          ListTile(
            title: Text(translate(Lang.APP_VIEW_NEARBY)),
            onTap: () => Navigator.of(context).pushReplacementNamed('/nearby'),
          ),
          ListTile(
            title: Text(translate(Lang.APP_VIEW_LIVE_MAP)),
            onTap: () => Navigator.of(context).pushReplacementNamed('/liveMap'),
          ),
          ListTile(
            title: Text(translate(Lang.APP_VIEW_ARRIVALS)),
            onTap: () => null,
          ),
          ListTile(
            title: Text(translate(Lang.APP_VIEW_DEPARTURES)),
            onTap: () => null,
          ),
          ListTile(
            title: Text(translate(Lang.APP_VIEW_SYSTEM_INFO)),
            onTap: () => null,
          ),
          ListTile(
            title: Text(translate(Lang.APP_VIEW_SETTINGS)),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed('/settings'),
          ),
        ],
      ),
    );
  }
}
