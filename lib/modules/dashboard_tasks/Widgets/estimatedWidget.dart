import 'package:flutter/material.dart';

Widget estimatedWidget() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 8.0),
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.teal[100],
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.black.withOpacity(0.20),
                width: 2.0,
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xff007f6d).withOpacity(0.3),
                  Color(0xffd9f2ef).withOpacity(0.3),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text(
                    'Estimated \n Fertilizer Add Date',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      "16 / 10 / 2023 ",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 8.0),
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.teal[100],
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.black.withOpacity(0.20),
                width: 2.0,
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xff007f6d).withOpacity(0.3),
                  Color(0xffd9f2ef).withOpacity(0.3),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: Text(
                    'Estimated \n Fertilizer Add Date',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      "16 / 10 / 2023 ",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
