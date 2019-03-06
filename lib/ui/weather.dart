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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.city}"),
        backgroundColor: Colors.blueGrey[700],
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
            margin: EdgeInsets.fromLTRB(35.0, 35.0, 0.0, 0.0),
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                Text(
                  widget.city,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 24.0,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 100),
              child: updateTempWidget(widget.city))
        ],
      ),
    );
  }

  Future<Map> getWeather(String appId, String city) async {
    String apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${util.appId}&units=imperial";

    http.Response response = await http.get(apiUrl);
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  Widget updateTempWidget(String city) {
    return FutureBuilder(
        future: getWeather(util.appId, city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            String humidity =
                "Humidity: ${content["main"]["humidity"].toString()}";
            String description = "Conditions: ${content["weather"][0]["main"].toString()}";
            String temperature = "${content["main"]["temp"].toString() + '°F'}";
            String tempRange =
                "Range: ${content["main"]["temp_min"].toString()}°F - ${content["main"]["temp_max"].toString()}°F";
            String wind =
                "Avg wind speed of ${content["wind"]["speed"]} mi/hr";

            return Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.cloud,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    temperature,
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ),
                ),
                SizedBox(height: 60),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, .8),
                      borderRadius: BorderRadius.circular(5)),
                      margin: EdgeInsets.symmetric(horizontal: 25),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(humidity,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Text(description,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Text(tempRange,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Text(wind,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
