//Class made to calculate and convert pieces movement

import 'package:kharazan/content/maps.dart';
import 'package:kharazan/content/pieces.dart';
import 'package:kharazan/models/fields.dart';
import 'package:kharazan/models/pieces_dart.dart';

class Converts {
  //Convert the list of MOVES that comes from the piece into a list of valid tile string
  //EX:[ULL, URR] => [b2, b6] (The piece is in a4 and those are the moves he can do)
  static List<String> getValidMoves(
    Piece piece, {
    bool isAttack = false,
  }) {
    List<String> _convertedList = [];
    int axisX = toNum(piece.location.name); //letter
    int axisY = int.parse(piece.location.name[1]); //number
    // print('currentPlace: $currentPlace');
    // print('AXIS X: $axisX'); //letter
    // print('AXIS Y: $axisY'); //number

    for (var move in isAttack ? piece.attackArea : piece.moveArea) {
      List<String> caracters = move.split('');
      int _axisXToBeAdded = axisX; //letter
      int _axisYToBeAdded = axisY; //number
      // print(caracters);
      caracters.forEach(
        (caracter) {
          // If caracter has U (UP) add one no Y axis
          // If caracter has D (DOWN) subtract one no Y axis
          // If caracter has R (RIGHT) add one no X axis
          // If caracter has L (LEFT) subtract one no X axis

          switch (caracter) {
            case 'U':
              _axisYToBeAdded++;
              // print('Y: $_axisYToBeAdded');
              break;
            case 'D':
              _axisYToBeAdded--;
              // print('Y: $_axisYToBeAdded');
              break;
            case 'R':
              _axisXToBeAdded++;
              // print('X: ${toLetter(_axisXToBeAdded)}');
              break;
            case 'L':
              _axisXToBeAdded--;
              // print('X: ${toLetter(_axisXToBeAdded)}');
              break;
          }
        },
      );
      String finalString =
          toLetter(_axisXToBeAdded) + _axisYToBeAdded.toString();
      // print('String final é: $finalString');
      // print('X: $_axisXToBeAdded');
      // print('Y: $_axisYToBeAdded');

      // print(_axisXToBeAdded < 9);
      // print(!finalString.contains('z'));
      // print(_axisXToBeAdded > 0);

      if (!finalString.contains('z') &&
          _axisXToBeAdded < 9 &&
          0 < _axisXToBeAdded &&
          _axisYToBeAdded < 9 &&
          0 < _axisYToBeAdded &&
          finalString != piece.location.name) {
        // print('vai add sim');
        _convertedList.add(finalString);
      }
    }
    return _convertedList;
  }

  //convert letter to number to calculate axisX
  static int toNum(String toConv, {bool isXandYAxis = true}) {
    String letter = isXandYAxis ? toConv[0] : toConv;
    switch (letter) {
      case 'a':
        return 1;
      case 'b':
        return 2;
      case 'c':
        return 3;
      case 'd':
        return 4;
      case 'e':
        return 5;
      case 'f':
        return 6;
      case 'g':
        return 7;
      case 'h':
        return 8;
      default:
        return 0;
    }
  }

  //convert number to letter to calculate axisX
  static String toLetter(int axisX) {
    switch (axisX) {
      case 1:
        return 'a';
      case 2:
        return 'b';
      case 3:
        return 'c';
      case 4:
        return 'd';
      case 5:
        return 'e';
      case 6:
        return 'f';
      case 7:
        return 'g';
      case 8:
        return 'h';
      default:
        return 'z';
    }
  }

  static List<Piece> fieldStringtoPieces(String gameString) {
    // String gameString = 'www.kharazan.com/1B4250?20WME&13WPE&7BPE&2BME&18';
    int tileNumber = 0;
    List<Piece> _piecesInTheGame = [];
    List allPiecesInTheGame = [];
    Piece generateCopyPiece(Piece piece) {
      print('unicoda: ${piece.uniCode[1] + piece.uniCode[1]}');
      return Piece(
        name: piece.name,
        location: piece.location,
        isWhite: piece.isWhite,
        moveArea: piece.moveArea,
        attackArea: piece.attackArea,
        attack: piece.attack,
        mana: piece.mana,
        life: piece.life,
        uniCode: piece.uniCode[1] + piece.uniCode[2],
      );
    }

    PiecessContent.allPiecesInTheGame.forEach((element) {
      // print(element);
      Piece _piece = generateCopyPiece(element);
      allPiecesInTheGame.add(_piece);
    });
    gameString
        .replaceAll('www.kharazan.com/', '')
        .substring(7)
        .split('&')
        .forEach((element) {
      List caracters = element.split('');
      print('Caracters: $caracters');

      if (int.tryParse(caracters[0]) != null &&
          int.tryParse(caracters[1]) != null) {
        tileNumber = tileNumber +
            (int.parse(caracters[0]) * 10) +
            int.parse(caracters[1]);

        if (element.length > 2) {
          Piece piece = allPiecesInTheGame.singleWhere((piece) {
            print('PEÇA > 2' +
                piece.toString() +
                '  | ${element[2]}${element[3]}${element[4]}');

            return piece.uniCode == '${element[2]}${element[3]}${element[4]}';
          });
          piece.location.name = MapsToBePlayed.allMapsInTheGame
              .singleWhere((element) =>
                  element.mapNumber.toString() ==
                  gameString.replaceAll('www.kharazan.com/', '')[0])
              .fieldSpace
              .elementAt(tileNumber)
              .name;
          piece.isWhite = false;
          _piecesInTheGame.add(piece);
        }
      } else if (int.tryParse(caracters[0]) != null &&
          int.tryParse(caracters[1]) == null) {
        tileNumber = tileNumber + int.parse(caracters[0]);

        if (element.length > 2) {
          // print('${element[1]}${element[2]}${element[3]}');
          Piece piece = allPiecesInTheGame.singleWhere((piece) {
            print('PEÇA KRAI' + piece.toString());
            return piece.uniCode == '${element[1]}${element[2]}${element[3]}';
          });

          piece.isWhite = false;
          piece.location.name = MapsToBePlayed.allMapsInTheGame
              .singleWhere((element) =>
                  element.mapNumber.toString() ==
                  gameString.replaceAll('www.kharazan.com/', '')[0])
              .fieldSpace
              .elementAt(tileNumber)
              .name;
          _piecesInTheGame.add(piece);
        }
      }
    });
    print('atŕ aqui4');

    print('FINAL:: ' + _piecesInTheGame.toString());
    return _piecesInTheGame;
  }

  static String getCurrentFieldState({
    required Field field,
    required List<Piece> pieces,
    required bool isWhite,
    required int whiteMana,
    required int blackMana,
  }) {
    String _baseUrl = 'www.kharazan.com/';
    String _isWhite = isWhite ? 'B' : 'N';
    String _whiteMana = whiteMana.toString();
    String _blackMana = blackMana.toString();

    String _matchStatus = _isWhite + _whiteMana + _blackMana;
    String _fieldState = '';
    List<String> _currentPiecesInGame = [];
    int emptySpaces = 0;
    pieces.forEach((_piece) {
      _currentPiecesInGame.add(_piece.location.name);
    });
    field.fieldSpace.asMap().forEach(
      (key, value) {
        if (_currentPiecesInGame.contains(value.name)) {
          String pieceName = pieces
              .singleWhere((element) => element.location.name == value.name)
              .uniCode;
          _fieldState = _fieldState + emptySpaces.toString() + pieceName + '&';
          emptySpaces = 0;
        } else {
          emptySpaces++;
        }
        if (field.fieldSpace.length == key + 1 &&
            !_currentPiecesInGame.contains(value.name)) {
          _fieldState = _fieldState + emptySpaces.toString();
        }
      },
    );
    final String finalMatchUrl =
        _baseUrl + '${field.mapNumber}' + _matchStatus + '?' + _fieldState;
    print(finalMatchUrl);
    return finalMatchUrl;
  }
}
