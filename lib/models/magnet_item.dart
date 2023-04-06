import 'package:flutter/rendering.dart';

import '../core/enums/player_enum.dart';

class MagnetItem {
  final Offset offset;
  Player? player;

  MagnetItem({required this.offset, this.player});
}
