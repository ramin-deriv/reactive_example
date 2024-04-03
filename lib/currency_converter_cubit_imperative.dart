import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_example/exchage_rate_state.dart';
import 'package:reactive_example/exchange_rate_service.dart';

class CurrencyConverterCubitImperative extends Cubit<CurrencyConvertState> {
  CurrencyConverterCubitImperative(this.exchangeRateService)
      : super(CurrencyConvertInitial()) {
    exchangeRateService.getExchangeRate('USD', 'EUR').listen((rate) {
      print('rate: $rate');
      _latestRate = rate;
      if (_latestRate != null) {
        emit(CurrencyConvertLoaded(_latestAmount * _latestRate!));
      }
    });
  }

  double? _latestRate;
  double _latestAmount = 0;

  final ExchangeRateService exchangeRateService;

  void convertCurrency(double amount) async {
    _latestAmount = amount;
    if (_latestRate != null) {
      emit(CurrencyConvertLoaded(_latestAmount * _latestRate!));
    }
  }
}
