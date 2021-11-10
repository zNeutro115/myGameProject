import 'package:flutter/material.dart';
import 'package:kharazan/controllers/match_mannager.dart';
import 'package:kharazan/controllers/piece_manager.dart';
import 'package:kharazan/models/pieces_dart.dart';
import 'package:kharazan/utils/pieces_convets.dart';
import 'package:provider/provider.dart';

class TileWidget extends StatelessWidget {
  final bool isWhite;
  final String tileIndentifier;
  const TileWidget(
    this.isWhite,
    this.tileIndentifier, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('buildou: $index');
    return Consumer2<PiecesManager, MatchManager>(
      builder: (context, piecesManager, matchManager, __) {
        Piece? piece;
        piecesManager.piecesInGame.forEach((element) {
          if (element.location.name == tileIndentifier) {
            piece = element;
          }
        });
        return Center(
          child: Container(
            width: 100,
            height: 100,
            color: piecesManager.possibleAttacks.contains(tileIndentifier) &&
                    piece != null
                ? isWhite
                    ? matchManager.matchField.attackedWhiteColor
                    : matchManager.matchField.attackedBlackColor
                : isWhite
                    ? matchManager.matchField.whiteColor
                    : matchManager.matchField.blackColor,
            child: DragTarget<Piece>(
              onAccept: (commingPiece) async {
                String move = commingPiece.location.name + tileIndentifier;
                piecesManager.moveMade = move;
                await piecesManager.makeMove();

                matchManager.isWhite
                    ? matchManager.whiteMana =
                        matchManager.whiteMana - commingPiece.mana
                    : matchManager.blackMana =
                        matchManager.blackMana - commingPiece.mana;
                matchManager.addAnotation(
                  move,
                  Converts.getCurrentFieldState(
                    field: matchManager.matchField,
                    pieces: piecesManager.piecesInGame,
                    isWhite: matchManager.isWhite,
                    blackMana: matchManager.blackMana,
                    whiteMana: matchManager.whiteMana,
                  ),
                );
              },
              onWillAccept: (data) {
                if (piecesManager.currentPiece == null) return false;

                if (data == null) return false;

                if (piecesManager.possibleAttacks.contains(tileIndentifier) &&
                    piece != null) return true;

                if (piecesManager.possibleMoves.contains(tileIndentifier)) {
                  return true;
                }
                return false;
              },
              builder: (context, _, __) {
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          tileIndentifier,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    if (piecesManager.possibleAttacks
                            .contains(tileIndentifier) &&
                        piece == null)
                      Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Colors.red[400],
                        ),
                      ),
                    if (piecesManager.possibleMoves.contains(tileIndentifier) &&
                        piece == null)
                      Center(
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.green[300],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    if ((piece == null && piecesManager.currentPiece != null) ||
                        piecesManager.possibleAttacks.contains(tileIndentifier))
                      InkWell(
                        onTap: (piecesManager.possibleAttacks
                                        .contains(tileIndentifier) &&
                                    piece != null) ||
                                piecesManager.possibleMoves
                                    .contains(tileIndentifier)
                            ? () {
                                String move =
                                    piecesManager.currentPiece!.location.name +
                                        tileIndentifier;
                                piecesManager.moveMade = move;
                              }
                            : null,
                        child: Container(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          color: Colors.transparent,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
