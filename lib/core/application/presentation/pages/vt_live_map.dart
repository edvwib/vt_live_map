import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:vt_live_map/core/about/presentation/pages/about_page.dart';
import 'package:vt_live_map/core/application/presentation/pages/app_init.dart';
import 'package:vt_live_map/core/settings/presentation/pages/settings_page.dart';
import 'package:vt_live_map/features/live_map/presentation/pages/live_map_page.dart';
import 'package:vt_live_map/features/location/presentation/pages/nearby_page.dart';

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
        Intl.defaultLocale =
            '${deviceLocale.countryCode}_${deviceLocale.languageCode}';
        return deviceLocale;
      },
      supportedLocales: localizationDelegate.supportedLocales,
      locale: localizationDelegate.currentLocale,
      initialRoute: '/init',
      routes: {
        '/init': (final BuildContext context) => AppInit(),
        '/settings': (final BuildContext context) => SettingsPage(),
        '/about': (final BuildContext context) => AboutPage(),
        '/liveMap': (final BuildContext context) => LiveMapPage(),
        '/nearby': (final BuildContext context) => NearbyPage(),
      },
    );
  }
}
