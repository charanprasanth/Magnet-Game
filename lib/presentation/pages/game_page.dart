import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnet/bloc/paint/paint_bloc.dart';
import 'package:magnet/core/enums/player_enum.dart';
import 'package:magnet/models/magnet_item.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  void showWinningDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Card(
            color: Colors.transparent,
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                height: 100.0,
                width: 300.0,
                child: ListTile(
                  title: const Text("Player 1 won the game"),
                  subtitle: Align(
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.green,
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Text("Close"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PaintBloc>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue),
      bottomNavigationBar: Container(color: Colors.red, height: 60.0),
      body: Container(
        color: Colors.yellow,
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            BlocBuilder<PaintBloc, PaintState>(
              builder: (context, state) {
                if (state is AddMagnetState) {
                  return CustomPaint(
                    painter: MyCustomPainter(bloc.magnets),
                  );
                } else if (state is GameOverState) {
                  // showWinningDialog(context);
                  return CustomPaint(
                    painter: MyCustomPainter(bloc.magnets),
                  );
                } else {
                  return CustomPaint(
                    painter: MyCustomPainter(bloc.magnets),
                  );
                }
              },
            ),
            GestureDetector(
              onTapDown: (details) {
                double dx = details.localPosition.dx;
                double dy = details.localPosition.dy;
                bloc.add(
                  AddNewMagnet(MagnetItem(Offset(dx, dy), Player.PLAYER1)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final List<MagnetItem> magnets;

  MyCustomPainter(this.magnets);

  @override
  void paint(Canvas canvas, Size size) {
    for (MagnetItem magnet in magnets) {
      Offset offset = magnet.offset;
      Color color =
          (magnet.player == Player.PLAYER1) ? Colors.red : Colors.blue;
      canvas.drawRect(
        Rect.fromCircle(center: offset, radius: 20),
        Paint()..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return true;
  }
}
