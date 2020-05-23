import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/service/get_rate.dart';
import 'package:bitcoin_ticker/crypto_card.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = 'AUD';
  double _bTCRate;
  double _eTHRate;
  double _lTCRate;
  bool _fetched = false;

  @override
  void initState() {
    super.initState();
    fetchRate();
  }

  void fetchRate() async {
    GetRate _getRate = GetRate();
    await _getRate.getCryptRate(currency: _selectedCurrency);

    setState(() {
      _bTCRate = _getRate.bTCRate;
      _eTHRate = _getRate.eTHRate;
      _lTCRate = _getRate.lTCRate;
      _fetched = true;
    });
  }

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDowns = [];

    for (var currency in currenciesList) {
      dropDowns.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: _selectedCurrency,
      items: dropDowns,
      onChanged: (value) {
        setState(() {
          _selectedCurrency = value;
          fetchRate();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> dropDowns = [];

    for (var currency in currenciesList) {
      dropDowns.add(Text(
        currency,
        style: TextStyle(
          color: Colors.white,
        ),
      ));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          _selectedCurrency = currenciesList[selectedIndex];
          fetchRate();
        });
      },
      children: dropDowns,
    );
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CryptoCard(
                  cryptoType: 'BTC',
                  fetched: _fetched,
                  currentRate: _bTCRate,
                  selectedCurrency: _selectedCurrency),
              CryptoCard(
                  cryptoType: 'ETH',
                  fetched: _fetched,
                  currentRate: _eTHRate,
                  selectedCurrency: _selectedCurrency),
              CryptoCard(
                  cryptoType: 'LTC',
                  fetched: _fetched,
                  currentRate: _lTCRate,
                  selectedCurrency: _selectedCurrency),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
