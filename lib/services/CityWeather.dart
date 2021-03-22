import 'package:flutter/material.dart';

class CityWeather {

 final int temperature;
 final String cityName;
 final String weatherMessage;
 final String description;
 final int minTemp;
 final  int maxTemp;
 final  String message;
 final DecorationImage weatherImage;

 CityWeather(
      this.temperature,
      this.cityName,
      this.weatherMessage,
      this.description,
      this.minTemp,
      this.maxTemp,
     this.message,
      this.weatherImage);


}






