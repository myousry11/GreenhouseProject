import 'package:flutter/material.dart';
class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Image(
              image: AssetImage('assets/images/connect.png'),
              height: 400,
              width: 400,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: [
                  Text(
                      'Connection Failed',
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),

                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Could\'t connect to the network, \n     Please check and try again.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600.withOpacity(0.8),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
