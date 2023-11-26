import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mausam/worker/ApiWorker.dart';

class loading extends StatefulWidget {
  const loading({Key? key}) : super(key: key);

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  double temp = 0.0;
  double LAT =0.0;
  double LON =0.0;
  String hum = "";
  double airS = 0.0;
  String desc = "";
  String weath = "";
  String icon = "";
  String city = "Banapur";


  void setData(String city) async{
    Worker worker = Worker(location: city);
    await worker.getData();

    temp=worker.temperature;
    hum=worker.humidity;
    airS=worker.airSpeed;
    desc=worker.description;
    weath=worker.weather;
    icon=worker.iconData;
    LAT = worker.latitude;
    LON = worker.longitude;

    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, '/Home',arguments: {
        "temp_value" : temp,
        "hum_value" : hum,
        "airS_value" : airS,
        "desc_value" : desc,
        "weath_value" : weath,
        "icon_value" : icon,
        "city_value" : city,
        "lat_value" : LAT,
        "lon_value" : LON,
      });
    });



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? searchInfo = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if(searchInfo != null){
      city = searchInfo['searchText'];
    }
    setData(city);
    return  Scaffold(
      backgroundColor: Colors.blue[300],
      body: Center(
        child: Padding(
          padding:  const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset("assets/Images/mausam.png"),
              ),
              const SizedBox(height: 30,),
              const Text("mausam",style: TextStyle(color : Colors.white,fontSize: 30,fontFamily: "Schyler"),),
              const SizedBox(height: 30,),
          const SpinKitThreeInOut(
            color: Colors.black26,
            size: 50.0,
          ),
              const SizedBox(height: 250,),
              const Text("Made by Ananta",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),),


            ],
          ),
        ),
      )
    );
  }
}
