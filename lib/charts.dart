import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Charts extends StatefulWidget {
  final List<double> _valueList; // Y-axis
  final List<String> _inBetweenList; //X-axis
  final String _units;
  final double _high;
  final double _low;
  Charts(this._valueList, this._inBetweenList, this._units, this._high, this._low);

  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  List<Color> chartColour = [
    const Color(0xffffc04d),
  ];

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.all(10.0),
    child: AspectRatio(
      aspectRatio: 1.70,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: widget._inBetweenList.length * 32,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Color(0xff222222)),
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0, left: 12.0, top: 24, bottom: 18),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ),
    ), 
  );

  LineChartData mainData() => LineChartData(
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
          maxContentWidth: 100,
          tooltipBgColor: const Color(0xff272727),
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItems: (touchedSpots) => touchedSpots.map((LineBarSpot touchedSpot) {
              const textStyle = TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,  
                fontSize: 12,
              );
              return LineTooltipItem(
                '${widget._inBetweenList[touchedSpot.x.toInt()]}\n ${touchedSpot.y.toString()} ${widget._units}', textStyle);
            }).toList()
          ),
      handleBuiltInTouches: true,
      getTouchLineStart: (data, index) => 0,
    ),
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      getDrawingHorizontalLine: (value) => FlLine(
        color: const Color(0x4dffffff),
        strokeWidth: 1,
      ),
      getDrawingVerticalLine: (value) => FlLine(
        color: const Color(0x4dffffff),
        strokeWidth: 1,
      ),
    ),
    axisTitleData: FlAxisTitleData(
      leftTitle: AxisTitle(
        showTitle: true,
        titleText: widget._units,
        textStyle: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 11),
      ),
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: (widget._inBetweenList[0].length * 4).toDouble(),
        rotateAngle: -45,
        interval: 2,
        getTextStyles: (context, value) =>
            const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 11),
        getTitles: (value) => widget._inBetweenList[value.toInt()],
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => const TextStyle(
          color: Colors.white54,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        getTitles: (value) => value.toStringAsFixed(2),
        reservedSize: 32,
        margin: 12,
      ),
    ),
    borderData:
        FlBorderData(show: true, border: Border.all(color: const Color(0x4dffffff), width: 3)),
    minX: 0,
    maxX: (widget._inBetweenList.length.toDouble() - 1),
    minY: widget._low - 0.5,
    maxY: widget._high + 0.5,
    lineBarsData: [
      LineChartBarData(
        spots: widget._valueList.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
        isCurved: true,
        colors: chartColour,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors: chartColour.map((color) => color.withOpacity(0.3)).toList(),
        ),
      ),
    ],
  );
}