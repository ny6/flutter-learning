import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currency = 'USD';
  String symbol = 'BTC';
  bool isComplete = false;
  Map<String, double> prices = {};
  double price = 0;

  CoinData coinData = CoinData();

  DropdownButton androidDropdown() {
    List<DropdownMenuItem<String>> items = [];
    for (String c in currenciesList) {
      items.add(DropdownMenuItem(child: Text(c), value: c));
    }

    return DropdownButton<String>(
      value: currency,
      items: items,
      onChanged: (value) {
        setState(() {
          currency = value;
        });
        getCurrencyData();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> items = [];
    for (String c in currenciesList) {
      items.add(Text(c, style: TextStyle(color: Colors.white)));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          currency = currenciesList[index];
        });
        getCurrencyData();
      },
      children: items,
    );
  }

  List<Widget> printCurrencyWidgets() {
    List<Widget> widgets = [];
    prices.forEach((key, val) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '1 $key = $val $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ));
    });

    return widgets;
  }

  getCurrencyData() async {
    Map data = await coinData.getLastPriceOfCurrency(currency);
    print(data);
    setState(() {
      prices = data;
      isComplete = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrencyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Column(
                  children: printCurrencyWidgets(),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
