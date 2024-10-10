import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/modules/dashboard_tasks/Widgets/sensors_read.dart';
import 'package:untitled6/modules/detailsHouse/plantWidget.dart';

import '../../shared/business_logic/Provider/theme_provider.dart';
import '../../shared/data/api/api.dart';
import '../detailsHouse/Plantgrow/plant_bground.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late SocketManager socketManager;
  String firstName = '';

  @override
  void initState() {
    super.initState();
    socketManager = SocketManager();
    socketManager.listenToData((data) {
      setState(() {});
    });

    _loadFirstName();
  }

  Future<void> _loadFirstName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.13, 17.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            'Hello, $firstName',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 25.0,
                              //height: 1.08,
                              letterSpacing: 0.375,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.005,
                          ),
                          Image(
                            image: AssetImage('assets/icons/wave.png'),
                            height: 50,
                            width: 50,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                FutureBuilder(
                  future: Future.delayed(Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    DateTime now = DateTime.now();
                    List<String> daysOfWeek = [
                      'Monday',
                      'Tuesday',
                      'Wednesday',
                      'Thursday',
                      'Friday',
                      'Saturday',
                      'Sunday'
                    ];
                    List<String> months = [
                      'January',
                      'February',
                      'March',
                      'April',
                      'May',
                      'June',
                      'July',
                      'August',
                      'September',
                      'October',
                      'November',
                      'December'
                    ];

                    return Row(
                      children: [
                        Text(
                          '${daysOfWeek[now.weekday - 1]},',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '${now.day}',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '${months[now.month - 1]}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '${now.year}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(180 * 3.1415927 / 180),
                  child: Image(
                    image: AssetImage('assets/images/home1.png'),
                    height: height * 0.24,
                    width: width * 0.5,
                  ),
                ),
                Text(
                  'GREEN HOUSE',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge?.color,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'SENSORS',
                      style: TextStyle(
                        color: Colors.grey.shade600.withOpacity(0.9),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Sensors(),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'PLANT',
                      style: TextStyle(
                        color: Colors.grey.shade600.withOpacity(0.9),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantGrow(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      plantGH(context),
                    ],
                  ),
                ),
              ],
            ),
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
