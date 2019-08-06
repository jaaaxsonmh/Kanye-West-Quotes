import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kanye_quotes/api/quote_data.dart';
import 'package:kanye_quotes/widgets/progress_indicator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _quote;

  @override
  void initState() {
    super.initState();
    getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          children: <Widget>[
            _buildQuoteWidget(),
            _buildButtonWidget()
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  Widget _buildQuoteWidget() {
    return new Center(child: _quote == null ? new LoadingIndicatorDots(
      fontSize: 30.0,
    ) : new Text(_quote));
  }

  Widget _buildButtonWidget() {
  return new FlatButton(onPressed: getQuote, child: new Text("new quote"));
}
  void getQuote() {
    setState(() {
      _quote =null;
    });
    findNew().then((val) => setState(() {
          _quote = val;
        }));
  }

  Future<String> findNew() async {
    String kanyeQuoteAPI = 'https://api.kanye.rest/';

    http.Response response = await http.get(kanyeQuoteAPI);

    var responseBody = QuoteData.fromJson(jsonDecode(response.body));
    final httpStatus = response.statusCode;

    if (httpStatus != 200 || httpStatus == null) {
      throw new GetDataException("Error in http code: $httpStatus");
    }

    return responseBody.quote;
  }
}
