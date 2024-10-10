import 'package:flutter/material.dart';
import 'package:untitled6/modules/detailsHouse/Plantgrow/plantanim.dart';
class PlantGrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal.withOpacity(0.8),
              Colors.teal.withOpacity(0.6),
              Colors.teal.withOpacity(0.5),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: const [0.0, 0.5, 1.0],
            tileMode: TileMode.clamp
          ),
        ),
        child: PlantScreen(),
      ),
    );
  }
}
