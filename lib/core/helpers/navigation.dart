import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vt_live_map/core/lang/lang.dart';

Future<bool> confirmCloseApplication(final BuildContext context) {
  return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(translate(Lang.APP_CONFIRM_CLOSE_TITLE)),
          content: Text(translate(Lang.APP_CONFIRM_CLOSE_CONTENT)),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(translate(Lang.APP_CONFIRM_CLOSE_NO)),
            ),
            FlatButton(
              onPressed: () => exit(0),
              child: Text(translate(Lang.APP_CONFIRM_CLOSE_YES)),
            ),
          ],
        ),
      ) ??
      false;
}
