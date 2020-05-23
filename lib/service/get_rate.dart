import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const baseURL = 'https://rest.coinapi.io/v1/exchangerate';

class GetRate {
  Future getCurrentRate(crypto, currency) async {
    var url = '$baseURL/$crypto/$currency';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse['rate'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
