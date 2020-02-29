import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vt_live_map/features/live_map/domain/entities/vehicle.dart';

class VehicleIcon {
  static Map<String, BitmapDescriptor> icons = Map();

  static Future<BitmapDescriptor> create(Vehicle vehicle) async {
    final String name = vehicle.getName();
    if (icons.containsKey(name)) {
      return icons[name];
    }

    String line = vehicle.getLine();
    if (line.contains("express")) line = line.split(" ").first;

    final String text = line;

    final Paint paint = Paint();
    paint.color = vehicle.lineColor;
    paint.style = PaintingStyle.fill;

    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);

    TextSpan span = TextSpan(
      text: text,
      style: TextStyle(
        color: vehicle.backgroundColor,
        fontSize: 40,
        fontFamily: 'Arial',
      ),
    );

    final TextPainter textPainter = TextPainter(
      maxLines: 1,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      text: span,
    );
    textPainter.layout();

    final double minHeight = 60;
    final double minWidth = 60;
    final double width =
        textPainter.width <= minWidth ? minWidth : textPainter.width;
    final double height =
        textPainter.height <= minHeight ? minHeight : textPainter.height;
    final double offsetHorizontal =
        textPainter.width < minWidth ? (minWidth - textPainter.width) / 2 : 0;
    final double offsetVertical = textPainter.height < minHeight
        ? (minHeight - textPainter.height) / 2
        : 0;

    canvas.drawRRect(
      RRect.fromLTRBR(0, height, width, 0, Radius.circular(5)),
      paint,
    );
    textPainter.paint(canvas, Offset(offsetHorizontal, offsetVertical));

    /* // Draws direction arrow
    Path path = Path();
    path.moveTo(width / 2, height / 2);
    path.lineTo((width / 2) + 15, (height / 2) + 20);
    path.lineTo((width / 2) - 15, (height / 2) + 20);
    path.lineTo(width / 2, height / 2);
    path.close();
    final Paint newPaint = Paint();
    newPaint.style = PaintingStyle.stroke;
    newPaint.strokeWidth = 2.0;
    newPaint.color = Colors.black;
    final double r = sqrt(pow(width, 2) + pow(height, 2)) / 2;
    final alpha = atan(height / width);
    final beta = alpha + vehicle.direction * (pi / 180);
    final shiftY = r * sin(beta);
    final shiftX = r * cos(beta);
    final translateX = width / 2 - shiftX;
    final translateY = height / 2 - shiftY;
    canvas.translate(translateX, translateY);
    canvas.rotate(vehicle.direction * (pi / 180));
    canvas.drawPath(path, newPaint);
    */

    final Image image =
        await recorder.endRecording().toImage(width.toInt(), height.toInt());
    final ByteData bytedata =
        await image.toByteData(format: ImageByteFormat.png);
    final Uint8List bytes = bytedata.buffer.asUint8List();
    return icons.putIfAbsent(name, () => BitmapDescriptor.fromBytes(bytes));
  }
}
