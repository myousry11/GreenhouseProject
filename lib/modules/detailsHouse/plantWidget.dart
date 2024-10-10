import 'package:flutter/material.dart';

Widget plantGH(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
      bottomLeft: Radius.circular(20.0),
      bottomRight: Radius.circular(20.0),
    ),
    child: Stack(
      children: [
        Image(
          image: AssetImage('assets/images/winka.jpg'),
          height: height * 0.2,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: width * 0.4,
            height: height * 0.05,
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
              'WINKA',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w900,
                letterSpacing: 4.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}
