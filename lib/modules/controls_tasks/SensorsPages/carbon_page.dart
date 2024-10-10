import 'package:flutter/material.dart';
import 'package:untitled6/modules/controls_tasks/Widgets/charts.dart';
import 'package:untitled6/modules/controls_tasks/Widgets/precent_indictor.dart';

import '../../../shared/business_logic/cubit/cubit.dart';
import '../../../shared/data/api/api.dart';

class carbonPage extends StatefulWidget {

  @override
  State<carbonPage> createState() => _carbonPageState();
}

class _carbonPageState extends State<carbonPage> {
  late SocketManager socketManager;
  String carbon = '';
  double percent = 0.0;
  final controlCubit = ControlCubit();
  @override
  void initState() {
    super.initState();
    socketManager = SocketManager();
    socketManager.listenToData((data) {
      setState(() {
        carbon = data['mq135'].toString();
        double minCarbon = 0.0;
        double maxCarbon = 1024.0;
        percent = (double.parse(carbon) - minCarbon) / (maxCarbon - minCarbon);
        percent = percent.clamp(0.0, 1.0); // تحديد الحدود بين 0 و 1
      });
    });

  }
  bool switchValue = false;
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
              "Carbon Sensor",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.8
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Transform.scale(
            //     scale: 1.2,
            //     child: Switch(
            //       value: switchValue,
            //       onChanged: (value) {
            //         setState(() {
            //           switchValue = value;
            //         });
            //       },
            //       activeColor: Colors.teal,
            //       inactiveThumbColor: Colors.grey,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 125,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                height: 300,
                width: 100,
                child: PercentIndicator(
                  value: '700 Gas',
                  percent: 0.7,
                  colors: [Colors.blue, Colors.green,  Colors.red], // الألوان المقابلة للدرجات
                  temperatureThresholds: [100, 500, 1024], // درجات الحرارة المقابلة لكل لون
                ),
              ),
            ),
            // Expanded(
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

