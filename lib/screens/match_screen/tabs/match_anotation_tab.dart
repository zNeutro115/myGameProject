import 'package:flutter/material.dart';
import 'package:kharazan/content/pieces.dart';
import 'package:kharazan/controllers/match_mannager.dart';
import 'package:kharazan/controllers/piece_manager.dart';
import 'package:kharazan/models/pieces_dart.dart';
import 'package:kharazan/utils/pieces_convets.dart';
import 'package:provider/provider.dart';

class MatchAnotationTab extends StatelessWidget {
  const MatchAnotationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 800,
      height: 200,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10, mainAxisExtent: 30),
        itemCount:
            context.watch<MatchManager>().anotation.currentDiagram.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              //www.kharazan.com/1B3350?11BME&9WME&12WPE&7BPE&21
              //www.kharazan.com/1B3650?20BME&0WME&12WPE&7BPE&21
              // print(PiecessContent.allPiecesInTheGame);
              print('PEÇAS');
              Converts.fieldStringtoPieces(
                  'www.kharazan.com/1B3350?11BME&9WME&12WPE&7BPE&21');
              print('PEÇAS HAHAA');
              // context.read<PiecesManager>().piecesInGame = pieces;
              // print(PiecessContent.allPiecesInTheGame);
              // print(context.read<PiecesManager>().piecesInGame);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(
                  color: Colors.black45,
                ),
              ),
              padding: const EdgeInsets.only(bottom: 2, right: 5),
              child: Center(
                child: Text(
                  context.watch<MatchManager>().anotation.move[index],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
