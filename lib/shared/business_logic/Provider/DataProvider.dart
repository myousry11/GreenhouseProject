import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/modules/controls_tasks/Model/ButtonData.dart';
import 'package:untitled6/shared/data/api/api.dart';

class DataProvider extends ChangeNotifier {
  late SharedPreferences _prefs;

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

  initData(){
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
        title: "LIGHTING",
        valuePostFix: "",
        isSelected: ledState,
        valuePerFix: ledState ? 'ON' : 'OFF',
      ),
      ButtonData(
        id: 1,
        image: AssetImage('assets/icons/fan.png'),
        toggleButtonOnPress:  onFanPressTogglePress,
        title: "FAN",
        valuePostFix: "",
        isSelected: fanState,
        valuePerFix: fanState ? 'ON' : 'OFF',
      ),
      ButtonData(
        id: 2,
        image: AssetImage('assets/icons/pump.png'),
        toggleButtonOnPress: onPump1PressTogglePress,
        title: "PUMP 1",
        valuePostFix: "",
        isSelected: pump1State,
        valuePerFix: pump1State ? 'ON' : 'OFF',
      ),
      ButtonData(
        id: 3,
        image: AssetImage('assets/icons/waterrpump2.png',),
        toggleButtonOnPress: onPump2PressTogglePress,
        title: "PUMP 2",
        valuePostFix: "",
        isSelected: pump2State,
        valuePerFix: pump2State ? 'ON' : 'OFF',
      ),
      ButtonData(
        id: 4,
        image: AssetImage('assets/icons/solarpanel.png'),
        toggleButtonOnPress: (id) {},
        title: "Solar Panel",
        valuePostFix: "",
        isSelected: false,
        valuePerFix: "",
        leftIcon: AssetImage('assets/icons/ai.png'),
        rightIcon: AssetImage('assets/icons/ai.png'),
        onLeftPress: onSolarLeftPress,
        onRightPress: onSolarRightPress,
      ),
    ];
  }
  void onPump2PressTogglePress(int id) {
    // changeSwitchState(id);
    for (int i = 0; i < buttons.length; i++) {
      if (buttons[i].id == id) {
        buttons[i].isSelected = !buttons[i].isSelected;
        pump2State = buttons[i].isSelected;
        notifyListeners();
        break;
      }
    }

    action = pump2State ? "open" : "close";
    // تحديث قيمة الزر الخاص بالمروحة فقط
    buttons.firstWhere((button) => button.id == 3).valuePerFix = pump2State ? "ON" : "OFF";
    socketManager.togglePump2(pump2State);
    //updateButtonData(pump2State ? "ON" : "OFF");
    notifyListeners();
  }
  void onLightPressTogglePress(int id) {
    // changeSwitchState(id);
    for (int i = 0; i < buttons.length; i++) {
      if (buttons[i].id == id) {
        buttons[i].isSelected = !buttons[i].isSelected;
        ledState = buttons[i].isSelected;
        notifyListeners();
        break;
      }
    }

    action = ledState ? "open" : "close";
    // تحديث قيمة الزر الخاص بالمروحة فقط
    buttons.firstWhere((button) => button.id == 0).valuePerFix = ledState ? "ON" : "OFF";
    socketManager.toggleLed(ledState);
    //updateButtonData(ledState ? "ON" : "OFF");
    notifyListeners();

  }

  void onPump1PressTogglePress(int id) {
    // changeSwitchState(id);
    for (int i = 0; i < buttons.length; i++) {
      if (buttons[i].id == id) {
        buttons[i].isSelected = !buttons[i].isSelected;
        pump1State = buttons[i].isSelected;
        notifyListeners();

        break;
      }
    }

    action = pump1State ? "open" : "close";
    // تحديث قيمة الزر الخاص بالـ Pump1 فقط
    buttons.firstWhere((button) => button.id == 2).valuePerFix = pump1State ? "ON" : "OFF";
    socketManager.togglePump1(pump1State);
    //updateButtonData(pump1State ? "ON" : "OFF");
    notifyListeners();

  }


  void onFanPressTogglePress(int id) {
    // تحديث حالة الزر المحدد
    for (int i = 0; i < buttons.length; i++) {
      if (buttons[i].id == id) {
        buttons[i].isSelected = !buttons[i].isSelected;
        fanState = buttons[i].isSelected;
        notifyListeners();

        break;
      }
    }

    action = fanState ? "open" : "close";
    // تحديث قيمة الزر الخاص بالمروحة فقط
    buttons.firstWhere((button) => button.id == 1).valuePerFix = fanState ? "ON" : "OFF";
    socketManager.toggleFan(fanState);
    notifyListeners();

  }
  void onSolarLeftPress(int id) {
    socketManager.moveSolarPanelLeft();
    notifyListeners();
  }

  void onSolarRightPress(int id) {
    socketManager.moveSolarPanelRight();
    notifyListeners();
  }

  void close() {
    socketManager.disconnect();
  }
}
