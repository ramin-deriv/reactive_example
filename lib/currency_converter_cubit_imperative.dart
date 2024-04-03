import 'package:reactive_example/currency_converter_cubit.dart';
import 'package:reactive_example/exchage_rate_state.dart';

class CurrencyConverterCubitImperative extends CurrencyConverterCubit {
  CurrencyConverterCubitImperative(super.exchangeRateService) {
    exchangeRateService.getExchangeRate('USD', 'EUR').listen((rate) {
      _latestRate = rate;
      if (_latestRate != null) {
        emit(CurrencyConvertLoaded(_latestAmount * _latestRate!));
      }
    });
  }

  double? _latestRate;
  double _latestAmount = 0;

  void convertCurrency(double amount) async {
    _latestAmount = amount;
    if (_latestRate != null) {
      emit(CurrencyConvertLoaded(_latestAmount * _latestRate!));
    }
  }
}
