import 'package:flutter/material.dart';
import 'package:kharazan/controllers/animations_manager.dart';
import 'package:kharazan/controllers/match_mannager.dart';
import 'package:kharazan/controllers/piece_manager.dart';
import 'package:kharazan/screens/match_screen/board_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        indicatorColor: const Color.fromARGB(255, 4, 125, 141),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 4, 125, 141)),
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<PiecesManager>(create: (_) => PiecesManager()),
          ChangeNotifierProvider<MatchManager>(create: (_) => MatchManager()),
          ChangeNotifierProvider<AnimationsManager>(
              create: (_) => AnimationsManager()),
        ],
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          autofocus: true,
          onKey: (key) {
            if (key.character != null) {
              print('tecla: ' + key.character.toString());
            }
          },
          child: const Scaffold(
            backgroundColor: Color.fromARGB(255, 4, 125, 141),
            body: SingleChildScrollView(
              child: Center(
                child: BoardScreen(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
