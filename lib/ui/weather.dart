import "package:flutter/material.dart";
import "dart:async";
import "dart:convert";
import "package:http/http.dart" as http;

import "../util/utils.dart" as util;


class Weather extends StatefulWidget {
  final String city;
  Weather(this.city);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  void showStuff() async {
    Map data = await getWeather(util.appId, util.defaultCity);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        backgroundColor: Colors.blueGrey[700],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              showStuff();
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              "images/first-weather.jpg",
              height: 1200.0,
              width: 500.0,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 25.0, 25.0, 0.0),
            alignment: Alignment.topRight,
            child: Text(
              widget.city,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Icon(
              Icons.cloud,
              color: Colors.white,
              size: 100,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 100.0),
            alignment: Alignment.center,
            child: updateTempWidget(widget.city)
          )
        ],
      ),
    );
  }

  Future<Map> getWeather(String appId, String city) async {
    String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${util.appId}&units=imperial";

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }

  Widget updateTempWidget(String city) {
    return FutureBuilder(
      future: getWeather(util.appId, city),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
        if(snapshot.hasData) {
          Map content = snapshot.data;
          return Text(content["main"]["temp"].toString(), style: TextStyle(color: Colors.white, fontSize: 26),);
          
        } else {
          return Container();
        }
    });
  }
}
