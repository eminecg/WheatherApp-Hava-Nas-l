import 'package:flutter/material.dart';
import 'package:hava_nasil/screens/loading_screen.dart';
import'../services/weather.dart';
class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  TextEditingController _controller=TextEditingController();
  LoadingScreen _loadingScreen=LoadingScreen();


  int temperature;
  String cityName;
  String weatherMessage;
  String description;
  int minTemp;
  int maxTemp;
  String message;
  DecorationImage weatherImage;

    WeatherModel _weather=WeatherModel();

  @override
  void dispose() {

    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

 void updateUI(dynamic weatherData)  {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        description = '';
        return;
      }
      num temp = weatherData['main']['temp'];
      temperature=temp.toInt();



      num DminTemp = weatherData['main']['temp_min'];
      minTemp=DminTemp.toInt();

      num DmaxTemp = weatherData['main']['temp_max'];
      maxTemp=DmaxTemp.toInt();

      var condition = weatherData['weather'][0]['id'];
      description = weatherData['weather'][0]['description'];
      // weatherIcon = weather.getWeatherIcon(condition);
      //weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
      message=_weather.getMessage((temperature-272.15).toInt());
      weatherImage=_weather.getStateImage(description);

    });



  }
  TextStyle tempStyle1=TextStyle(
  color: Colors.amberAccent,
  fontSize: 20,
  decoration: TextDecoration.none);

  TextStyle tempStyle2=TextStyle(
      color: Colors.white,
      fontSize: 30,
      decoration: TextDecoration.none);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // to avoid overflowed by the keyword open
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions:[ IconButton(
          icon:Icon(Icons.my_library_add,color:Colors.white),
          onPressed: (){

          },
        ),],
        backgroundColor:  Color(0xff060918),
       title: TextField(

         controller: _controller,
       onSubmitted: (text) async {
           print(text);
          var cityWeather = await _weather.getCity(text.toLowerCase().trim());
           updateUI(cityWeather);

       },
         decoration: InputDecoration(
           icon:Icon(Icons.location_city_rounded,color: Colors.white,),
           border: OutlineInputBorder(
             borderSide: BorderSide.none,
             borderRadius:BorderRadius.all(Radius.circular(10)),gapPadding: 0.0),
           hintText: ' City..',
           filled:true,
           hintStyle: TextStyle(fontSize: 18),




         ),
       ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xff060918),
        ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            minimum: EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                Row(
                  children: [
                    IconButton(icon:Icon(Icons.location_pin),
                      onPressed: () async{
                        var weatherData=await _weather.getLocation();
                      updateUI(weatherData);

                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(cityName,
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 300,
                        width: 350,
                        decoration: BoxDecoration(
                          image:DecorationImage(
                              image: AssetImage("images/worldMAP.png"),
                              colorFilter: ColorFilter.mode(
                                  Colors.grey[800], BlendMode.modulate),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              image:weatherImage,

                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(description.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none)),
                        SizedBox(
                          height: 15,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  " " + (temperature).toStringAsFixed(0),
                                  style:tempStyle2),
                              Text("°",
                                  style: tempStyle1),
                            ]),
                        SizedBox(
                          height: 15,
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Text(
                                  (maxTemp ).toStringAsFixed(0) ,
                                  style:tempStyle2),
                              Text("°",
                                  style: tempStyle1),
                              Text(" / ",
                                  style: tempStyle1),
                              Text( (minTemp ).toStringAsFixed(0), style:tempStyle2),
                              Text("°",
                                  style: tempStyle1),
                            ]),
                        SizedBox(height: 40,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(message,style: TextStyle(fontSize: 27),),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
