import 'package:flutter/material.dart';
import 'package:untitled6/modules/controls_tasks/Widgets/charts.dart';
import 'package:untitled6/modules/controls_tasks/Widgets/precent_indictor.dart';

import '../../../shared/business_logic/cubit/cubit.dart';
import '../../../shared/data/api/api.dart';

class TemperaturePage extends StatefulWidget {

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  late SocketManager socketManager;
  String temperature = '';
  double percent = 0.0;
  final controlCubit = ControlCubit();
  @override
  void initState() {
    super.initState();
    socketManager = SocketManager();
    socketManager.listenToData((data) {
      setState(() {
        // Update temperature value here when data is received from socket
        temperature = data['temperature'].toString();
        double minTemperature = 0.0;
        double maxTemperature = 100.0;
        percent = (double.parse(temperature) - minTemperature) / (maxTemperature - minTemperature);
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
                "Temperature",
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
              height: 130,
            ),
            Center(
              child: PercentIndicator(
                value: '23 °C',
                percent: 0.23,
                colors: [Colors.blue, Colors.green,  Colors.red], // الألوان المقابلة للدرجات
                temperatureThresholds: [30, 70, 100], // درجات الحرارة المقابلة لكل لون
              ),
            ),

            // Expanded(
            //   child: Container(
            //     margin: const EdgeInsets.only(top: 110),
            //       child: DropdownDemo()
            //   ),
            // ),
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

