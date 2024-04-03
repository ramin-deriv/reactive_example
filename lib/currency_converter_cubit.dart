import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_example/exchage_rate_state.dart';
import 'package:reactive_example/exchange_rate_service.dart';

abstract class CurrencyConverterCubit extends Cubit<CurrencyConvertState> {
  CurrencyConverterCubit(this.exchangeRateService)
      : super(CurrencyConvertInitial());

  final ExchangeRateService exchangeRateService;

  void convertCurrency(double amount);
}
