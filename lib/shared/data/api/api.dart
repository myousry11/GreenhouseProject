import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  late IO.Socket socket;
  late bool isPump1 = false;
  late bool isPump2 = false;
  late bool isLed = false;
  late bool isFanOn = false;
  late bool isLedOn = false;
  SocketManager() {
    connectToSocket();
  }

  void connectToSocket() {
    socket = IO.io('http://192.168.60.46:3000/', {
      'transports': ['websocket'],
      'autoconnect': false
    });
    socket.connect();
    socket.onConnect((data) {
      print(data);
      print('connect');
    });

    socket.onDisconnect((_) {
      print('Disconnected');
    });

    socket.on('sensors_reads', (data) {
      print(data);
    });
    socket.on('fan_state', (data) {
      print('Fan state: $data');
      isFanOn = data == 'on';
    });
    socket.on('pump1_state', (data) {
      print('Pump state: $data');
      isPump1 = data == 'on';
    });
    socket.on('pump2_state', (data) {
      print('Pump2 state: $data');
      isPump2 = data == 'on';
    });
    socket.on('led_state', (data) {
      print('Led state: $data');
      isLedOn = data == 'on';
    });
    socket.on('control_sp', (data) {
      print('Control Solar: $data');
      isPump2 = data == 'on';
    });
  }

  void emitData(Map<String, dynamic> data) {
    socket.emit('sensors_reads', data);
  }

  void listenToData(void Function(dynamic) onData) {
    socket.on('sensors_reads', onData);
  }

  void toggleFan(bool val) {
    socket.emit('control_fan', {
      'action': val ? "open" : "close",
    });
  }

  void togglePump1(bool val) {
    socket.emit('control_pump1', {
      'action': val ? "on" : "off",
    });
  }

  void togglePump2(bool val) {
    socket.emit('control_pump2', {
      'action': val ? "on" : "off",
    });
  }

  void toggleLed(bool val) {
    socket.emit('control_led', {
      'action': val ? "on" : "off",
    });
  }

  // إضافة الدوال لتحريك لوحة الطاقة الشمسية
  void moveSolarPanelLeft() {
    socket.emit('event_name', {
      'action': "off",
    });
  }

  void moveSolarPanelRight() {
    socket.emit('event_name', {
      'action': "on",
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
