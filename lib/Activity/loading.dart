import 'package:flutter/material.dart';
import 'package:weather/worker/worker.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String? location = 'new york';
  String? passed_location;
  String? temp;
  String? humidity;
  double? air_speed;
  String? des;
  String? main;
  String? iconid;
  String? city_name;

  void startApp() async {
    worker instance = worker(location: "$location");
    await instance.getData();

    temp = instance.temp;
    humidity = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    iconid = instance.icon;
    city_name = instance.city;

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'temp_value': (temp),
      'humidity_value': humidity,
      'air_speed_value': air_speed,
      'des_value': des,
      'main_value': main,
      'icon_value': iconid,
      'city_value': city_name,
    });
  }

  @override
  void initState() {
    super.initState();
    //setState(() {});
    startApp();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

    //location = passed_location;
    //startApp();
  }

  @override
  Widget build(BuildContext context) {
    // Map? search = ModalRoute.of(context)?.settings.arguments as Map?;

    // void set_city() {
    //   if (search != null && search.isNotEmpty) {
    //     // passed_location = search['location'];
    //     location = search['location'];
    //     print(
    //         "the location that is passed by search button is $passed_location");

    //     //setState(() {});
    //   }
    // }

    //set_city();

    print("the location that is passed by search button is $location");
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
