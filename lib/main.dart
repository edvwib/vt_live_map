import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vt_live_map/core/application/data/data_sources/app_init_local_data_source.dart';
import 'package:vt_live_map/core/application/presentation/pages/vt_live_map.dart';
import 'package:vt_live_map/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  final Locale fallback = AppInitLocalDataSource.fallbackLocale;
  final delegate = await LocalizationDelegate.create(
    fallbackLocale: '${fallback.languageCode}_${fallback.countryCode}',
    supportedLocales: ['en_US', 'sv_SE'],
  );

  runApp(LocalizedApp(
    delegate,
    VTLiveMap(),
  ));
}
