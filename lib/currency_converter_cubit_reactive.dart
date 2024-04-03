import 'package:reactive_example/currency_converter_cubit.dart';
import 'package:reactive_example/exchage_rate_state.dart';
import 'package:rxdart/rxdart.dart' as rx;

class CurrencyConverterCubitReactive extends CurrencyConverterCubit {
  CurrencyConverterCubitReactive(super.exchangeRateService) {
    rx.Rx.combineLatest2(
      exchangeRateService.getExchangeRate('EUR', 'USD'),
      _amountSubject.stream.debounceTime(const Duration(milliseconds: 300)),
      (rate, amount) => rate * amount,
    ).listen((result) {
      emit(CurrencyConvertLoaded(result));
    });
  }

  final rx.BehaviorSubject<double> _amountSubject =
      rx.BehaviorSubject<double>();

  @override
  void convertCurrency(double amount) {
    _amountSubject.add(amount);
  }

  @override
  Future<void> close() {
    _amountSubject.close();
    return super.close();
  }
}
