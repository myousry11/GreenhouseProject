import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/shared/business_logic/Provider/DataProvider.dart';

import '../../shared/business_logic/cubit/cubit.dart';
import '../../shared/business_logic/cubit/state.dart';
import 'Widgets/CardWidget.dart';

class ControlsScreen extends StatefulWidget {
  @override
  State<ControlsScreen> createState() => _ControlsScreenState();
}

class _ControlsScreenState extends State<ControlsScreen> {
  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      // if (index == 0) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => LightPage(title: 'title')),
                      //   ).then((value) {
                      //     // Update the fanSwitchState with the selected state of the fan switch
                      //     setState(() {
                      //     });
                      //   });
                      // }
                    },
                    child: CardWidget(buttonData: dataProvider.buttons[index]),
                  ),
                  itemCount: dataProvider.buttons.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
