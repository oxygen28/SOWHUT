import 'package:flutter/material.dart';
import 'package:sowhut/about.dart';
import 'get_location.dart';
import 'parameters.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _longitude = "Longitude";
  String _latitude = "Latitude";
  bool _isGetLocation = false;

  void setLocation(String longitude, String latitude, bool isGetLocation){
    setState(() {
      _longitude = longitude;
      _latitude = latitude;
      _isGetLocation = isGetLocation;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xff1d1d1d),
      title: const Text("SOWHUT"),
      centerTitle: true,
    ),
    body: Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: const Alignment(0.0, -0.8),
          child: _showLoctationContainer(_longitude, _latitude)
        ),
        Align(
          alignment: const Alignment(0.0, 0.0),
          child: GetLocation(setLocation),
        ),
        Align(
          alignment: const Alignment(0.0, 0.85),
          child: _showSelectParameter(_longitude, _latitude),
        ),
        Align(
          alignment: const Alignment(0.0, 1.0),
          child: _showAbout(),
        ),
      ],
    ),
  );

  Widget _showLoctationContainer(String longitude, String latitude) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _createLocationContainer(longitude),
      _createLocationContainer(latitude)
    ],
  );

  Widget _createLocationContainer(String location) => Container(
    decoration: const BoxDecoration(
      color: Color(0xff222222),
      borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    padding: const EdgeInsets.all(20.0),
    margin: const EdgeInsets.all(20.0),
    width: 240,
    alignment: Alignment.center,
    child: Text(
      location,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ), 
    ),
  );

  Widget _showSelectParameter(String longitude, String latitude) => SizedBox(
    width: 240,
    child: ElevatedButton(
      onPressed: _enableSelectParameter(_isGetLocation), 
      child: const Text("Select Parameter"),
      style: ElevatedButton.styleFrom(
        primary: const Color(0xffffc04d),
        onPrimary: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )
      ),
    ),
  );

  dynamic _enableSelectParameter(bool isGetLocation){
    if(isGetLocation){
      return(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ParameterList(_longitude, _latitude)));
      };
    }
    else{
      return null;
    }
  }

  Widget _showAbout() => TextButton(
    onPressed: () => Navigator.push(
      context, MaterialPageRoute(builder: (context) => const AboutPage()
     )
    ), 
    child: const Text("About"),
    style: TextButton.styleFrom(
      primary: Colors.white,
    ),
  );


}