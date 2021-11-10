import 'package:flutter/material.dart';
import 'package:kharazan/controllers/match_mannager.dart';
import 'package:kharazan/controllers/piece_manager.dart';
import 'package:kharazan/screens/match_screen/tabs/match_anotation_tab.dart';
import 'package:kharazan/screens/match_screen/widgets/piece_widget.dart';
import 'package:kharazan/screens/match_screen/widgets/tile_widget.dart';
import 'package:provider/provider.dart';

class BoardMatch extends StatelessWidget {
  const BoardMatch({Key? key}) : super(key: key);
  final double universalNumber = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer2<PiecesManager, MatchManager>(
          builder: (context, piecesManager, matchManager, __) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: matchManager.matchField.limitX,
                  height: matchManager.matchField.limitX,
                  color: Colors.amber,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                    ),
                    itemCount: matchManager.matchField.fieldSpace.length,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      bool inGap(int a, int b) {
                        return a <= index && index <= b;
                      }

                      bool gonnaBeWhite;

                      if (inGap(8, 15) ||
                          inGap(24, 31) ||
                          inGap(40, 47) ||
                          inGap(56, 63)) {
                        gonnaBeWhite = (index % 2) + 1 == 1;
                      } else {
                        gonnaBeWhite = index % 2 == 1;
                      }

                      return TileWidget(
                        gonnaBeWhite ? false : true,
                        matchManager.matchField.fieldSpace[index].name,
                      );
                    },
                  ),
                ),
                ...piecesManager.piecesInGame.map((piece) {
                  return PieceWidget(piece: piece);
                }).toList(),
              ],
            );
          },
        ),
        MatchAnotationTab(),
      ],
    );
  }
}
