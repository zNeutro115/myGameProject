import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:kharazan/content/pieces.dart';
import 'package:kharazan/models/fields.dart';
import 'package:kharazan/models/pieces_dart.dart';
import 'package:kharazan/utils/pieces_convets.dart';

class PiecesManager extends ChangeNotifier {
  List<Piece> get piecesInGame => _piecesInGame;
  List<Piece> _piecesInGame = [
    whitePegasus,
    whiteMedusa,
    blackMedusa,
    blackPegasus,
  ];
  set piecesInGame(List<Piece> pieces) {
    _piecesInGame = pieces;
    notifyListeners();
  }

  List<String> _possibleMoves = [];
  List<String> _possibleAttacks = [];
  List<String> get possibleMoves => _possibleMoves;
  List<String> get possibleAttacks => _possibleAttacks;

  Piece? _currentPiece;
  Piece? get currentPiece => _currentPiece;

  set currentPiece(Piece? piece) {
    _currentPiece = piece;
    if (piece == null) {
      _possibleMoves = [];
      _possibleAttacks = [];
    } else {
      List<String> _listOfMoves = Converts.getValidMoves(piece);
      _piecesInGame.forEach((element) {
        if (_listOfMoves.contains(element.location.name)) {
          _listOfMoves.remove(element.location.name);
        }
      });
      _possibleMoves = _listOfMoves;
      _possibleAttacks = Converts.getValidMoves(piece, isAttack: true);
    }
    notifyListeners();
  }

  String? moveMade;

  makeMove() async {
    String origin = moveMade![0] + moveMade![1];
    String destiny = moveMade![2] + moveMade![3];
    var _indexOrigin =
        _piecesInGame.indexWhere((element) => element.location.name == origin);
    var _indexDestiny =
        _piecesInGame.indexWhere((element) => element.location.name == destiny);

    bool isAttacking = _piecesInGame.any((element) {
      print('atacking: ${element.location.name == destiny}');
      return element.location.name == destiny;
    });

    if (isAttacking) {
      print('is Atacking');
      _piecesInGame[_indexDestiny].life = _piecesInGame[_indexDestiny].life -
          _piecesInGame[_indexOrigin].attack;
      // _piecesInGame[_indexOrigin].location = tileIdentifier;
    } else {
      // _piecesInGame[_indexOrigin].location = FieldTile(name: destiny);
    }
    notifyListeners();
  }
}
