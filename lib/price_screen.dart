import 'package:bit_coin_ticker/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedcoin = 'USD';
  String apiKey = '600CBF49-9055-4EE1-9094-BFB79BB2731E';
  String rateBTC = '?';
  String rateETH = '?';
  String rateLTC = '?';
  Future<String> getData(String coin, String crypto) async {
    var coindata = await CoinData().getCoinData(
      Uri.parse('https://rest.coinapi.io/v1/exchangerate/'
          '$crypto/$selectedcoin?apikey=$apiKey'),
    );
    double rate = coindata['rate'];
    return rate.toStringAsFixed(1);
  }

  List<DropdownMenuEntry> getItems() {
    List<DropdownMenuEntry> itemCoin = [];
    for (String coin in currenciesList) {
      var newItem = DropdownMenuEntry(label: coin, value: coin);
      itemCoin.add(newItem);
    }
    return itemCoin;
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
                child: Text(
                  '1 BTC = $rateBTC $selectedcoin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $rateETH $selectedcoin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $rateLTC $selectedcoin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownMenu(
              label: Text('USD'),
              dropdownMenuEntries: getItems(),
              onSelected: (value) async {
                rateBTC = await getData(value, 'BTC');
                rateETH = await getData(value, 'ETH');
                rateLTC = await getData(value, 'LTC');
                setState(() {
                  selectedcoin = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
