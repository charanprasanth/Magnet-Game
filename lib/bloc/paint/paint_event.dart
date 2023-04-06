part of 'paint_bloc.dart';

@immutable
abstract class PaintEvent {}

class AddNewMagnet extends PaintEvent {
  final MagnetItem magnetItem;

  AddNewMagnet(this.magnetItem);
}

class StartNewGame extends PaintEvent {}