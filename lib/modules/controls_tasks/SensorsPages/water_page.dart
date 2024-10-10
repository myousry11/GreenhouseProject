import 'package:flutter/material.dart';
import 'package:untitled6/modules/controls_tasks/Widgets/watertank_anim.dart';
import 'package:untitled6/shared/data/api/api.dart';

import '../../../shared/business_logic/cubit/cubit.dart';
import '../Widgets/charts.dart';

class WaterLevelScreen extends StatefulWidget {
  @override
  State<WaterLevelScreen> createState() => _WaterLevelScreenState();
}

class _WaterLevelScreenState extends State<WaterLevelScreen> {
  void incrementWaterLevel(){
    waterLevel++;
    setState(() {

    });
  }

  void decrementWaterLevel(){
    waterLevel--;
    setState(() {

    });
  }
  late SocketManager socketManager;
  String waterDetection = '';
  double waterLevel = 5.0;
  final controlCubit = ControlCubit();
  @override
  void initState(){
    super.initState();
    socketManager = SocketManager();
    socketManager.listenToData((data) {
      setState(() {
        // Update temperature value here when data is received from socket
        waterDetection = data['w_level'].toString();
        // Update water level value based on water detection
        waterLevel = int.parse(waterDetection).toDouble();
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Water Level",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.8
              ),
            ),
            SizedBox(
              height: 125,
            ),
            Container(
              height: 300,
                child: WaterTankWidget(waterLevel: waterLevel,)),
            // Expanded(child: CounterScreen(waterLevel, incrementWaterLevel,decrementWaterLevel),
            //   flex: 1,
            // ),
            // Expanded(
            //   flex: 2,
            //   child: ChartGraph(
            //     width: MediaQuery.of(context).size.width * 1.5,
            //     height: MediaQuery.of(context).size.height * 0.6,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    socketManager.disconnect();
    super.dispose();
  }
}
