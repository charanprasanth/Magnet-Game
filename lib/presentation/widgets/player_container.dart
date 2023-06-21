import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/paint/paint_bloc.dart';

class PlayerContainer extends StatelessWidget {
  const PlayerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PaintBloc>(context);
    return BlocBuilder<PaintBloc, PaintState>(
      bloc: bloc,
      builder: (context, state) {
        int magnetsLeft = bloc.getMagnetsLeft();
        return Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            color: bloc.isPlayer1() ? Colors.blue : Colors.red,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bloc.isPlayer1() ? "PLAYER 1" : "PLAYER 2",
                style: const TextStyle(color: Colors.white, fontSize: 30.0),
              ),
              Text(
                "Magnets left: $magnetsLeft",
                style: const TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
