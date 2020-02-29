import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:package_info/package_info.dart';
import 'package:vt_live_map/core/helpers/url.dart';
import 'package:vt_live_map/core/lang/lang.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String appVersion = '';

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((final PackageInfo packageInfo) {
      this.setState(() {
        appVersion = packageInfo.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate(Lang.APP_VIEW_ABOUT_TITLE)),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(translate(Lang.APP_VIEW_ABOUT_APP_VERSION)),
            subtitle: Text(appVersion),
            onTap: () => null,
          ),
          ListTile(
            title: Text(translate(Lang.APP_VIEW_ABOUT_MENU_IMAGE_TITLE)),
            subtitle: Text(translate(Lang.APP_VIEW_ABOUT_MENU_IMAGE_SUBTITLE)
                .replaceFirst("%s", "Jonas Jacobsson")),
            onTap: () => tryOpenURL(
                'https://unsplash.com/@jonasjacobsson?utm_medium=referral&utm_campaign=photographer-credit'),
          ),
        ],
      ),
    );
  }
}
