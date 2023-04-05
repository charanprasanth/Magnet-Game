part of 'paint_bloc.dart';

@immutable
abstract class PaintState {}

class PaintInitial extends PaintState {}

class AddMagnetState extends PaintState {
  final List<MagnetItem> magnets;

  AddMagnetState(this.magnets);
}

class GameOverState extends PaintState {
  final MagnetItem magnetItem;

  GameOverState(this.magnetItem);
}
