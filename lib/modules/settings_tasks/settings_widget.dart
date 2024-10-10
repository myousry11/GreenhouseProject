import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function function;

  const ProfileWidget({
    required this.icon,
    required this.title,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).primaryColor, size: 24.0),
              const SizedBox(
                width: 16.0,
              ),
              Text(
                title, // Use the `title` variable here, not a string literal 'title'
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          IconButton(
              icon: Icon(Icons.arrow_forward_ios,
              color: Theme.of(context).primaryColor,
              size: 16.0,
              ),
            onPressed: (){
                function();
            },
          ),
        ],
      ),
    );
  }
}