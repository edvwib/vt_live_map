import 'package:url_launcher/url_launcher.dart';

tryOpenURL(final String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}
