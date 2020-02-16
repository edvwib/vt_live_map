import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vt_live_map/core/app_menu/presentation/app_menu.dart';
import 'package:vt_live_map/core/application/presentation/pages/app_init.dart';
import 'package:vt_live_map/features/live_map/presentation/pages/live_map_page.dart';

class VTLiveMap extends StatefulWidget {
  @override
  _VTLiveMapState createState() => _VTLiveMapState();
}

class _VTLiveMapState extends State<VTLiveMap> {
  LocalizationDelegate localizationDelegate;

  @override
  void initState() {
    localizationDelegate = LocalizedApp.of(context).delegate;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VTLiveMap',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        localizationDelegate,
      ],
      localeResolutionCallback:
          (Locale deviceLocale, Iterable<Locale> supportedLocales) {
        // Todo check if deviceLocale is supported
        localizationDelegate.changeLocale(deviceLocale);
        return deviceLocale;
      },
      supportedLocales: localizationDelegate.supportedLocales,
      locale: localizationDelegate.currentLocale,
      initialRoute: '/init',
      routes: {
        '/init': (context) => AppInit(),
        '/menu': (context) => AppMenu(),
        '/liveMap': (context) => LiveMapPage(),
      },
    );
  }
}
