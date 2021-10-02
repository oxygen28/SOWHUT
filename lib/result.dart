import 'package:flutter/material.dart';
import 'charts.dart';

class Result extends StatelessWidget {
  final String _longname;
  final String _description;
  final List<double> _valueList;
  final List<String> _inBetweenList;
  final String _units;
  final double _high;
  final double _low;
  final double _average;

  Result(this._longname, this._description, this._valueList, this._inBetweenList, this._units, this._high, this._low, this._average);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xff1d1d1d),
      title: const Text("Result"),
      centerTitle: true,
    ),
    body: Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: const Alignment(0.0, -1.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                _longname,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                _description,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment(0.0, -0.47),
          child: Text(
            "Chart",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              // decoration: TextDecoration.underline,
              ),
            ),
        ),
        Align(
          alignment: const Alignment(0.0, -0.1),
          child: Charts(_valueList, _inBetweenList, _units, _high, _low),
        ),
        Align(
          alignment: const Alignment(0.0, 0.4),
          child: Text(
            "High: $_high $_units",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        Align(
          alignment: const Alignment(-0.0, 0.6),
          child: Text(
            "Low: $_low $_units",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        Align(
          alignment: const Alignment(-0.0, 0.8),
          child: Text(
            "Average: $_average $_units",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ],
    ),
  );
}