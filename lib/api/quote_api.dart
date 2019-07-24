import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kanye_quotes/api/quote_data.dart';

class QuoteAPI implements QuoteStore {
  String kanyeQuoteAPI = 'https://api.kanye.rest/';

  @override
  Future<String> getQuote() async {
    http.Response response = await http.get(kanyeQuoteAPI);

    var responseBody = QuoteData.fromJson(jsonDecode(response.body));
    final httpStatus = response.statusCode;

    if(httpStatus != 200 || httpStatus == null) {
      throw new GetDataException("Error in http code: $httpStatus");
    }

    return responseBody.quote;
  }
}