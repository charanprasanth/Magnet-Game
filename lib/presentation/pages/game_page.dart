import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnet/bloc/paint/paint_bloc.dart';
import 'package:magnet/core/enums/player_enum.dart';
import 'package:magnet/models/magnet_item.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PaintBloc>(context);
    return Scaffold(
      body: BlocBuilder<PaintBloc, PaintState>(
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    const PlayerContainer(),
                    Expanded(
                      child: Container(
                        color: Colors.yellow,
                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          children: [
                            BlocBuilder<PaintBloc, PaintState>(
                              builder: (context, state) {
                                if (state is AddMagnetState) {
                                  return CustomPaint(
                                    painter: MyCustomPainter(state.magnets),
                                  );
                                } else if (state is GameOverState) {
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
                                  AddNewMagnet(
                                      MagnetItem(offset: Offset(dx, dy))),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const PlayerContainer(),
                  ],
                ),
                const GameOverWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isGameOver = false;
    final bloc = BlocProvider.of<PaintBloc>(context);
    return BlocBuilder<PaintBloc, PaintState>(
      builder: (context, state) {
        if (state is GameOverState) {
          isGameOver = true;
        } else {
          isGameOver = false;
        }
        return Visibility(
          visible: isGameOver,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade300.withOpacity(0.8),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Game Over",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${bloc.currentPlayer.name.toLowerCase()} won the game",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => bloc.add(StartNewGame()),
                    child: const Text(
                      "Exit",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PlayerContainer extends StatelessWidget {
  const PlayerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PaintBloc>(context);
    return BlocBuilder<PaintBloc, PaintState>(
      bloc: bloc,
      builder: (context, state) {
        bool isPlayer1 = (bloc.currentPlayer == Player.PLAYER1);
        return Container(
          height: 60,
          decoration: BoxDecoration(
            color: isPlayer1 ? Colors.blue : Colors.red,
          ),
          child: Center(
            child: Text(
              isPlayer1 ? "PLAYER 1" : "PLAYER 2",
              style: const TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
        );
      },
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
      Paint paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 15;
      canvas.drawCircle(offset, 30, paint);
    }
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return true;
  }
}
