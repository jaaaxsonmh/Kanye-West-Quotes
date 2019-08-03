import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kanye_quotes/api/quote_data.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _quote = "Loading...";
  @override
  void initState() {
    super.initState();
    getQuote();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Center(child: new Column(children: <Widget>[new Center(child: new Text(_quote)), new FlatButton(onPressed: getQuote, child: new Text("new quote"))], mainAxisAlignment: MainAxisAlignment.center,),),
    );
  }

  void getQuote() {
    findNew().then((val) => setState(() {
      _quote = val;
    }));
  }

  Future<String> findNew() async {
    String kanyeQuoteAPI = 'https://api.kanye.rest/';

      http.Response response = await http.get(kanyeQuoteAPI);

      var responseBody = QuoteData.fromJson(jsonDecode(response.body));
      final httpStatus = response.statusCode;

      if(httpStatus != 200 || httpStatus == null) {
        throw new GetDataException("Error in http code: $httpStatus");
      }

    return responseBody.quote;
  }
}