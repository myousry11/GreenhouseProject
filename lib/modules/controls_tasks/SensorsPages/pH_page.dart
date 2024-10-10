import 'package:flutter/material.dart';
import 'package:untitled6/modules/controls_tasks/Widgets/charts.dart';
import 'package:untitled6/modules/controls_tasks/Widgets/precent_indictor.dart';

import '../../../shared/business_logic/cubit/cubit.dart';
import '../../../shared/data/api/api.dart';

class pHPage extends StatefulWidget {

  @override
  State<pHPage> createState() => _pHPageState();
}

class _pHPageState extends State<pHPage> {
  late SocketManager socketManager;
  String pH = '';
  double percent = 0.0;
  final controlCubit = ControlCubit();

  @override
  void initState() {
    super.initState();
    socketManager = SocketManager();
    socketManager.listenToData((data) {
      setState(() {
        pH = data['ph'].toString();
        double minPH = 0.0;
        double maxPH = 14.0;
        percent = (double.parse(pH) - minPH) / (maxPH - minPH);
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
                "pH Sensor",
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
                    value: '4',
                    // قيمة pH بدلاً من carbon
                    percent: 0.4,
                    colors: [Colors.red, Colors.white.withOpacity(0.4), Colors.blue ],
                    // الألوان المقابلة للدرجات
                    temperatureThresholds: [
                      6.99999,
                      7,
                      7.0001
                    ], // درجات الحرارة المقابلة لكل لون
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
