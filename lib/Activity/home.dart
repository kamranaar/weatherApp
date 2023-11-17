// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controller/controller.dart';
import 'package:weather/worker/worker.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //late worker instance;

  // TextEditingController searchController = new TextEditingController();
  var userlocation = TextEditingController();
  String uLocation = 'Delhi';
  String temperature = 'Loading...';

  get air_speed_value => null;

  @override
  void initState() {
    super.initState();
    //instance = worker(location: 'delhi');
    startApp();
    print("This is an initState");
  }

  void startApp() async {
    worker instance = worker(location: "$userlocation");
    await instance.getData();
    print("The air speed is ${instance.air_speed}");
    print("The temperature is ${instance.temp}");
    setState(() {
      temperature = instance.temp.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Map? info = ModalRoute.of(context)?.settings.arguments
        as Map; // this line is giving error
    String icon = info['icon_value'];

    String temp = ((info['temp_value']).toString()).substring(0, 4);
    String air = ((info['air_speed_value']).toString());
    String tempk = info['temp_value'];
    String kelvinString = tempk; // Assuming tempk is a string
    String? city_value_home = info['city_value'].toString();
    double kelvin = double.tryParse(kelvinString) ??
        0.0; // Convert the string to a double, default to 0.0 if the conversion fails

    double celsius = kelvin - 273.15; // Convert from Kelvin to Celsius
    String airSpeedString =
        air; // Assuming air is a string representing the speed in m/s
    double airSpeedMS = double.tryParse(airSpeedString) ??
        0.0; // Convert the string to a double, default to 0.0 if the conversion fails

    double airSpeedKMH = airSpeedMS * 3.6; // Convert from m/s to km/h
    var myController = Get.put(MyController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 21, 36, 15),
        title: Text(myController.myVariable.toString()),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamed(context, "/loading");
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          //main container
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  stops: [
                0.1,
                0.9
              ],
                  colors: [
                Color.fromARGB(255, 6, 35, 15),
                Color.fromARGB(255, 137, 14, 67),
              ])),

          child: Column(
            children: [
              Container(
                //search box wala container
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        String ulocation = userlocation.text.toString();
                        myController.myVariable.value =
                            userlocation.text.toString();
                        print("user location is .$ulocation");
                        Navigator.pushNamed(
                          context, "/loading",
                          // arguments: {
                          //   'location': ulocation,
                          //}
                        );
                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                        margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: userlocation,
                        //take the input from this text field and pass it to loading as a location
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search ${myController.myVariable}"),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                //first container for the description like haze and cloudy
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.all(26),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  info['des_value'],
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '$city_value_home',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )),
                            Expanded(
                                child: Image.network(
                                    'http://openweathermap.org/img/wn/$icon@2x.png'))
                          ],
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      padding: EdgeInsets.all(26),
                      child: Column(children: [
                        Row(
                          children: [
                            Icon(WeatherIcons.thermometer),
                            Text(
                              'TEMPERATURE',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "${celsius.toStringAsFixed(2)}°C", // Display Celsius with 2 decimal places
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                      padding: EdgeInsets.all(26),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(WeatherIcons.humidity),
                              Text(
                                'HUMIDITY',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Expanded(
                            child: Center(
                                child: Text(
                              '${info["humidity_value"]}%',
                              style: TextStyle(
                                  fontSize: 45, fontWeight: FontWeight.w600),
                            )),
                          )
                        ],
                      ),
                      height: 200,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      padding: EdgeInsets.all(26),
                      height: 200,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(WeatherIcons.wind),
                              Text(
                                'WIND SPEED',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                '${airSpeedKMH.toStringAsFixed(2)} km/h', // Display the speed in km/h with 2 decimal places
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Made in India"),
                    Text("Data Provided By Openweathermap.org")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
