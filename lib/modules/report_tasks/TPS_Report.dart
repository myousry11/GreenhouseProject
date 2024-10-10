import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TbsScreen extends StatefulWidget {
  @override
  _TbsScreenState createState() => _TbsScreenState();
}

class _TbsScreenState extends State<TbsScreen> {
  List<dynamic>? sensorData;
  List<dynamic>? filteredData;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.60.46:3000/sensorReading'));
    if (response.statusCode == 200) {
      setState(() {
        sensorData = jsonDecode(response.body);
        filteredData = sensorData;
      });
    } else {
      throw Exception('Failed to load sensor data');
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = pickedDate.toIso8601String().split('T')[0];
      });
    }
  }

  void filterData() {
    String startDateStr = startDateController.text;
    String endDateStr = endDateController.text;

    if (startDateStr.isEmpty || endDateStr.isEmpty) {
      showAlertDialog('Please enter both start and end dates.');
      return;
    }

    DateTime? startDate = DateTime.tryParse(startDateStr);
    DateTime? endDate = DateTime.tryParse(endDateStr);

    if (startDate == null || endDate == null) {
      showAlertDialog('Invalid date format. Please use YYYY-MM-DD.');
      return;
    }

    if (startDate.isAfter(endDate)) {
      showAlertDialog('Start date cannot be after end date.');
      return;
    }

    setState(() {
      filteredData = sensorData!.where((sensor) {
        DateTime sensorDate = DateTime.parse(sensor['timestamp']);
        return sensorDate.isAfter(startDate) && sensorDate.isBefore(endDate);
      }).toList();
    });
  }

  void showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Date'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: startDateController,
                        decoration: InputDecoration(
                          labelText: 'Start Date ',
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, startDateController),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextField(
                        controller: endDateController,
                        decoration: InputDecoration(
                          labelText: 'End Date ',
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, endDateController),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: filterData,
                      child: Text('Filter'),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Timestamp')),
                      DataColumn(label: Text('Temperature (°C)')),
                      DataColumn(label: Text('Humidity (%)')),
                      DataColumn(label: Text('Water Level (%)')),
                      DataColumn(label: Text('MQ135 Gas Sensor (ppm)')),
                      DataColumn(label: Text('pH')),
                    ],
                    rows: filteredData?.map((sensor) {
                      return DataRow(cells: [
                        DataCell(Text(sensor['timestamp'] ?? '')),
                        DataCell(Text('${sensor['temperature'] ?? ''}')),
                        DataCell(Text('${sensor['humidity'] ?? ''}')),
                        DataCell(Text('${sensor['w_level'] ?? ''}')),
                        DataCell(Text('${sensor['mq135'] ?? ''}')),
                        DataCell(Text('${sensor['ph'] ?? ''}')),
                      ]);
                    }).toList() ??
                        [],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}