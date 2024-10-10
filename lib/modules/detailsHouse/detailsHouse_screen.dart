import 'package:flutter/material.dart';
import 'package:untitled6/layout/home_layout.dart';
import 'package:untitled6/modules/controls_tasks/SensorsPages/carbon_page.dart';
import 'package:untitled6/modules/controls_tasks/SensorsPages/humidity_page.dart';
import 'package:untitled6/modules/controls_tasks/SensorsPages/pH_page.dart';
import 'package:untitled6/modules/controls_tasks/SensorsPages/temp_page.dart';
import 'package:untitled6/modules/controls_tasks/SensorsPages/water_page.dart';
import 'package:untitled6/modules/detailsHouse/Plantgrow/plant_bground.dart';
import 'package:untitled6/modules/detailsHouse/plantWidget.dart';

import '../../shared/data/api/api.dart';

class GreenHouse extends StatefulWidget {
  @override
  State<GreenHouse> createState() => _GreenHouseState();
}

class _GreenHouseState extends State<GreenHouse> {
  late SocketManager socketManager;
  String temperature = '';
  String humidity = '';
  String waterDetection = '';
  String co2 = '';
  String pH = '';
  String fan = '';


  @override
  void initState() {
    super.initState();
    socketManager = SocketManager();
    socketManager.listenToData((data) {
      temperature = data['temperature'].toString();
      humidity = data['humidity'].toString();
      waterDetection = data['w_level'].toString();
      co2 = data['mq135'].toString();
      pH = data['ph'].toString();
      fan = data['fan'].toString();
      setState(() {
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeLayout(), // Enter details page
                        ),
                      );
                    },
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 45, top: 10),
                  child: Text(
                    'GREEN HOUSE',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3,
                        color: Colors.teal),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlantGrow(), // Enter details page
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20, top: 40),
                height: 200,
                width: 300.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.20),
                    width: 2.0,
                  ),
                ),
                child: Column(
                  children: [
                    plantGH(context),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TemperaturePage(),
                          ),
                        );
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 20, top: 20, right: 10),
                        height: 75,
                        width: 150.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Image(
                                image:
                                    AssetImage('assets/icons/temperature.png'),
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              '$temperature °C',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 25,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HumidityPage(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 20, right: 20),
                        height: 75,
                        width: 150.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Image(
                                image:
                                    AssetImage('assets/icons/humidity.png'),
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              '$humidity %',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20, width: 20,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WaterLevelScreen(),
                          ),
                        );
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 20, top: 20, right: 10),
                        height: 75,
                        width: 150.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Image(
                                image:
                                    AssetImage('assets/icons/water.png'),
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              '$waterDetection  L',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 25,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => carbonPage(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 20, right: 20),
                        height: 75,
                        width: 160.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Image(
                                image:
                                    AssetImage('assets/icons/co2.png'),
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              '$co2 mol/L',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 20, width: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pHPage(),
                          ),
                        );
                      },
                      child: Container(
                        margin:
                        const EdgeInsets.only(left: 20, top: 20, right: 10),
                        height: 75,
                        width: 200.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Image(
                                image:
                                AssetImage('assets/icons/pH.png'),
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              '$pH',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 25,),
                  ],
                ),
              ],
            ),
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
