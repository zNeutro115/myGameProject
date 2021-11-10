import 'package:flutter/material.dart';
import 'package:kharazan/content/maps.dart';
import 'package:kharazan/models/fields.dart';
import 'package:kharazan/models/match_annotation.dart';

class MatchManager extends ChangeNotifier {
  //define who plays
  bool _isWhite = true;
  bool get isWhite => _isWhite;
  set isWhite(bool value) {
    _isWhite = value;
    notifyListeners();
  }

  //white and black mana
  int _whiteMana = 45;
  int _blackMana = 50;
  int get whiteMana => _whiteMana;
  int get blackMana => _blackMana;

  set blackMana(int value) {
    _blackMana = value;
    notifyListeners();
  }

  set whiteMana(int value) {
    _whiteMana = value;
    notifyListeners();
  }

  //set if the player can play
  bool _canPlay = false;
  bool get canPlay => _canPlay;
  set canPlay(bool value) {
    _canPlay = value;
    notifyListeners();
  }

  Anotation _anotation = Anotation(
      move: ['a4b5'],
      currentDiagram: ['www.kharazan.com/B4250&28WME5WPE7BPE2BME18']);
  Anotation get anotation => _anotation;
  void addAnotation(String _move, String _currentDiagram) {
    anotation.move.add(_move);
    anotation.currentDiagram.add(_currentDiagram);
    notifyListeners();
  }

  Field _matchField = MapsToBePlayed.coliseumMap;
  Field get matchField => _matchField;
}
