import 'package:flutter/material.dart';
import 'package:kharazan/controllers/animations_manager.dart';
import 'package:kharazan/controllers/match_mannager.dart';
import 'package:kharazan/controllers/piece_manager.dart';
import 'package:kharazan/models/pieces_dart.dart';
import 'package:kharazan/screens/match_screen/widgets/piece_information.dart';
import 'package:kharazan/utils/pieces_convets.dart';
import 'package:provider/provider.dart';

class PieceWidget extends StatelessWidget {
  final Piece piece;
  const PieceWidget({Key? key, required this.piece});

  @override
  Widget build(BuildContext context) {
    return Consumer3<PiecesManager, MatchManager, AnimationsManager>(
      builder: (context, piecesManager, matchManager, animations, _) {
        bool isCurrentPiece = piecesManager.currentPiece != null &&
            piecesManager.currentPiece!.location.name == piece.location.name;

        return AnimatedPositioned(
          height: 200,
          width: 200,
          duration:
              // isCurrentPiece &&
              //         piecesManager.piecesInGame.any((element) {
              //           if (piecesManager.moveMade == null) return false;
              //           return element.location.name ==
              //               piecesManager.moveMade![0] + piecesManager.moveMade![3];
              //         })
              //     ? Duration(seconds: 1) :
              Duration(seconds: 1),
          curve:
              // isCurrentPiece &&
              //         piecesManager.piecesInGame.any((element) {
              //           if (piecesManager.moveMade == null) return false;
              //           return element.location.name ==
              //               piecesManager.moveMade![0] + piecesManager.moveMade![3];
              //         })
              //     ? Curves.bounceIn :
              Curves.linear,
          onEnd: () async {},
          bottom: ((piece.location.axisY - 1) * 100) - 50,
          left: ((piece.location.axisX - 1) * 100) - 50,
          child: IgnorePointer(
            ignoring: !isCurrentPiece && piecesManager.currentPiece != null,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Draggable<Piece>(
                  onDragStarted: () {
                    piecesManager.currentPiece = piece;
                  },
                  onDragEnd: (details) {
                    piecesManager.currentPiece = null;
                  },
                  data: piece,
                  child: InkWell(
                    onTap:
                        // ((piece == null &&
                        //     piecesManager.currentPiece != null) ||
                        // piecesManager.possibleAttacks
                        //     .contains(tileIndentifier)) ?  () {} :
                        () {
                      if (piecesManager.currentPiece == null) {
                        piecesManager.currentPiece = piece;
                      } else {
                        print('entrou');
                        print(piecesManager.possibleAttacks);
                        if (!isCurrentPiece &&
                            piecesManager.possibleAttacks
                                .contains(piece.location.name)) {
                          String move =
                              piecesManager.currentPiece!.location.name +
                                  piece.location.name;
                          piecesManager.moveMade = move;
                          piecesManager.makeMove();
                          matchManager.isWhite
                              ? matchManager.whiteMana =
                                  matchManager.whiteMana -
                                      piecesManager.currentPiece!.mana
                              : matchManager.blackMana =
                                  matchManager.blackMana -
                                      piecesManager.currentPiece!.mana;

                          matchManager.addAnotation(
                            piecesManager.moveMade!,
                            Converts.getCurrentFieldState(
                              field: matchManager.matchField,
                              pieces: piecesManager.piecesInGame,
                              isWhite: matchManager.isWhite,
                              blackMana: matchManager.blackMana,
                              whiteMana: matchManager.whiteMana,
                            ),
                          );
                          piecesManager.currentPiece = null;
                          piecesManager.moveMade = null;
                        }
                        piecesManager.currentPiece = null;
                        piecesManager.moveMade = null;
                      }
                    },
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset(piece.image),
                    ),
                  ),
                  feedback: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(piece.image),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.7,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset(piece.image),
                    ),
                  ),
                ),
                PieceAttachedInfo(piece: piece),
              ],
            ),
          ),
        );
      },
    );
  }
}
