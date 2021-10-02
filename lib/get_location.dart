import 'package:flutter/material.dart';
import 'package:location/location.dart';

class GetLocation extends StatefulWidget {
  final Function(String, String, bool) callback;

  GetLocation(this.callback);

  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool _isGetLocation = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 240,
    height: 75,
    child: ElevatedButton(onPressed: () async{
      if(_isLoading) return;
      setState(() {
        _isLoading = true;
      });
      _serviceEnabled = await location.serviceEnabled();
      if(!_serviceEnabled){
        _serviceEnabled = await location.requestService();
        if(!_serviceEnabled) return;
      }
      
      _permissionGranted = await location.hasPermission();
      if(_permissionGranted == PermissionStatus.denied){
        _permissionGranted = await location.requestPermission();
        if(_permissionGranted != PermissionStatus.granted) return;
      }

      _locationData = await location.getLocation();
      setState(() {
        _isLoading = false;
        _isGetLocation = true;
      });

      widget.callback(_locationData.longitude.toString(), _locationData.latitude.toString(), _isGetLocation);
    },
    child: _isLoading
      ? const CircularProgressIndicator(color: Colors.black)
      : const Text("Get Current Location"),
    style: ElevatedButton.styleFrom(
      primary: const Color(0xffbfbfbf),
      onPrimary: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      textStyle: const TextStyle(fontSize: 20),
      shape: const StadiumBorder()
      ),
    ),
  );
}