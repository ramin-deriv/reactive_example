import 'dart:async';

import 'package:reactive_example/currency_converter_cubit.dart';
import 'package:reactive_example/exchage_rate_state.dart';
import 'package:rxdart/rxdart.dart' as rx;

// Latest exchange rate
// Latest amount
// Show the converted value
// Apply debounce if user change input quickly
// Don't convert if the new user input is equal the last input
class CurrencyConverterCubitReactive extends CurrencyConverterCubit {
  CurrencyConverterCubitReactive(super.exchangeRateService) {
    final rateStream = exchangeRateService.getExchangeRate('EUR', 'USD');
    final amountStream = _amountSubject.stream;

    _subscription = rx.Rx.combineLatest2(
      rateStream,
      amountStream.debounceTime(const Duration(seconds: 1)).distinct(),
      (rate, amount) => rate * amount,
    ).listen((result) {
      emit(CurrencyConvertLoaded(result));
    });
  }

  final rx.BehaviorSubject<double> _amountSubject =
      rx.BehaviorSubject<double>();

  StreamSubscription<double>? _subscription;

  @override
  void convertCurrency(double amount) => _amountSubject.add(amount);

  @override
  Future<void> close() {
    _amountSubject.close();
    _subscription?.cancel();
    return super.close();
  }
}
