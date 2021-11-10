import 'package:flutter/material.dart';
import 'package:kharazan/utils/pieces_convets.dart';

class Field {
  Color whiteColor;
  Color blackColor;
  Color attackedWhiteColor;
  Color attackedBlackColor;
  List<FieldTile> fieldSpace;
  String name;
  double limitX;
  double limitY;
  int mapNumber;
  Field({
    required this.name,
    required this.whiteColor,
    required this.blackColor,
    required this.fieldSpace,
    required this.attackedWhiteColor,
    required this.attackedBlackColor,
    required this.mapNumber,
    this.limitX = 10,
    this.limitY = 10,
  });
}

class FieldTile {
  String name;
  late double axisY;
  late double axisX;
  FieldTile({
    required this.name,
  }) {
    axisX = Converts.toNum(name[0]).toDouble();
    axisY = double.tryParse(name[1])!;
  }
}
