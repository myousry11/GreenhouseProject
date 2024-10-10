import 'package:flutter/material.dart';

import '../../../shared/business_logic/cubit/cubit.dart';
import '../../../shared/data/api/api.dart';

class GreenHouseWidget extends StatefulWidget {
  @override
  _GreenHouseWidgetState createState() => _GreenHouseWidgetState();
}

class _GreenHouseWidgetState extends State<GreenHouseWidget> {
  late SocketManager socketManager;
  String temperature = '';
  String humidity = '';
  String fan = '';
  String pump = '';
  final controlCubit = ControlCubit();

  Widget photoGH(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Stack(
        children: [
          Image(
            image: AssetImage('assets/images/picwid.jpeg'),
            height: height * 0.15,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: width * 0.5,
              height: height * 0.05,
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0,),
              ),
              child: Text(
                'GREEN HOUSE ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    socketManager = SocketManager();
    socketManager.listenToData((data) {
      setState(() {
        temperature = data['temperature'].toString();
        humidity = data['humidity'].toString();
        fan = data['fan_state'].toString();
        pump = data['pump'].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        photoGH(context),
        SizedBox(
          height: height * 0.004,
        ),
        SensorGHWidget(
          temperature: temperature,
          humidity: humidity,
          fan: fan,
          pump: pump,
        ),
      ],
    );
  }
  @override
  void dispose() {
    socketManager.disconnect();
    super.dispose();
  }
}

class SensorGHWidget extends StatelessWidget {
  final String temperature;
  final String humidity;
  final String fan;
  final String pump;

  SensorGHWidget({
    required this.temperature,
    required this.humidity,
    required this.fan,
    required this.pump,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: height * 0.07,
              width: width * 0.15,
              padding: const EdgeInsets.all(16.0),
              child: Image(
                image: AssetImage('assets/icons/temperature.png'),
              ),
            ),
            Container(
              height: height * 0.07,
              width: width * 0.15,
              padding: const EdgeInsets.all(16.0),
              child: Image(
                image: AssetImage('assets/icons/humidity.png'),
              ),
            ),
            Container(
              height: height * 0.07,
              width: width * 0.15,
              padding: const EdgeInsets.all(16.0),
              child: Image(
                image: AssetImage('assets/icons/fan.png'),
              ),
            ),
            Container(
              height: height * 0.07,
              width: width * 0.15,
              padding: const EdgeInsets.all(16.0),
              child: Image(
                image: AssetImage('assets/icons/pump.png'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: height * 0.03,
              width: width * 0.15,
              child: Text(
                '$temperature°C',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: height * 0.03,
              width: width * 0.15,
              child: Text(
                '$humidity%',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: height * 0.03,
              width: width * 0.15,
              child: Text(
                fan != null ? fan : 'N/A',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: height * 0.03,
              width: width * 0.15,
              child: Text(
                '$pump',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }

}
