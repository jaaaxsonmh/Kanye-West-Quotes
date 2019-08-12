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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Container(
          child: new Text("Kanye West Quotes"),
          alignment: Alignment.center,
        ),
      ),
      floatingActionButton: _buildButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {}
            ),
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {_displayBar(context);}
            )
          ],
        ),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            _buildQuoteWidget()
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  Widget _buildQuoteWidget() {
    return new Container(
        child: new Center(
          child:
            _quote == null
                ? new LoadingIndicatorDots(
              fontSize: 30.0
            )
                : new Text(
              _quote,
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 24.0
              )
            )
        ));
  }

  Widget _buildButtonWidget() {
    return FloatingActionButton.extended(
      elevation: 4.0,
      icon: const Icon(Icons.add),
      label: const Text('Kanye said...'),
      onPressed: () {
        getQuote();
      },
    );
  }

  void getQuote() {
    setState(() {
      _quote = null;
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

  void _displayBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('Built by Jack Hosking, to demonstrate simple API use'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
