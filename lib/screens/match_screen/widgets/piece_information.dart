import 'package:flutter/material.dart';
import 'package:kharazan/models/pieces_dart.dart';

class PieceAttachedInfo extends StatelessWidget {
  final Piece piece;
  const PieceAttachedInfo({Key? key, required this.piece}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  piece.life.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.blue[700]!),
                ),
                Text(
                  piece.attack.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.red),
                ),
                Text(
                  piece.mana.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.yellow),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  piece.life.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  piece.attack.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  piece.mana.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
