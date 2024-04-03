import 'package:reactive_example/currency_converter_cubit.dart';
import 'package:reactive_example/exchage_rate_state.dart';
import 'package:rxdart/rxdart.dart' as rx;

class CurrencyConverterCubitReactive extends CurrencyConverterCubit {
  CurrencyConverterCubitReactive(super.exchangeRateService) {
    rx.Rx.combineLatest2(exchangeRateService.getExchangeRate('USD', 'EUR'),
        _amountController.stream, (a, b) => a * b).listen((convertedValue) {
      emit(CurrencyConvertLoaded(convertedValue));
    });
  }

  final rx.BehaviorSubject<double> _amountController =
      rx.BehaviorSubject<double>();

  void convertCurrency(double amount) {
    _amountController.add(amount);
  }
}
