import "package:flutter/material.dart";

import "../util/utils.dart";

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
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
              "Denver",
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
            child: Text(
              "69F",
              style: TextStyle(fontSize: 22.0, fontStyle: FontStyle.italic, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
