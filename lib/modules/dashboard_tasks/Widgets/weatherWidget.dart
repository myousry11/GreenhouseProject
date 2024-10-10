
import 'package:flutter/material.dart';

Widget currentWeatherMoreDetailsWidget(BuildContext context){
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: height * 0.08,
            width: width * 0.18,
            padding: const EdgeInsets.all(16.0,),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15.0,),
            ),
            child: Image(
              image: AssetImage('assets/icons/windy.png'), //windy
            ),
          ),
          Container(
            height: height * 0.08,
            width: width * 0.18,
            padding: const EdgeInsets.all(16.0,),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15.0,),
            ),
            child: Image(
              image: AssetImage('assets/icons/humidity.png'), // humidity
            ),
          ),
          Container(
            height: height * 0.08,
            width: width * 0.18,
            padding: const EdgeInsets.all(16.0,),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15.0,),
            ),
            child: Image(
              image: AssetImage('assets/icons/rain.png'), //precipitations
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: height * 0.02,
            width: width * 0.15,
            child: Text(
              '25 km/h',
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,

              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: height * 0.02,
            width: width * 0.15,
            child: Text(
              '50%',
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,

              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: height * 0.02,
            width: width * 0.15,
            child: Text(
              '25%',
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ],
  );
}
Widget temperatureAreaWidget(BuildContext context){
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Image(
        image: AssetImage('assets/images/cloudyw.png'),
        height: height * 0.07,
        width: width * 0.25,
      ),
      Container(
        height: 50.0,
        width: 1,
        color: Colors.grey[400],
      ),

      RichText(
        text: TextSpan(
          text: '27°',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 60,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),

    ],
  );
}