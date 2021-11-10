import 'package:flutter/material.dart';
import 'package:kharazan/screens/match_screen/tabs/board_match.dart';
import 'package:kharazan/screens/match_screen/tabs/controller_tab.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(flex: 5),
        const BoardMatch(),
        Expanded(child: ControllerTab(), flex: 2),
        Spacer(flex: 3),
      ],
    );
  }
}
