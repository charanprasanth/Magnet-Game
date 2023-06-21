import 'package:flutter/material.dart';

import '../../core/enums/player_enum.dart';
import '../../models/magnet_item.dart';

class MyCustomPainter extends CustomPainter {
  final List<MagnetItem> magnets;

  MyCustomPainter(this.magnets);

  @override
  void paint(Canvas canvas, Size size) {
    for (MagnetItem magnet in magnets) {
      Offset offset = magnet.offset;
      Color color =
          (magnet.player == Player.PLAYER1) ? Colors.red : Colors.blue;
      Paint paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 15;
      Paint attractionPaint = Paint()
        ..color = Colors.green.shade200.withAlpha(100)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 30;
      canvas.drawCircle(offset, 30, paint);
      canvas.drawCircle(offset, 45, attractionPaint);
    }
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return true;
  }
}