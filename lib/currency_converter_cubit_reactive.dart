import 'dart:async';

import 'package:reactive_example/currency_converter_cubit.dart';
import 'package:reactive_example/exchage_rate_state.dart';
import 'package:rxdart/rxdart.dart';

// Latest exchange rate
// Latest amount
// Show the converted value
// Apply debounce if user change input quickly
// Don't convert if the new user input is equal the last input
class CurrencyConverterCubitReactive extends CurrencyConverterCubit {
  CurrencyConverterCubitReactive(super.exchangeRateService) {
    final rateStream = exchangeRateService.getExchangeRate('USD', 'EUR');
    final amountStream = _amountSubject.stream;

    _subscription = Rx.combineLatest2(
      rateStream,
      amountStream.debounceTime(const Duration(seconds: 1)).distinct(),
      (rate, amount) => rate * amount,
    ).listen((result) {
      emit(CurrencyConvertLoaded(result));
    });
  }

  StreamSubscription<double>? _subscription;

  final BehaviorSubject<double> _amountSubject = BehaviorSubject();

  @override
  void convertCurrency(double amount) {
    _amountSubject.add(amount);
  }

  @override
  Future<void> close() {
    _amountSubject.close();
    _subscription?.cancel();
    return super.close();
  }
}
