import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnet/bloc/paint/paint_bloc.dart';
import 'package:magnet/presentation/pages/game_page.dart';

void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => const MyApp(), // Wrap your app
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PaintBloc())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GamePage(),
      ),
    );
  }
}