import 'package:flutter/material.dart';
import 'package:kharazan/controllers/animations_manager.dart';
import 'package:kharazan/controllers/match_mannager.dart';
import 'package:provider/provider.dart';

class ControllerTab extends StatelessWidget {
  const ControllerTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchManager>(
      builder: (context, matchManager, __) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Vez das',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                matchManager.isWhite ? 'BRANCAS' : 'NEGRAS',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Divider(
                height: 20,
                thickness: 5,
                color: Colors.black87,
                endIndent: 15,
                indent: 15,
              ),
              SizedBox(height: 16),
              Container(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    matchManager.isWhite = !matchManager.isWhite;
                    if (context.read<AnimationsManager>().heightAndWidth ==
                        100) {
                      context.read<AnimationsManager>().heightAndWidth = 200;
                    } else {
                      context.read<AnimationsManager>().heightAndWidth = 100;
                    }
                  },
                  child: Text('Passar Vez'),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Mana das Brancas: ${matchManager.whiteMana}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              ),
              SizedBox(height: 4),
              Text(
                'Mana das Negras: ${matchManager.blackMana}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              ),
            ],
          ),
        );
      },
    );
  }
}
