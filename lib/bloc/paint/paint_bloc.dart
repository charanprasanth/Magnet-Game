import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:magnet/models/magnet_item.dart';
part 'paint_event.dart';
part 'paint_state.dart';

class PaintBloc extends Bloc<PaintEvent, PaintState> {
  PaintBloc() : super(PaintInitial()) {
    on<AddNewMagnet>(checkAndAddNewPoint);
  }

  List<MagnetItem> magnets = [];

  void checkAndAddNewPoint(AddNewMagnet event, Emitter<PaintState> emitter) {
    bool isLost = false;
    double dx = event.magnetItem.offset.dx;
    double dy = event.magnetItem.offset.dy;
    for (int i = 0; i < magnets.length; i++) {
      double x = magnets[i].offset.dx;
      double y = magnets[i].offset.dy;

      double diffX = dx - x;
      double diffY = dy - y;
      if (diffX.abs() <= 60 && diffY.abs() <= 60) {
        isLost = true;
        break;
      }
    }
    magnets.add(event.magnetItem);
    emitter.call(AddMagnetState(magnets));
    if (isLost) {
      magnets.clear();
      emitter.call(GameOverState(event.magnetItem));
    }
  }
}
