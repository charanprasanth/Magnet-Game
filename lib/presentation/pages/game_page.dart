import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<Offset> points = [const Offset(0, 0)];

  void onUserTappedDown(TapDownDetails details) {
    bool isLost = false;
    double dx = details.localPosition.dx;
    double dy = details.localPosition.dy;

    for (int i = 0; i < points.length; i++) {
      double x = points[i].dx;
      double y = points[i].dy;

      double diffX = dx - x;
      double diffY = dy - y;
      if (diffX.abs() <= 60 && diffY.abs() <= 60) {
        isLost = true;
        break;
      }
    }

    setState(() => points.add(Offset(dx, dy)));

    if(isLost) {
      showWinningDialog();
    }
  }

  void showWinningDialog() {
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
                        setState(() => points.clear());
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
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue),
      bottomNavigationBar: Container(color: Colors.red, height: 60.0),
      body: Container(
        color: Colors.yellow,
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            CustomPaint(
              painter: MyCustomPainter(points),
            ),
            GestureDetector(
              onTapDown: (details) {
                onUserTappedDown(details);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final List<Offset> points;

  MyCustomPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    for (Offset offset in points) {
      canvas.drawRect(Rect.fromCircle(center: offset, radius: 20),
          Paint()..color = Colors.black);
    }
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return true;
  }
}
