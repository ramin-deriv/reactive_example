import 'package:reactive_example/currency_converter_cubit.dart';
import 'package:reactive_example/exchage_rate_state.dart';
import 'package:rxdart/rxdart.dart' as rx;

// Latest exchange rate
// Latest amount
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
