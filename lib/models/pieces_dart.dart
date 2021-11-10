import 'package:kharazan/models/fields.dart';

class Piece {
  String name;
  FieldTile location;
  late String image;
  late String uniCode;
  int attack;
  int life;
  int mana;
  bool isWhite;
  List<String> moveArea;
  List<String> attackArea;
  Piece({
    required this.name,
    required this.location,
    required this.isWhite,
    required this.moveArea,
    required this.attackArea,
    required this.attack,
    required this.mana,
    required this.life,
    required uniCode,
  }) {
    this.uniCode = '${isWhite ? 'W' : 'B'}$uniCode';
    this.image =
        'icons/${name.toLowerCase()}_${isWhite ? 'white' : 'black'}.png';
  }
  @override
  String toString() {
    return '{ Name: $name | Code: $uniCode | Local: $location'
        // 'Attack: $attack|Mana: $mana|Life: $life'
        ' } ';
  }
}
