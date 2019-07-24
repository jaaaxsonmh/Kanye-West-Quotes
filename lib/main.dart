import 'package:flutter/material.dart';
import 'package:kanye_quotes/home.dart';

void main() async {
  runApp(new KanyeQuotes());
}

class KanyeQuotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        title: 'Bit Buddy',
        home: new Home()
    );
  }
}


