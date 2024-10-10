import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartGraph extends StatefulWidget {
  final double width;
  final double height;

  const ChartGraph({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  State<ChartGraph> createState() => _ChartGraphState();
}

class _ChartGraphState extends State<ChartGraph> {
  String? _selectedOption ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Dropdown(
              onChanged: (String? value) {
                setState(() {
                  _selectedOption = value;
                });
              },
              selectedOption: _selectedOption, // Pass the selected option to Dropdown
            ),
          ),
          SizedBox(height: 30),
          if (_selectedOption != null)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Padding(
                  padding: const EdgeInsets.only(top: 45.0, right: 10),
                  child: Container(
                    width: widget.width,
                    height: widget.height - 330,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: LineChart(
                      LineChartData(
                        // Your existing chart data
                        minX: 1,
                        maxX: 12,
                        minY: 0,
                        maxY: 100,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        lineBarsData: [
                          LineChartBarData(
                            spots: _getChartSpots(_selectedOption!),
                            isCurved: true,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff248176),
                                Color(0xffCEDCA0),
                              ],
                            ),
                            barWidth: 3,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff248176).withOpacity(0.3),
                                  Color(0xffCEDCA0).withOpacity(0.3),
                                ],
                              ),
                            ),
                            dotData: FlDotData(
                              show: true,
                            ),
                          ),
                        ],
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: Colors.grey.shade200,
                            tooltipBorder: BorderSide(
                              width: 3.0,
                              color: Color(0xff248176),
                            ),
                          ),
                          handleBuiltInTouches: true,
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawHorizontalLine: false,
                          drawVerticalLine: false,
                          getDrawingVerticalLine: (value) {
                            return FlLine(
                              color: Colors.grey,
                              strokeWidth: 0.5,
                            );
                          },
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 25,
                              interval: 25,
                              getTitlesWidget: (value, meta) {
                                String text = '';
                                switch (value.toInt()) {
                                  case 0:
                                    text = "";
                                    break;
                                  case 25:
                                    text = "25";
                                    break;
                                  case 50:
                                    text = "50";
                                    break;
                                  case 75:
                                    text = "75";
                                    break;
                                  case 100:
                                    text = "100";
                                    break;
                                  default:
                                    return Container();
                                }
                                return Text(
                                  text,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 20,
                              getTitlesWidget: (value, meta) {
                                String text = '';
                                switch (value.toInt()) {
                                  case 0:
                                    text = "0";
                                    break;
                                  case 1:
                                    text = "1";
                                    break;
                                  case 2:
                                    text = "2";
                                    break;
                                  case 3:
                                    text = "3";
                                    break;
                                  case 4:
                                    text = "4";
                                    break;
                                  case 5:
                                    text = "5";
                                    break;
                                  case 6:
                                    text = "6";
                                    break;
                                  case 7:
                                    text = "7";
                                    break;
                                  case 8:
                                    text = "8";
                                    break;
                                  case 9:
                                    text = "9";
                                    break;
                                  case 10:
                                    text = "10";
                                    break;
                                  case 11:
                                    text = "11";
                                    break;
                                  case 12:
                                    text = "12";
                                    break;
                                  default:
                                    return Container();
                                }
                                return Text(
                                  text,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<FlSpot> _getChartSpots(String selectedOption) {
    switch (selectedOption) {
      case 'Day':
        return [
          FlSpot(1, 25),
          FlSpot(2, 30),
          FlSpot(3, 50),
          FlSpot(4, 70),
          FlSpot(5, 100),
          FlSpot(6, 20),
          FlSpot(7, 60),
          FlSpot(8, 70),
          FlSpot(9, 45),
          FlSpot(10, 90),
          FlSpot(11, 80),
          FlSpot(12, 65),
        ];
      case 'Week':
        return [
          FlSpot(1, 40),
          FlSpot(2, 45),
          FlSpot(3, 65),
          FlSpot(4, 85),
          FlSpot(5, 90),
          FlSpot(6, 30),
          FlSpot(7, 70),
          FlSpot(8, 80),
          FlSpot(9, 55),
          FlSpot(10, 100),
          FlSpot(11, 90),
          FlSpot(12, 75),
        ];
      case 'Month':
        return [
          FlSpot(1, 20),
          FlSpot(2, 25),
          FlSpot(3, 45),
          FlSpot(4, 65),
          FlSpot(5, 80),
          FlSpot(6, 50),
          FlSpot(7, 50),
          FlSpot(8, 60),
          FlSpot(9, 35),
          FlSpot(10, 80),
          FlSpot(11, 70),
          FlSpot(12, 55),
        ];
      default:
        return [];
    }
  }
}

class Dropdown extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String? selectedOption; // Add selectedOption field

  const Dropdown({Key? key, this.onChanged, this.selectedOption}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        DropdownButton<String>(
          hint: Text(selectedOption ?? 'Select'), // Show selected option or 'Select'
          value: selectedOption,
          onChanged: onChanged,
          items: <String>['Day', 'Week', 'Month'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}




