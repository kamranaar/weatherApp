import 'dart:convert';
import 'package:http/http.dart' as http;

class worker {
  String? location;
  String? temp;
  String? humidity;
  double? air_speed;
  String? description;
  String? main;
  String? icon;

  worker({this.location}) {
    // Assign the location parameter to the instance variable
    this.location = location;
    
  }

  Future<void> getData() async {
    try {
      http.Response response = await http.get(Uri.parse(
          "http://api.openweathermap.org/data/2.5/weather?q=$location&appid=e34a5eb0b4c5ff748fdf9219a63d224e"));
      Map data = jsonDecode(response.body);

      //Getting Temp,Humidiy
      Map temp_data = data['main'];
      String getHumidity = temp_data['humidity'].toString();
      double getTemp = temp_data['temp'];

//Getting air_speed
      Map wind = data['wind'];
      double getAir_speed = wind["speed"];

      //Getting Description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data["description"];
      String getIcon = weather_main_data["icon"];

      //Assigning Values
      temp = getTemp.toString();
      humidity = getHumidity;
      air_speed = getAir_speed;
      description = getDesc;
      main = getMain_des;
      icon = getIcon.toString();

      print(
          'location is $location, air_speed is $air_speed, temperature is $temp');
    } catch (e) {
      temp = 'No data available';
      humidity = 'No data available';
      air_speed = 0.0;
      description = 'No data available';
      main = 'No data available';
      icon = '03n';
    }
  }
}
