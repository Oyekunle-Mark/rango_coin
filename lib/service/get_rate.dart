import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const baseURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'BC3D5815-2462-41A3-927C-AF58924114EB';

class GetRate {
  Future getCryptRate({String crypto, String currency}) async {
    var url = '$baseURL/$crypto/$currency';

    var response = await http.get(
      url,
      headers: {'X-CoinAPI-Key': apiKey},
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse['rate'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future getBTC({String crypto, String currency}) async {
    var url = '$baseURL/BTC/$currency';

    var response = await http.get(
      url,
      headers: {'X-CoinAPI-Key': apiKey},
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse['rate'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future getETH({String crypto, String currency}) async {
    var url = '$baseURL/ETH/$currency';

    var response = await http.get(
      url,
      headers: {'X-CoinAPI-Key': apiKey},
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse['rate'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future getLTC({String crypto, String currency}) async {
    var url = '$baseURL/LTC/$currency';

    var response = await http.get(
      url,
      headers: {'X-CoinAPI-Key': apiKey},
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse['rate'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
