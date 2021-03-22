import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hava_nasil/services/location.dart';
import '../services/networking.dart';

class WeatherModel {


  String appId="ff25faa4e4469c66854d455099391b80";



 Future<dynamic> getCity(String city) async {

    String URL="https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${appId}&units=metric";
    NetworkHelper networkHelper=NetworkHelper(URL:URL);
    var weatherData =await networkHelper.getData();
    return weatherData;

  }

  Future<dynamic> getLocation() async {
    Location x = Location();
    await x.getCurrentLocation();
    double lat = x.latitude;
    double lon = x.longitude;

    print(lat );
    print(lon);

    String URL="https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${appId}&units=metric";
    NetworkHelper networkHelper=NetworkHelper(URL:URL);
    var weatherData =await networkHelper.getData();
    return weatherData;

  }

  AssetImage getWeatherImage(String description) {
    if (description.toLowerCase() == "clear sky") {
      return AssetImage("images/sun.png");
    } else if (description.toLowerCase()  == "few clouds") {
      return AssetImage("images/partly-cloudy.png");
    } else if (description.toLowerCase()  == "scattered clouds" || description .toLowerCase() == "broken clouds") {
      return AssetImage("images/cloud.png");
    } else if (description .toLowerCase() == "	rain" || description == "shower rain") {
      return AssetImage("images/rain.png");
    } else if (description .toLowerCase() == "	thunderstorm") {
      return AssetImage("images/cloud-lightning.png");
    } else {
      return AssetImage("images/404.png");
    }
  }

  DecorationImage getStateImage(String description) {
    return DecorationImage(
        image: getWeatherImage(description), fit: BoxFit.cover);
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
