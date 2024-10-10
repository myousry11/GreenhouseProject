import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class MisReportsScreen extends StatefulWidget {
  @override
  _MisReportsScreenState createState() => _MisReportsScreenState();
}

class _MisReportsScreenState extends State<MisReportsScreen> {
  List<dynamic> sensorData = []; // List to hold fetched data

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
      });
    } else {
      throw Exception('Failed to load sensor data');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sensor Readings',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: height * 0.5, // Adjust the height as needed
                width: width * 1.5, // Adjust the width as needed
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 20,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            // Example: Display timestamp as x-axis labels
                            return Text(_formatTimestamp(value.toInt()));
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 25,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            // Example: Display sensor reading as y-axis labels
                            return Text(value.toInt().toString());
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1),
                        left: BorderSide(color: Colors.grey, width: 1),
                        right: BorderSide(color: Colors.transparent, width: 1),
                        top: BorderSide(color: Colors.transparent, width: 1),
                      ),
                    ),
                    lineBarsData: [
                      _buildLineChartBar(_extractData(sensorData, 'temperature'), Colors.purple, 'Temperature (°C)'),
                      _buildLineChartBar(_extractData(sensorData, 'humidity'), Colors.blue, 'Humidity (%)'),
                      _buildLineChartBar(_extractData(sensorData, 'w_level'), Colors.red, 'Water Level (cm)'),
                      _buildLineChartBar(_extractData(sensorData, 'mq135'), Colors.yellowAccent, 'MQ135 Gas Sensor (ppm)'),
                      _buildLineChartBar(_extractData(sensorData, 'ph'), Colors.green, 'pH'),
                    ],
                  ),
                  duration: Duration(milliseconds: 250),
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendRow('Temperature', Colors.purple, width),
                  SizedBox(height: 25, width: 50,),
                  _buildLegendRow('Humidity', Colors.blue, width),
                  SizedBox(height: 25),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendRow('pH', Colors.green, width),
                  SizedBox(height: 25, width: 50,),
                  _buildLegendRow('MQ135', Colors.yellowAccent, width),
                  SizedBox(height: 25),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendRow('Water Level', Colors.red, width),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendRow(String label, Color color, double width) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
        ),
        SizedBox(width: width * 0.01),
        Text(label),
      ],
    );
  }

  List<double> _extractData(List<dynamic> data, String key) {
    return data.map((reading) {
      var value = reading[key];
      if (value is int) {
        return value.toDouble();
      } else if (value is double) {
        return value;
      } else {
        return double.tryParse(value.toString()) ?? 0.0;
      }
    }).toList();
  }

  LineChartBarData _buildLineChartBar(List<double> data, Color color, String label) {
    return LineChartBarData(
      spots: _generateSpots(data),
      isCurved: true,
      color: color,
      barWidth: 2,
      belowBarData: BarAreaData(show: false),
      dotData: FlDotData(show: false),
    );
  }

  List<FlSpot> _generateSpots(List<double> data) {
    return data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value);
    }).toList();
  }

  String _formatTimestamp(int value) {
    // Implement timestamp formatting logic if required
    return value.toString();
  }
}

