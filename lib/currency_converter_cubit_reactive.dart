import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_example/exchage_rate_state.dart';
import 'package:reactive_example/exchange_rate_service.dart';

class CurrencyConverterCubitReactive extends Cubit<CurrencyConvertState> {
  CurrencyConverterCubitReactive(this.exchangeRateService)
      : super(CurrencyConvertInitial()) {
    exchangeRateService.getExchangeRate('USD', 'EUR').listen((rate) {
      print('rate: $rate');
      emit(CurrencyConvertLoaded(rate));
    });
  }

  final ExchangeRateService exchangeRateService;

  void convertCurrency() async {}
}
