
import 'dart:convert';

import 'package:android_app/weathermodel.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;

class WeatherNetwork{
String url="http://api.openweathermap.org/data/2.5/weather";
final String apikey; 

WeatherNetwork(this.apikey);

Future<Weather> getWeather (String cityName) async{
final response = await http.get(Uri.parse("$url?q=$cityName&apiid=$apikey&units=metric"));

//http://api.openweathermap.org/data/2.5/weather?q=London&apiid=$d41b2fda88db9480a8b998e120dd6f3f&units=metric
if(response.statusCode==200){
return Weather.fromJson(jsonDecode(response.body));
}
else{
  throw Exception("unable to load data");
}
}
Future<String> getCurrentCity() async{
  LocationPermission permission= await Geolocator.checkPermission();
  if (permission == LocationPermission.denied){
    permission  = await Geolocator.requestPermission();
  }

Position position = await Geolocator.getCurrentPosition(
  desiredAccuracy: LocationAccuracy.high
);


List <Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

String? city = placemarks[0].locality;
return city ?? "";
  }

}
