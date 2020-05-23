import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/service/get_rate.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = 'AUD';
  GetRate _getRate = GetRate();
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
    double rate = await _getRate.getCurrentRate(
      crypto: 'BTC',
      currency: _selectedCurrency,
    );

    setState(() {
      _bTCRate = rate;
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
          CryptoCard(
              cryptoType: 'BTC',
              fetched: _fetched,
              uSDRate: _bTCRate,
              selectedCurrency: _selectedCurrency),
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

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    @required this.cryptoType,
    @required this.fetched,
    @required this.uSDRate,
    @required this.selectedCurrency,
  });

  final String cryptoType;
  final bool fetched;
  final double uSDRate;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoType = ${fetched ? uSDRate.toInt() : '?'} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
