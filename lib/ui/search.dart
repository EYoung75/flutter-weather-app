import "package:flutter/material.dart";

import "./weather.dart";
import "../util/utils.dart" as util;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  String city = util.defaultCity;

  _SearchState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: Text("Search by City"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/first-weather.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (String value) {
                setState(() {
                  city = value;
                });
              },
              decoration: InputDecoration(labelText: "Enter a city"),
            ),
            SizedBox(height: 20,),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Weather(city)),
                );
              },
              child: Text("Search"),
            )
          ],
        ),
      ),
    );
  }
}
