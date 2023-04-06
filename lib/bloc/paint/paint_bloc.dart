import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:magnet/core/enums/player_enum.dart';
import 'package:magnet/models/magnet_item.dart';
part 'paint_event.dart';
part 'paint_state.dart';

class PaintBloc extends Bloc<PaintEvent, PaintState> {
  PaintBloc() : super(PaintInitial()) {
    on<AddNewMagnet>(checkAndAddNewPoint);
    on<StartNewGame>(startNewGame);
  }

  var currentPlayer = Player.PLAYER2;
  final List<MagnetItem> magnets = [];

  FutureOr<void> checkAndAddNewPoint(
      AddNewMagnet event, Emitter<PaintState> emit) {
    currentPlayer =
        (currentPlayer == Player.PLAYER1) ? Player.PLAYER2 : Player.PLAYER1;
    bool isLost = false;
    double dx = event.magnetItem.offset.dx;
    double dy = event.magnetItem.offset.dy;
    for (int i = 0; i < magnets.length; i++) {
      double x = magnets[i].offset.dx;
      double y = magnets[i].offset.dy;

      double diffX = dx - x;
      double diffY = dy - y;
      if (magnets[i].player != currentPlayer &&
          diffX.abs() <= 60 &&
          diffY.abs() <= 60) {
        isLost = true;
        break;
      }
    }
    event.magnetItem.player = currentPlayer;
    magnets.add(event.magnetItem);
    emit.call(AddMagnetState(magnets));
    if (isLost) {
      magnets.clear();
      emit.call(GameOverState(event.magnetItem));
    }
  }

  FutureOr<void> startNewGame(StartNewGame event, Emitter<PaintState> emit) {
    emit.call(NewGameState());
  }
}
