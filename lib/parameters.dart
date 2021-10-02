import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'parameters_list.dart';
import 'customise_result.dart';

class ParameterList extends StatelessWidget {
  String _longitude = "";
  String _latitude = "";

  ParameterList(String longitude, String latitude){
    _longitude = longitude;
    _latitude = latitude;
  }

  void click(String longitude, String latitude, String description, String shortname, String longname, BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => CustomiseResult(longitude, latitude, longname, shortname, description)));
  }

  @override   
  Widget build(BuildContext context) => DefaultTabController(
    length: 4,
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1d1d1d),
        title: const Text("Parameters"),
        centerTitle: true,
        bottom: const TabBar(
          isScrollable: true,
          indicatorWeight: 3.0,
          indicatorColor: Color(0xffffc04d),
          labelStyle: TextStyle(
            fontSize: 20.0,
            color: Color(0xffFfffff), //FFB423 , F0FFF3
          ),
          tabs: [
            Tab(text: "Solar"),
            Tab(text: "Wind"),
            Tab(text: "Humidity"),
            Tab(text: "Temperature"),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          _createListView(solarList),
          _createListView(windList),
          _createListView(humidityList),
          _createListView(temperatureList),
        ],
      ),
    ),
  );

  Widget _createListView(List list) => ListView.builder(
    itemCount: list.length,
    itemBuilder: (context,index) => Container(
      margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xff222222),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          list[index]["longname"],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          list[index]["description"],
          style: const TextStyle(color: Colors.white60),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: (){
            click(_longitude, _latitude, list[index]["description"], list[index]["shortname"], list[index]["longname"], context);
          },
          icon: const Icon(Icons.arrow_forward),
          iconSize: 30,
          color: const Color(0xffffc04d),
        ),
      ),
    ),
  );
}