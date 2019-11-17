import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as prefix0;
import 'package:flutter/painting.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart';
import 'package:vt_live_map/vt/vehicles/vehicle.dart';

class Icon {
  static Map<String, BitmapDescriptor> icons = Map();

  static Future<BitmapDescriptor> create(Vehicle vehicle) async {
    final String name = vehicle.name;
    String line = vehicle.getLine();
    if (line.contains("express")) line = line.split(" ").first;

    final String text = line;

    if (icons.containsKey(name)) {
      return icons[name];
    }

    final Paint paint = Paint();
    paint.color = vehicle.lColor;
    paint.style = PaintingStyle.fill;

    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);

    TextSpan span = TextSpan(
        text: text,
        style: TextStyle(
            color: vehicle.bColor, fontSize: 40, fontFamily: 'Arial'));

    TextPainter textPainter = TextPainter(
        maxLines: 1,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        text: span);
    textPainter.layout();

    final double width = textPainter.width < 50 ? 50 : textPainter.width;
    final double height = textPainter.height < 50 ? 50 : textPainter.height;
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(width / 2, height / 2),
            width: width,
            height: height),
        paint);

    textPainter.paint(canvas, Offset(0, 2.5));

    var image =
        await recorder.endRecording().toImage(width.toInt(), height.toInt());
    var bytedata = await image.toByteData(format: ImageByteFormat.png);
    Uint8List bytes = bytedata.buffer.asUint8List();
    return icons.putIfAbsent(name, () => BitmapDescriptor.fromBytes(bytes));
  }
}
