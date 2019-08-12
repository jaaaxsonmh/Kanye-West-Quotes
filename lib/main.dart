import 'package:flutter/material.dart';
import 'package:kanye_quotes/home.dart';
import 'package:dropdown_banner/dropdown_banner.dart';

void main() async {
  runApp(new KanyeQuotes());
}

class KanyeQuotes extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        title: 'Bit Buddy',
        home: DropdownBanner(child: new Home(), navigatorKey: _navigatorKey)
    );
  }
}


