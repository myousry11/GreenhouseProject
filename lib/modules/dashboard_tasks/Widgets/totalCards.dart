import 'package:flutter/material.dart';

Widget totalCards() {
  return Container(
    height: 180.0,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          width: 185.0,
          height: 165.0,
          decoration: BoxDecoration(
            color: Colors.teal[100],
            borderRadius: BorderRadius.circular(20.0,),
            border: Border.all(
              color: Colors.black.withOpacity(0.20),
              width: 2.0,
            ),
            gradient: LinearGradient(colors: [Color(0xff007f6d).withOpacity(0.3),Color(0xffd9f2ef).withOpacity(0.3),]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10,5,0,0),
                    child: Image(
                      image: AssetImage('assets/icons/energy.png'),
                      height: 50,
                    ),
                  ),
                ],
              ),
              Container(
                child: Text(
                  'Total Energy Usage (Kv)',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Text(
                    "1200",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20,),
        Container(
          width: 185.0,
          height: 165.0,
          decoration: BoxDecoration(
            color: Colors.teal[100],
            borderRadius: BorderRadius.circular(20.0,),
            border: Border.all(
              color: Colors.black.withOpacity(0.20),
              width: 2.0,
            ),
            gradient: LinearGradient(colors: [Color(0xff007f6d).withOpacity(0.3),Color(0xffd9f2ef).withOpacity(0.3),]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10,5,0,0),
                    child: Image(
                      image: AssetImage('assets/icons/water.png'),
                      height: 50,
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  'Total Water Usage (L)',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Text(
                    "5",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20,),
        Container(
          width: 185.0,
          height: 165.0,
          decoration: BoxDecoration(
            color: Colors.teal[100],
            borderRadius: BorderRadius.circular(20.0,),
            border: Border.all(
              color: Colors.black.withOpacity(0.20),
              width: 2.0,
            ),
            gradient: LinearGradient(colors: [Color(0xff007f6d).withOpacity(0.3),Color(0xffd9f2ef).withOpacity(0.3),]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10,5,0,0),
                    child: Image(
                      image: AssetImage('assets/icons/plant.png'),
                      height: 50,
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  'Plants Age (days)',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Text(
                    "30",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20,),
        Container(
          width: 185.0,
          height: 165.0,
          decoration: BoxDecoration(
            color: Colors.teal[100],
            borderRadius: BorderRadius.circular(20.0,),
            border: Border.all(
              color: Colors.black.withOpacity(0.20),
              width: 2.0,
            ),
            gradient: LinearGradient(colors: [Color(0xff007f6d).withOpacity(0.3),Color(0xffd9f2ef).withOpacity(0.3),]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10,5,0,0),
                    child: Image(
                      image: AssetImage('assets/icons/devices.png'),
                      height: 40,
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  'Total Devices',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Text(
                    "5",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ], // Remove the extra comma here
    ),
  );
}
