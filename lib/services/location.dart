import 'package:geolocator/geolocator.dart';


// gets the location of current


class Location  {

  double  latitude;
  double longitude;


  Future<void> getCurrentLocation()async{

    try{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      latitude=position.latitude;
      longitude=position.longitude;
      print(position.toJson());
    }
    catch(e ){
      print("ups !");
      print(e);

    }

  }



}
