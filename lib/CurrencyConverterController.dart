import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyConverterController extends GetxController with SingleGetTickerProviderMixin {
  String convertedAmount = '0.0';
  String fromCurrency = 'USD';
  String toCurrency = 'IQD';

  late TextEditingController amount;
  late TextEditingController exchangeRate;

  // Animation controller for the swap button animation
  late AnimationController swapAnimationController;

  final String exchangeRateKey = 'exchange_rate';

  @override
  void onInit() {
    amount = TextEditingController();
    exchangeRate = TextEditingController();
    swapAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    getExchangeRate();
    super.onInit();
  }

  Future<void> getExchangeRate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? cachedExchangeRate = prefs.getDouble(exchangeRateKey);
    if (cachedExchangeRate != null) {
      exchangeRate.text = cachedExchangeRate.toString();
      
    }

    DatabaseReference testReference =
        FirebaseDatabase.instance.ref().child("ro");
    testReference.onValue.listen((event) {
      double x = double.parse(event.snapshot.value.toString());

      // Set the exchangeRate controller's text instead of reassigning the entire controller
      exchangeRate.text = x.toString();

      // Save the fetched exchange rate to cache
      prefs.setDouble(exchangeRateKey, x);

      // Remove ".0" if it exists
      update();
    });
  }

  String? convertCurrency() {
    double result = fromCurrency == 'USD'
        ? double.parse("${amount.text}") *
            double.parse("${exchangeRate.text.toString()}")
        : double.parse("${amount.text}") /
            double.parse("${exchangeRate.text.toString()}");
    convertedAmount =
        result.toStringAsFixed(2).replaceAll(RegExp(r'\.0*$'), '');
    
    // Trigger the swap button animation
    swapAnimationController.forward(from: 0.0);

    update();
  }

  // Function to toggle between USD to IQD and vice versa
  void switchCurrencies() {
    final String temp = fromCurrency;
    fromCurrency = toCurrency;
    toCurrency = temp;

    // Trigger the swap animation
    swapAnimationController.forward(from: 0.0);

    update();
  }

  // Function to build currency dropdown
  Widget buildCurrencyDropdown(
      {required String label, required String currency}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        SizedBox(
          width: 120,
          child: DropdownButton<String>(
            value: currency,
            onChanged: (String? newValue) {
              if (label == 'From') {
                fromCurrency = newValue!;
              } else {
                toCurrency = newValue!;
              }
              update();
            },
            items: <String>['USD', 'IQD']
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: const TextStyle(color: Colors.white)),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  String formatConvertedAmount() {
    double amountValue = double.parse(convertedAmount);

    if (amountValue % 1 == 0) {
      return amountValue.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]},');
    } else {
      List<String> parts = amountValue.toStringAsFixed(2).split('.');
      String integerPart = parts[0].replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]},');
      String decimalPart = parts[1].replaceAll(RegExp(r'([.]0)(?!.\d)'), '');
      return '$integerPart.$decimalPart';
    }
  }
}
