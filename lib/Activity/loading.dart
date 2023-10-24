import 'package:flutter/material.dart';
import 'package:weather/worker/worker.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String? location;
  String? temp;
  String? humidity;
  double? air_speed;
  String? des;
  String? main;
  String? iconid;
  

  void startApp() async {
    worker instance = worker(location: "Bhopal");
    await instance.getData();

    temp = instance.temp;
    humidity = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    iconid = instance.icon;

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'temp_value': (temp),
      'humidity_value': humidity,
      'air_speed_value': air_speed,
      'des_value': des,
      'main_value': main,
      'icon_value': iconid,
    });
  }

  @override
  void initState() {
    super.initState();
    startApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 5, 30),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // loading indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 20), 
            Text(
              'Loading Data...',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}