import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/paint/paint_bloc.dart';

class GameOverOrDrawWidget extends StatelessWidget {
  const GameOverOrDrawWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isVisible = false;
    bool isGameDraw = false;
    final bloc = BlocProvider.of<PaintBloc>(context);
    return BlocBuilder<PaintBloc, PaintState>(
      builder: (context, state) {
        isGameDraw = (state is GameDrawState);
        isVisible = (state is GameOverState || isGameDraw);
        return Visibility(
          visible: isVisible,
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
                  Text(
                    isGameDraw ? "Game Drawed" : "Game Over",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isGameDraw
                        ? ""
                        : "${bloc.currentPlayer.name.toLowerCase()} won the game",
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
