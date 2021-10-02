import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'result.dart';

import 'process_result.dart';

class CustomiseResult extends StatefulWidget {
  final String _longitude;
  final String _latitude;
  final String _longname;
  final String _shortname;
  final String _description;

 CustomiseResult(this._longitude, this._latitude, this._longname, this._shortname, this._description);

  @override
  _CustomiseResultState createState() => _CustomiseResultState();
}

class _CustomiseResultState extends State<CustomiseResult> {
  static final _temporalList = ["Daily", "Monthly", "Climatology"];
  List<String> _listYearStart = [];
  List<String> _listYearEnd = [];
  String _temporalAvg = "";
  String _startDate = "";
  String _endDate = "";
  String? _temporalValue;
  String? _yearMonthlyStartValue;
  String? _yearMonthlyEndValue;
  String? _yearClimatologyStartValue;
  String? _yearClimatologyEndValue;
  bool _isLoading = false;

  List<String> yearList(DateTime startDate, DateTime endDate) {
    List<String> years = [];
    for (int i = startDate.year; i <= (endDate.year - 1); i++) {
      years.add(i.toString());
    }
    return years;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xff1d1d1d),
      title:  const Text("Customise Result"),
      centerTitle: true,
    ),
    body: Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: const Alignment(0.0, -0.8),
          child: _selectTemporal()
        ),
        Align(
          alignment: const Alignment(0.0, 0.0),
          child: _showStartDate(_temporalAvg),
        ),
        Align(
          alignment: const Alignment(0.0, 0.5),
          child: _showEndDate(_temporalAvg)
        ),
        Align(
          alignment: const Alignment(0.0, 0.8),
          child: _showViewResult(),
        ),
      ],
    ),
  );

  // Create drop down list for temporal average
  Widget _selectTemporal() => DropdownButton<String>(
    dropdownColor: const Color(0xff222222),
    iconEnabledColor: const Color(0xffffc04d),
    value: _temporalValue,
    items: _temporalList.map(buildItem).toList(),
    hint: const Text(
      "Select Temporal",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    onChanged: (value) => setState(() {
      _temporalValue = value.toString();
      _temporalAvg = _temporalValue.toString();
      _resetSelectedDate();
    }),
  );

  // Reset selected date if change choice of temporal average
  _resetSelectedDate(){
    setState(() {
      _yearClimatologyEndValue = _yearClimatologyStartValue = _yearMonthlyEndValue = _yearMonthlyStartValue = null;
      _startDate = "";
      _endDate = "";
    });
  }

  // Show start date based on temporal average
  _showStartDate(String temporalAvg){
    if(temporalAvg == "Daily"){
      return _selectDailyStartDate();
    }
    else if(temporalAvg == "Monthly"){
      setState(() {
        _listYearStart = yearList(DateTime.utc(1984), DateTime.now());
      });
      return _selectMonthlyStartDate();
    }
    else if(temporalAvg == "Climatology"){
      setState(() {
        _listYearStart = yearList(DateTime.utc(1984), DateTime(DateTime.now().year - 1));
      });
      return _selectClimatologyStartDate();
    }
    else{
      null;
    }
  }

  // Show end date based on temporal average
  _showEndDate(String temporalAvg){
    if(temporalAvg == "Monthly"){
      setState(() {
        if(_yearMonthlyStartValue!=null){
          _listYearEnd = yearList(DateTime.utc(int.parse(_yearMonthlyStartValue.toString())), DateTime.now()); // Change the YearEnd list's start value to the current selected start value
        }
      });
      return _selectMonthlyEndDate();
    }
    else if(temporalAvg == "Climatology"){
      setState(() {
        if(_yearClimatologyStartValue!=null){
          _listYearEnd = yearList(DateTime.utc(int.parse(_yearClimatologyStartValue.toString())+1), DateTime.now()); // Change the YearEnd list's start value to the current selected start value
        }
      });
      return _selectClimatologyEndDate();
    }
    else{
      null;
    }
  }

  // Select date range for Daily temporal
  Widget _selectDailyStartDate() => ElevatedButton(
    onPressed: (){
      pickDateRange(context);
      },
    child: const Text("Select Date Range"),
    style: ElevatedButton.styleFrom(
      primary: const Color(0xffbfbfbf),
      onPrimary: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      textStyle: const TextStyle(fontSize: 18),
      shape: const StadiumBorder()
    ),
  );

  // Date range builder
  Future pickDateRange(BuildContext context) async{
    final initialDateRange = DateTimeRange(
      start: DateTime(DateTime.now().year - 1), 
      end: DateTime.now()
    );
    final newDateRange = await showDateRangePicker(
      context: context, 
      firstDate: DateTime.utc(1984,1,1), 
      lastDate: DateTime.now(),
      initialDateRange: initialDateRange,
    );

    if(newDateRange == null) return;

    setState(() {
      _startDate = DateFormat('yyyyMMdd').format(newDateRange.start);
      _endDate = DateFormat('yyyyMMdd').format(newDateRange.end);
    });
  }

  // Select start year for Monthly temporal
  Widget _selectMonthlyStartDate() => DropdownButton<String>(
    dropdownColor: const Color(0xff222222),
    iconEnabledColor: const Color(0xffFFB423),
    value: _yearMonthlyStartValue,
    items: _listYearStart.map(buildItem).toList(),
    hint: const Text(
      "Select Start Date",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    onChanged: (value) => setState(() {
      _yearMonthlyStartValue = value;
      if(_yearMonthlyEndValue!=null && int.parse(_yearMonthlyStartValue.toString()) > int.parse(_yearMonthlyEndValue.toString())){
        _resetSelectedDate();
      }
      _startDate = _yearMonthlyStartValue.toString();
    }),
  );

  // Select end year for Monthly temporal
  Widget _selectMonthlyEndDate() => DropdownButton<String>(
    dropdownColor: const Color(0xff222222),
    iconEnabledColor: const Color(0xffFFB423),
    value: _yearMonthlyEndValue,
    items: _listYearEnd.map(buildItem).toList(),
    hint: const Text(
      "Select End Date",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    onChanged: (value) => setState(() {
      _yearMonthlyEndValue = value;
      _endDate = _yearMonthlyEndValue.toString();
    }),
  );

// Select start year for Climatology temporal
  Widget _selectClimatologyStartDate() => DropdownButton<String>(
    dropdownColor: const Color(0xff222222),
    iconEnabledColor: const Color(0xffFFB423),
    value: _yearClimatologyStartValue,
    items: _listYearStart.map(buildItem).toList(),
    hint: const Text(
      "Select Start Date",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    onChanged: (value) => setState(() {
      _yearClimatologyStartValue = value;
      if(_yearClimatologyEndValue!=null && int.parse(_yearClimatologyStartValue.toString()) >= int.parse(_yearClimatologyEndValue.toString())){
        _resetSelectedDate();
      }
      _startDate = _yearClimatologyStartValue.toString();
    }),
  );

  // Select end year for Climatology temporal
  Widget _selectClimatologyEndDate() => DropdownButton<String>(
    dropdownColor: const Color(0xff222222),
    iconEnabledColor: const Color(0xffFFB423),
    value: _yearClimatologyEndValue,
    items: _listYearEnd.map(buildItem).toList(),
    hint: const Text(
      "Select End Date",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    onChanged: (value) => setState(() {
      _yearClimatologyEndValue = value;
      _endDate = _yearClimatologyEndValue.toString();
    }),
  );

  // Create items in the drop down
  DropdownMenuItem<String> buildItem(String item) =>
    DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
  );

  // Show the view result button
  Widget _showViewResult() => SizedBox(
  width: 205,
  height: 73,
  child: ElevatedButton(
    onPressed: _enableViewResult(), 
    child: _isLoading
      ? const CircularProgressIndicator(color: Colors.black)
      : const Text("View Result"),
    style: ElevatedButton.styleFrom(
      primary: const Color(0xffffc04d),
      onPrimary: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      )),
    ),
  );

  // Show view result button if date is present
  dynamic _enableViewResult(){
    if(_endDate!=""&&_startDate!=""){
      return(){
        _viewResult();
        if(_isLoading) return;
            setState(() {
              _isLoading = true;
        });
      };
    }
    else{
      return null;
    }
  }

  // View result process and push to result page
  _viewResult() async{
    String link = _createLink();
    ProcessResult result = ProcessResult(link, _chooseInBetweenType(), _temporalAvg, widget._shortname);
    // Initialise the result process with Weekly average if the temporal is Daily
    if(_temporalAvg == "Daily"){
      await result.initWeeklyProcess();
    }else{
      await result.initProcess();
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => Result(widget._longname, widget._description, result.valueList, result.inBetweenList, result.units, result.high, result.low, result.average)));
    setState(() {
      _isLoading = false;
    }); //for loading
  }

  // Return the dates/months between the start and end date according to the temporal.
  _chooseInBetweenType(){
    switch(_temporalAvg){
      case "Daily": {
        return getDaysInBetween(DateTime.parse(_startDate), DateTime.parse(_endDate));
      }
      case "Monthly": {
        return getYearMonthInBetween(int.parse(_startDate), int.parse(_endDate));
      }
      case "Climatology": {
        return ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
      }
    }
  }

  // Get all the dates in between two dates range. Require startDate and endDate
  List<String> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<String> daysFormatted = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      daysFormatted.add(
        DateFormat('yyyyMMdd').format(
          DateTime(
            startDate.year,
            startDate.month,
            startDate.day + i)
        )
      );
    }
    return daysFormatted;
  }

  // Get all the yyyyMM in between two dates range. Require startDate and endDate
  List<String> getYearMonthInBetween(int startDate, int endDate) {
    List<String> ym = [];
    for (int i = startDate; i <= endDate; i++){
      for (int z = 1; z <= 12; z++){
        if (z < 10){
          ym.add(i.toString() + "0" + z.toString());
        }else{
          ym.add(i.toString() + z.toString());
        }
      }
    }
    return ym;
  }

  // Create link to the API
  _createLink(){
    var parameter = widget._shortname;
    var longitude = widget._longitude;
    var latitude = widget._latitude;
    var temporal = _temporalAvg.toLowerCase();
    return "https://power.larc.nasa.gov/api/temporal/$temporal/point?parameters=$parameter&community=RE&longitude=$longitude&latitude=$latitude&start=$_startDate&end=$_endDate&format=JSON";
  }
}