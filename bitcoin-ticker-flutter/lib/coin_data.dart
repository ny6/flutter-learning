import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String _url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';

  Future<Map> getLastPriceOfCurrency(String currency) async {
    Map<String, double> prices = {};
    for (String c in cryptoList) {
      http.Response response = await http.get('$_url/$c$currency');
      if (response.statusCode == 200) {
        var price = jsonDecode(response.body)['last'];

        prices[c] = price ?? 0;
      }
    }
    return prices;
  }
}
