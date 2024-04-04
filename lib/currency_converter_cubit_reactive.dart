import 'dart:async';

import 'package:reactive_example/currency_converter_cubit.dart';

// Latest exchange rate
// Latest amount
// Show the converted value
// Apply debounce if user change input quickly
// Don't convert if the new user input is equal the last input
class CurrencyConverterCubitReactive extends CurrencyConverterCubit {
  CurrencyConverterCubitReactive(super.exchangeRateService) {}

  @override
  void convertCurrency(double amount) {}

  @override
  Future<void> close() {
    return super.close();
  }
}
