import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnet/bloc/paint/paint_bloc.dart';
import 'package:magnet/models/magnet_item.dart';

import '../painter/my_custom_painter.dart';
import '../widgets/game_over_or_draw.dart';
import '../widgets/player_container.dart';

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
                        color: Colors.white,
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
                                } else if (state is GameDrawState) {
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
                const GameOverOrDrawWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
