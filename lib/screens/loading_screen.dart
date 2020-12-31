import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima/utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = new Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    getData();
  }

  void getData() async{
    http.Response response = await http.get('http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    if(response.statusCode == 200){
      String data = response.body;

      var temp = jsonDecode(data)['main']['temp'];
      var id = jsonDecode(data)['weather'][0]['id'];
      var name = jsonDecode(data)['name'];

      print(temp);
      print(id);
      print(name);

    }
    else
      print(response.statusCode);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
