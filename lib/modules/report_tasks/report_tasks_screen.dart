import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'MIS_Report.dart';
import 'TPS_Report.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late MyData _data;

  @override
  void initState() {
    super.initState();
    _data = MyData(_generateData());
  }

  List<Map<String, dynamic>> _generateData() {
    return [
      {
        'sensor': 'Temperature',
        'value': 25,
        'date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
        'time': DateFormat('HH:mm:ss').format(DateTime.now()),
      },
      {
        'sensor': 'PH',
        'value': 1000,
        'date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
        'time': DateFormat('HH:mm:ss').format(DateTime.now()),
      },
      {
        'sensor': 'Humidity',
        'value': 50,
        'date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
        'time': DateFormat('HH:mm:ss').format(DateTime.now()),
      },
      {
        'sensor': 'CO2 Gas',
        'value': 50,
        'date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
        'time': DateFormat('HH:mm:ss').format(DateTime.now()),
      },
      {
        'sensor': 'Water Level',
        'value': 50,
        'date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
        'time': DateFormat('HH:mm:ss').format(DateTime.now()),
      },
      {
        'sensor': 'Battery',
        'value': 50,
        'date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
        'time': DateFormat('HH:mm:ss').format(DateTime.now()),
      },
      // Add more data as needed
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Consumer<FilterModel>(
            builder: (context, filterModel, _) => ToggleButtons(
              borderRadius: BorderRadius.circular(10),
              selectedColor: Theme.of(context).primaryColor,
              fillColor: Colors.teal.shade100,
              isSelected: filterModel.isSelected,
              onPressed: (index) => filterModel.toggleFilter(index),
              children: <Widget>[
                Text('TPS'),
                Text('MIS'),
              ],
            ),
          ),
          Expanded(
            child: Consumer<FilterModel>(
              builder: (context, filterModel, _) =>
              filterModel.isSelected[0] ? TbsScreen() : MisReportsScreen(),
            ),
          ),
        ],
      ),
    );
  }
}

class MyData extends DataTableSource {
  late List<Map<String, dynamic>> _data;

  MyData(List<Map<String, dynamic>> data) : _data = data;

  void updateValue(int index, int newValue) {
    _data[index]['value'] = newValue;
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['sensor'].toString())),
      DataCell(Text(_data[index]['value'].toString())),
      DataCell(Text(_data[index]['date'].toString())),
      DataCell(Text(_data[index]['time'].toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
class FilterModel extends ChangeNotifier {
  List<bool> _isSelected = [true, false];

  List<bool> get isSelected => _isSelected;

  void toggleFilter(int index) {
    _isSelected = List.generate(_isSelected.length, (idx) => idx == index);
    notifyListeners(); // يعلم Provider بأن الحالة قد تغيرت
  }
}
