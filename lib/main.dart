import "package:flutter/material.dart";
import "./ui/search.dart";

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter weather app",
      home: Search(),
    )
  );
}