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
  final List<MagnetItem> player1Magnets = [];
  final List<MagnetItem> player2Magnets = [];

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
          diffX.abs() <= 80 &&
          diffY.abs() <= 80) {
        isLost = true;
        break;
      }
    }
    event.magnetItem.player = currentPlayer;
    magnets.add(event.magnetItem);
    emit.call(AddMagnetState(magnets));
    if (isLost) {
      checkIsLost(event, emit);
      emit.call(GameOverState(event.magnetItem));
    }
  }

  FutureOr<void> startNewGame(StartNewGame event, Emitter<PaintState> emit) {
    magnets.clear();
    emit.call(NewGameState());
  }

  FutureOr<void> checkIsLost(
      AddNewMagnet event, Emitter<PaintState> emit) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    emit.call(GameOverState(event.magnetItem));
  }
}
