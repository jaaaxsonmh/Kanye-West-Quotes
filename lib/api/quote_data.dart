class QuoteData {
  String quote;

  QuoteData({this.quote});

  QuoteData.fromJson(Map<String, dynamic> json) : quote = json['quote'];
}

abstract class QuoteStore {
  Future<String> getQuote();
}

class GetDataException implements Exception {
  final _exception;

  GetDataException([this._exception]);

  String toString() {
    if(_exception == null) return "none";
    return "Exception: $_exception";
  }
}


