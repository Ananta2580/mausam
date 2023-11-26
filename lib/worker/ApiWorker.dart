import 'dart:convert';
import 'package:http/http.dart' as http;

class Worker {

  String location;
  Worker({required this.location}){
    location = location;
  }

  double airSpeed = 0.0;
  String humidity = "";
  double temperature = 0.0 ;
  String description = "";
  String weather = "";
  String iconData ="";
  double latitude=0.0;
  double longitude=0.0;

  Future<void> getData() async {
    try {
      final response = await http.get(
          Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=b66be7874327c68df679a3b0e8cdc9d6")
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> tempData = data['main'];
        final Map<String, dynamic> latLonData = data['coord'];

        final List<dynamic> weatherData = data['weather'];
        final String weatherMain = weatherData[0]['main'];
        final String desc = weatherData[0]['description'];
        final String Icon = weatherData[0]['icon'];

        final Map<String, dynamic> wind = data['wind'];
        final double getairSpeed = wind['speed'].toDouble();

        // Update class properties with fetched data
        temperature = double.parse(tempData['temp'].toString()) - 273.15;
        humidity = tempData['humidity'].toString();
        weather = weatherMain;
        iconData=Icon;
        description = desc;
        airSpeed = (getairSpeed * 3600)/1000 ;
        latitude = latLonData['lat'];
        longitude = latLonData['lon'];

      } else {
        // Handle the error based on the response status code
        if (response.statusCode == 404) {
          temperature = 0;
          humidity = "N/A";
          weather = "N/A";
          description = "N/A";
          airSpeed = 0;
          latitude=0;
          longitude=0;
        } else {
          print("Failed to fetch data. Status code: ${response.statusCode}");
          // Handle other error cases here as needed
        }
      }
    } catch (e) {
      // Handle other exceptions (e.g., network errors) here
      print("Error: $e");
      temperature = 0;
      humidity = "N/A";
      weather = "N/A";
      description = "N/A";
      airSpeed = 0;
    }
  }
}
