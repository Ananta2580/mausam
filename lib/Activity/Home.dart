import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var count = 1;
  bool isLoading = false; // Add a loading indicator flag

  @override
  void initState() {
    super.initState();
    print("Init state");
  }

  DecorationImage getBackgroundImage(String weatherCondition) {
    switch (weatherCondition) {
      case 'sunny':
        return const DecorationImage(
          image: AssetImage("assets/Images/night.jpg"),
          fit: BoxFit.cover, // You can adjust the fit as per your needs
        );
      case 'rainy':
        return const DecorationImage(
          image: AssetImage("assets/Images/rainy.jpg"),
          fit: BoxFit.cover, // You can adjust the fit as per your needs
        );
      case 'snowy':
        return const DecorationImage(
          image: AssetImage("assets/Images/snowy.jpg"),
          fit: BoxFit.cover, // You can adjust the fit as per your needs
        );
      default:
        return const DecorationImage(
          image: AssetImage("assets/Images/night.jpg"),
          fit: BoxFit.cover, // You can adjust the fit as per your needs
        );
    }
  }
  TextEditingController searchController = TextEditingController();
  MapController mapController = MapController();

  LatLng center = const LatLng(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    String temp = "N/A";
    String air = "N/A";

    var cityName = ["Bhubaneswar", "Bihar", "London", "Spain"];
    final random = Random();
    var city = cityName[random.nextInt(cityName.length)];

    final Map<String, dynamic>? info =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (info != null) {
      final double tempValue = (info["temp_value"] as double?) ?? 0.0;
      final String humValue = (info["hum_value"] as String?) ?? "N/A";
      final double airValue = (info["airS_value"] as double?) ?? 0.0;
      final double latValue = (info["lat_value"] as double?) ?? 0.0;
      final double lonValue = (info["lon_value"] as double?) ?? 0.0;
      final String descValue = (info["desc_value"] as String?) ?? "N/A";
      final String weathValue = (info["weath_value"] as String?) ?? "N/A";
      final String iconValue = (info["icon_value"] as String?) ?? "N/A";
      final String cityValue = (info["city_value"] as String?) ?? "N/A";
      print(weathValue);

      setState(() {
        center = LatLng(latValue, lonValue);
      });

      // if (tempValue == 0.0) {
      //   print("N/A");
      // } else {
      //   temp = (tempValue.toString()).substring(0, 2);
      //   air = (airValue.toString()).substring(0, 4);
      // }

      if (tempValue == 0.0) {
        temp = "N/A";
      } else {
        final tempString = tempValue.toString();
        temp = tempString.length >= 2 ? tempString.substring(0, 2) : tempString;
      }

      if (airValue == 0.0) {
        air = "N/A";
      } else {
        final airString = airValue.toString();
        air = airString.length >= 4 ? airString.substring(0, 4) : airString;
      }

      return RefreshIndicator(
        onRefresh: () async {
          // Simulate data loading with a delay
          setState(() {
            isLoading = true; // Set loading flag to true
          });
          await Future.delayed(const Duration(seconds: 2));

          // Update your data and UI state here

          setState(() {
            isLoading = false; // Set loading flag to false
          });
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.square(0),
            child: Container(
              decoration: BoxDecoration(
                image: getBackgroundImage("sunny")
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                decoration:
                    BoxDecoration(
                        image: getBackgroundImage("sunny")
                    ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          GestureDetector(
                            child: const Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {
                                if ((searchController.text)
                                        .replaceAll(" ", "") ==
                                    "") {
                                  print("Input is empty");
                                } else {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/loading',
                                    arguments: {
                                      "searchText": searchController.text,
                                    },
                                  );
                                }
                              },
                              controller: searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter city like $city",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Image.network(
                                      "https://openweathermap.org/img/wn/$iconValue@2x.png"),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  children: [
                                    Text(
                                      descValue,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "In $cityValue",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 250,
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  WeatherIcons.thermometer,
                                  size: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      temp,
                                      style: const TextStyle(fontSize: 130),
                                    ),
                                    const Text(
                                      "°C",
                                      style: TextStyle(fontSize: 80),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            height: 200,
                            padding: const EdgeInsets.all(26.0),
                            margin: const EdgeInsets.fromLTRB(25, 0, 7, 0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      WeatherIcons.windy,
                                      size: 40,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25),
                                Text(
                                  air,
                                  style: const TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  "km/hr",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 200,
                            padding: const EdgeInsets.all(26.0),
                            margin: const EdgeInsets.fromLTRB(7, 0, 25, 0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      WeatherIcons.humidity,
                                      size: 40,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      humValue,
                                      style: const TextStyle(
                                        fontSize: 45,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "%",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: 350,
                              child: FlutterMap(
                                options: MapOptions(
                                  initialCenter: center,
                                  initialZoom: 10.0,
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                    const Text(
                      "Made by Ananta",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const Text(
                      "Powered by OpenWeathermap.org",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 75),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.orange),
                strokeWidth: 4.0,
              ) // Display loading indicator
            : const Text("Loading..."),
      );
    }
  }
}
