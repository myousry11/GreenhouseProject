import 'package:flutter/material.dart';
import '../../controls_tasks/Model/ButtonData.dart';

class CardWidget extends StatelessWidget {
  final ButtonData buttonData;

  CardWidget({required this.buttonData, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: buttonData.isSelected
            ? Border.all(width: 2, color: Colors.transparent)
            : Border.all(width: 2, color: Color(0xff267A72).withOpacity(0.3)),
        gradient: buttonData.isSelected
            ? LinearGradient(
          colors: [
            Color(0xff248176).withOpacity(0.3),
            Color(0xffCEDCA0).withOpacity(0.3)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : LinearGradient(colors: [Colors.transparent, Colors.transparent]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: buttonData.image,
                width: 60,
                height: 60,
                alignment: Alignment.topLeft,
              ),
              if (buttonData.id != 4) // If it's not the solar panel button
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: buttonData.isSelected,
                    onChanged: (bool? value) {
                      buttonData.toggleButtonOnPress!(buttonData.id);
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Color(0xff134742),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Color(0xff969696),
                    trackOutlineWidth: MaterialStateProperty.all(0),
                  ),
                ),
            ],
          ),
          Flexible(
            child: Text(
              buttonData.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 2.5,
              ),
            ),
          ),
          if (buttonData.id == 4) // If it's the solar panel button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xff134742).withOpacity(0.6),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left_outlined),
                    color: Theme.of(context).iconTheme.color,
                    onPressed: () => buttonData.onLeftPress!(buttonData.id),
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xff134742).withOpacity(0.6),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right_outlined),
                    color: Theme.of(context).iconTheme.color,
                    onPressed: () => buttonData.onRightPress!(buttonData.id),
                  ),
                ),
              ],
            )
          else
            Flexible(
              child: Text(
                "${buttonData.valuePerFix} ${buttonData.valuePostFix} ",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
