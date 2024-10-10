
import 'package:curved_navigation_bar_with_label/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/shared/business_logic/cubit/state.dart';

import '../../../modules/ai_tasks/ai_tasks_screen.dart';
import '../../../modules/controls_tasks/Model/ButtonData.dart';
import '../../../modules/controls_tasks/controls_tasks_screen.dart';
import '../../../modules/dashboard_tasks/dashboard_tasks_screen.dart';
import '../../../modules/report_tasks/report_tasks_screen.dart';
import '../../../modules/settings_tasks/settings_task_screen.dart';
import '../../data/api/api.dart';
import '../Provider/theme_provider.dart';

class GreenCubit extends Cubit<GreenStates> {
  final ThemeProvider themeProvider;

  GreenCubit(this.themeProvider) : super(GreenInitialState());

  static GreenCubit get(context) => BlocProvider.of<GreenCubit>(context);
  int currentIndex = 0;

  List<CurvedNavigationBarItem> bottomItems(BuildContext context) => [
    CurvedNavigationBarItem(
      icon: Icon(Icons.dashboard_customize_outlined),
      label: 'Dashboard',
    ),
    CurvedNavigationBarItem(
      icon: Image.asset('assets/icons/ai.png', height: 30.0, color: Theme.of(context).primaryColor),
      label: 'AI',
    ),
    CurvedNavigationBarItem(
      icon: Image.asset('assets/images/controls.png', height: 30.0, color: Theme.of(context).primaryColor,),
      label: 'Controls',
    ),
    CurvedNavigationBarItem(
      icon: Icon(Icons.analytics_outlined),
      label: 'Report',
    ),
    CurvedNavigationBarItem(
      icon: Icon(Icons.settings_rounded),
      label: 'Settings',
    ),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(GreenBottomNavState());
  }

  List<Widget> screens = [
    DashboardScreen(),
    ImageClassifier(),
    ControlsScreen(),
    ReportScreen(),
    SettingsScreen(),
  ];
}

class ControlCubit extends Cubit<GreenStates> {
  static ControlCubit get(context) => BlocProvider.of(context);

  late SocketManager socketManager;
  String temperature = '';
  String humidity = '';
  String waterDetection = '';
  String co2 = '';
  String pH = '';
  String action = '';
  late bool fanState = false; // تحديد نوع fanState كمتغير منطقي
  late bool pump1State = false; // تحديد نوع fanState كمتغير منطقي
  late bool pump2State = false;
  late bool ledState = false;

  late List<ButtonData> buttons;

  ControlCubit() : super(GreenInitialState()) {
    socketManager = SocketManager();
    socketManager.listenToData((data) {
      print(data);
      temperature = data['temperature'].toString();
      humidity = data['humidity'].toString();
      waterDetection = data['w_level'].toString();
      co2 = data['mq135'].toString();
      pH = data['ph'].toString();
      fanState = data['fan_state'] == 'on'; // تحويل قيمة fan_state إلى منطقي
      pump1State = data['pump1_state'] == 'on';
      pump2State = data['pump2_state'] == 'on';
      ledState = data['led_state'] == 'on';
      //updateButtonData(action);
    });

    // Initialize button data here initially
    buttons = [
      ButtonData(
        id: 0,
        image: AssetImage('assets/icons/light.png'),
        toggleButtonOnPress: onLightPressTogglePress,
        title: "Lighting",
        valuePostFix: "",
        isSelected: ledState,
        valuePerFix: ledState ? 'on' : 'off',
      ),
      ButtonData(
        id: 1,
        image: AssetImage('assets/icons/fan.png'),
        toggleButtonOnPress: onFanPressTogglePress,
        title: "Fan",
        valuePostFix: "",
        isSelected: fanState,
        valuePerFix: fanState ? 'on' : 'off',
      ),
      ButtonData(
        id: 2,
        image: AssetImage('assets/icons/pump.png'),
        toggleButtonOnPress: onPump1PressTogglePress,
        title: "Pump 1",
        valuePostFix: "",
        isSelected: pump1State,
        valuePerFix: pump1State ? 'on' : 'off',
      ),
      ButtonData(
        id: 3,
        image: AssetImage('assets/icons/waterrpump2.png',),
        toggleButtonOnPress: onPump2PressTogglePress,
        title: "Pump 2",
        valuePostFix: "",
        isSelected: pump2State,
        valuePerFix: pump2State ? 'on' : 'off',
      ),
      ButtonData(
        id: 4,
        image: AssetImage('assets/icons/solar_panel.png'),
        toggleButtonOnPress: (id) {},
        title: "Solar Panel",
        valuePostFix: "",
        isSelected: false,
        valuePerFix: "",
        leftIcon: AssetImage('assets/icons/solar_left.png'),
        rightIcon: AssetImage('assets/icons/solar_right.png'),
        onLeftPress: onSolarLeftPress,
        onRightPress: onSolarRightPress,
      ),
    ];
  }

  void onPump2PressTogglePress(int id) {
    for (int i = 0; i < buttons.length; i++) {
      if (buttons[i].id == id) {
        buttons[i].isSelected = !buttons[i].isSelected;
        pump2State = buttons[i].isSelected;
        emit(ControlChanged(pump2State));
        break;
      }
    }

    action = pump2State ? "open" : "close";
    buttons.firstWhere((button) => button.id == 3).valuePerFix = pump2State ? "ON" : "OFF";
    socketManager.togglePump2(pump2State);
    emit(ControlPressed(pump2State));
  }

  void onLightPressTogglePress(int id) {
    for (int i = 0; i < buttons.length; i++) {
      if (buttons[i].id == id) {
        buttons[i].isSelected = !buttons[i].isSelected;
        ledState = buttons[i].isSelected;
        emit(ControlChanged(ledState));
        break;
      }
    }

    action = ledState ? "open" : "close";
    buttons.firstWhere((button) => button.id == 0).valuePerFix = ledState ? "ON" : "OFF";
    socketManager.toggleLed(ledState);
    emit(ControlPressed(ledState));
  }

  void onPump1PressTogglePress(int id) {
    for (int i = 0; i < buttons.length; i++) {
      if (buttons[i].id == id) {
        buttons[i].isSelected = !buttons[i].isSelected;
        pump1State = buttons[i].isSelected;
        emit(ControlChanged(pump1State));
        break;
      }
    }

    action = pump1State ? "open" : "close";
    buttons.firstWhere((button) => button.id == 2).valuePerFix = pump1State ? "ON" : "OFF";
    socketManager.togglePump1(pump1State);
    emit(ControlPressed(pump1State));
  }

  void onFanPressTogglePress(int id) {
    for (int i = 0; i < buttons.length; i++) {
      if (buttons[i].id == id) {
        buttons[i].isSelected = !buttons[i].isSelected;
        fanState = buttons[i].isSelected;
        emit(ControlChanged(fanState));
        break;
      }
    }

    action = fanState ? "open" : "close";
    buttons.firstWhere((button) => button.id == 1).valuePerFix = fanState ? "ON" : "OFF";
    socketManager.toggleFan(fanState);
    emit(ControlPressed(fanState));
  }

  void onSolarLeftPress(int id) {
    socketManager.moveSolarPanelLeft();
    emit(ControlPressed(false));
  }

  void onSolarRightPress(int id) {
    socketManager.moveSolarPanelRight();
    emit(ControlPressed(false));
  }



  // void changeSwitchState(int id) {
  //   for (int i = 0; i < buttons.length; i++) {
  //     if (buttons[i].id == id) {
  //       buttons[i].isSelected = !buttons[i].isSelected;
  //     }
  //   }
  //   fanState = buttons[3].isSelected;
  //   emit(ControlChanged(fanState));
  // }

  // void updateButtonData(String fanValue) {
  //   buttons = [
  //     ButtonData(
  //       id: 0,
  //       image: AssetImage('assets/icons/light.png'),
  //       toggleButtonOnPress: onPump2PressTogglePress,
  //       title: "Lighting",
  //       valuePostFix: "%",
  //       valuePerFix: "75",
  //     ),
  //     ButtonData(
  //       id: 1,
  //       image: AssetImage('assets/icons/solarpanel.png'),
  //       toggleButtonOnPress: onLightPressTogglePress,
  //       title: "Solar Panel",
  //       valuePostFix: "",
  //       valuePerFix: "",
  //     ),
  //     ButtonData(
  //       id: 2,
  //       image: AssetImage('assets/icons/camera.png'),
  //       toggleButtonOnPress: onPump1PressTogglePress,
  //       title: "Camera",
  //       valuePostFix: "",
  //       isSelected: pump1Value == "ON" ? true : false,
  //       valuePerFix: fanState ? 'ON' : 'OFF',      ),
  //     ButtonData(
  //       id: 3,
  //       image: AssetImage('assets/icons/fan.png'),
  //       toggleButtonOnPress: onFanPressTogglePress,
  //       title: "Fan",
  //       valuePostFix: "",
  //       isSelected: fanValue == "ON" ? true : false,
  //       valuePerFix: fanState ? 'ON' : 'OFF',
  //     ),
  //   ];
  // }

  @override
  Future<void> close() {
    socketManager.disconnect();
    return super.close();
  }
}

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial());
}

