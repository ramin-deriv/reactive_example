import 'dart:async';

import 'package:reactive_example/currency_converter_cubit.dart';
import 'package:reactive_example/exchage_rate_state.dart';

// Latest exchange rate
// Latest amount
// Show the converted value
// Apply debounce if user change input quickly
// Don't convert if the new user input is equal the last input
class CurrencyConverterCubitImperative extends CurrencyConverterCubit {
  CurrencyConverterCubitImperative(super.exchangeRateService) {
    exchangeRateService.getExchangeRate('USD', 'EUR').listen((rate) {
      _latestRate = rate;
      if (_latestAmount != null) {
        emit(CurrencyConvertLoaded(_latestAmount! * rate));
      }
    });
  }

  // States
  double? _latestRate;
  double? _latestAmount;

  Timer? _debounce;

  @override
  void convertCurrency(double amount) async {
    if (amount == _latestAmount) {
      return;
    }

    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      _latestAmount = amount;
      if (_latestRate != null) {
        emit(CurrencyConvertLoaded(amount * _latestRate!));
      }
    });
  }
}
