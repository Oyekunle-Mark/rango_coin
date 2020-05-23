import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const baseURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'BC3D5815-2462-41A3-927C-AF58924114EB';

class GetRate {
  GetRate({this.currency});

  final String currency;
  double eTHRate;
  double bTCRate;
  double lTCRate;

  Future getCryptRate({String crypto, String currency}) async {
    eTHRate =
        await getRateByCryptoAndCurrency(crypto: 'ETH', currency: currency);
    bTCRate =
        await getRateByCryptoAndCurrency(crypto: 'BTC', currency: currency);
    lTCRate =
        await getRateByCryptoAndCurrency(crypto: 'LTC', currency: currency);
  }

  Future getRateByCryptoAndCurrency({String crypto, String currency}) async {
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
}
