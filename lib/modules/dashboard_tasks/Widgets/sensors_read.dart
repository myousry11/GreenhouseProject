import 'package:flutter/material.dart';
import 'package:untitled6/modules/controls_tasks/SensorsPages/carbon_page.dart';
import 'package:untitled6/modules/controls_tasks/SensorsPages/humidity_page.dart';
import 'package:untitled6/modules/controls_tasks/SensorsPages/pH_page.dart';
import 'package:untitled6/modules/controls_tasks/SensorsPages/temp_page.dart';
import 'package:untitled6/modules/controls_tasks/SensorsPages/water_page.dart';
import 'package:untitled6/shared/components/constants.dart';
import 'package:untitled6/shared/data/api/api.dart';

class Sensors extends StatefulWidget {
  const Sensors({super.key});

  @override
  State<Sensors> createState() => _SensorsState();
}

class _SensorsState extends State<Sensors> {
  late SocketManager socketManager;
  String temperature = '';
  String humidity = '';
  String waterLevel = '';
  String Ph = '';
  String co2 = '';
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    socketManager = SocketManager();
    socketManager.listenToData((data) {
      if (!isDisposed) {
        setState(() {
          temperature = data['temperature'].toString();
          humidity = data['humidity'].toString();
          waterLevel = data['w_level'].toString();
          co2 = data['mq135'].toString();
          Ph = data['ph'].toString();
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cardItem(
              title: "TEMPERATURE",
              image: 'assets/icons/temperature.png',
              sensor: '23 °C',
              color: Constants.primaryColor.withOpacity(0.6),
              fontColor: Colors.white,
              onTab: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TemperaturePage()));
              },
            ),
            SizedBox(
              width: 20,
            ),
            cardItem(
              title: "Humidity",
              image: 'assets/icons/humidity.png',
              sensor: '46 %',
              color: Constants.primaryColor.withOpacity(0.6),
              fontColor: Colors.white,
              onTab: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HumidityPage()));
              },
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cardItem(
              title: "WATER LEVEL",
              image: 'assets/icons/water.png',
              sensor: '5 cm',
              color: Constants.primaryColor.withOpacity(0.6),
              fontColor: Colors.white,
              onTab: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WaterLevelScreen()));
              },
            ),
            SizedBox(
              width: 20,
            ),
            cardItem(
              title: "CO2",
              image: 'assets/icons/co2.png',
              colorImg: Theme.of(context).primaryColor,
              sensor: '700 Gas',
              color: Constants.primaryColor.withOpacity(0.6),
              fontColor: Colors.white,
              onTab: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => carbonPage()));
              },
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cardItem(
              title: "PH",
              image: 'assets/icons/pH.png',
              sensor: '4 ',
              color: Constants.primaryColor.withOpacity(0.6),
              fontColor: Colors.white,
              onTab: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => pHPage()));
              },
            ),
          ],
        ),
      ],
    );
  }

  GestureDetector cardItem({
    required title,
    required String image,
    required String sensor,
    VoidCallback? onTab,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
    Color? colorImg,
  }) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTab,
      child: Material(
        elevation: 15.0,
        shadowColor: Colors.green.shade200,
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          height: height * 0.2,
          width: width / 2.6,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: color,
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                image,
                height: 45,
                width: 45,
                color: colorImg,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                sensor,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
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
