
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hava_nasil/services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  WeatherModel _weatherModel=WeatherModel();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocationScreen();
  }

  Future<void> getLocationScreen() async {

    var weatherData =await _weatherModel.getLocation();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        LocationScreen(locationWeather: weatherData),
    ));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.blueGrey[100],
      body: Center(
        child: SpinKitRotatingPlain(

          color: Colors.blueGrey[900],
          size: 50.0,
        ),
      ),
    );
  }
}


