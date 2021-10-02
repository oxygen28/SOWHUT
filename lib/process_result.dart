import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProcessResult{
  final String _link ;
  List<String> _inBetweenList;
  final String _temporalAvg;
  final String _shortname;
  late String _units;
  late double _high;
  late double _low;
  late double _average;
  List<double> _valueList = [];

  ProcessResult(this._link, this._inBetweenList, this._temporalAvg, this._shortname);

  List<double> get valueList{
    return _valueList;
  }

  List<String> get inBetweenList{
    return _inBetweenList;
  }

  String get units{
    return _units;
  }

  double get high{
    return _high;
  }

  double get low{
    return _low;
  }

  double get average{
    return _average;
  }

  // Make the dates/months readable
  List<String> makeReadable(String temporalAvg, List<String> inBetweenList){
    List<String> tempList = [];
    if(temporalAvg == "Daily"){
      for(var i in inBetweenList){
        tempList.add(i.substring(6,8) + "/" + i.substring(4,6) + "/" + i.substring(0,4));
      }
    }
    else if(temporalAvg == "Monthly"){
      for(var i in inBetweenList){
        tempList.add(i.substring(4,6) + "/" + i.substring(0,4));
      }
    }
    else{
      tempList = inBetweenList;
    }
    return tempList;
  }

  // Return the value list from the json data
  List<double> getValue(jsonData, shortname){
    List<double> tempList = [];
    for(var i in _inBetweenList){
      tempList.add(jsonData['properties']['parameter'][shortname][i]);
    }
    return tempList;
  }

  // Return units from the json data
  String getUnits(jsonData, shortname){
    String units;
    units = jsonData['parameters'][shortname]['units'];
    return units;
  }

  // Remove the value from list with invalid value
  List popValue(valuelist, readinbetweenlist){
    List<double> tempValueList = [];
    List<String> tempReadableList = [];
    for(var i = 0; i < valuelist.length; i++){
      if(valuelist[i] != -999.0){
        tempValueList.add(valuelist[i]);
        tempReadableList.add(readinbetweenlist[i]);
      }
    }
    return [tempValueList, tempReadableList];
  }

  // Calculate the low, high and average value of the data
  List calcMMA(valueList){
    List<double> valuelist = valueList;
    double low;
    double high;
    double average;
    low = valuelist.reduce(min);
    high = valuelist.reduce(max);
    average = double.parse(((valuelist.reduce((value, element) => value + element))/valuelist.length).toStringAsFixed(2));
    return [low, high, average];
  }

  // Calculate the Weekly average
  List calcWeeklyAvg(valueList, readableList){
    List<double> tempValueList = [];
    List<double> newValueList = [];
    List<String> tempReadableList = [];
    int last = valueList.length;

    for(var start = 0; start < last; start+=7){
      if(7>valueList.length){
        int interval = valueList.length;
        tempValueList = valueList.sublist(0,interval);
        valueList.removeRange(0,interval);
        tempReadableList.add(readableList[start]);
      }
      else{
        tempValueList = valueList.sublist(0,7);
        valueList.removeRange(0,7);
        tempReadableList.add(readableList[start]);
      }
      
      newValueList.add(double.parse(((tempValueList.reduce((value, element) => value + element))/tempValueList.length).toStringAsFixed(2)));
    }
    valueList = newValueList;
    readableList = tempReadableList;
    return [valueList, readableList];
  }

  // Initialise the result process.
  initProcess() async{
    var jsonData = await _getData();
    _valueList = getValue(jsonData,_shortname);
    _inBetweenList = makeReadable(_temporalAvg, _inBetweenList);
    _units = getUnits(jsonData, _shortname);
    List tempList = popValue(_valueList, _inBetweenList);
    _valueList = tempList[0];
    _inBetweenList = tempList[1];
    List mma = calcMMA(_valueList);
    _low = mma[0];
    _high = mma[1];
    _average = mma[2];
  }

  // Initialise the result process with Weekly Average.
  initWeeklyProcess() async{
    var jsonData = await _getData();
    _valueList = getValue(jsonData,_shortname);
    _inBetweenList = makeReadable(_temporalAvg, _inBetweenList);
    _units = getUnits(jsonData, _shortname);
    List tempList = popValue(_valueList, _inBetweenList);
    _valueList = tempList[0];
    _inBetweenList = tempList[1];
    var calcweek = calcWeeklyAvg(_valueList, _inBetweenList);
    _valueList = calcweek[0];
    _inBetweenList = calcweek[1];
    List mma = calcMMA(_valueList);
    _low = mma[0];
    _high = mma[1];
    _average = mma[2];
  }

  // GetJsonData
  _getData() async {
    // Parse the API's URL
    var url = Uri.parse(_link);
    // Get the data from the API
    var response = await http.get(url);
    // Decode the data into JSON format
    return jsonDecode(response.body);
  }
}