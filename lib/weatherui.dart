
import 'package:android_app/weathermodel.dart';
import 'package:android_app/weathernetwork.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WeatherUi extends StatefulWidget {
  const WeatherUi({super.key});

  @override
  State<WeatherUi> createState() => _WeatherUiState();
}
//api key import
final _weathernetwok = WeatherNetwork("d41b2fda88db9480a8b998e120dd6f3f");
Weather? _weather;
//fetch weather
fetchWeather()async{
  String cityName= await _weathernetwok.getCurrentCity();
  try{
    final weather = await _weathernetwok.getWeather(cityName);
    SetState(){
        _weather=weather;
    }
  }

catch(e){
print(e);
}  
}

@override
void initState() {
  initState();
  fetchWeather();
}

class _WeatherUiState extends State<WeatherUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
       Text(_weather?.cityName??"loading city name...."),
    ],
  ),
),      
    );
  }
}