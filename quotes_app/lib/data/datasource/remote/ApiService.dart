import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/quote.dart';

class ApiService {
  ApiService._();
  static final ApiService api = ApiService._();

  Future<QuoteResponse> fetchQuotes() async {
    String url = 'https://api.quotable.io/quotes';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return QuoteResponse.fromMap(jsonData);
    } else {
      throw Exception('Unable to fetch Quptes');
    }
  }
}