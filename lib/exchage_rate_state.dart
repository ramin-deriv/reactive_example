sealed class CurrencyConvertState {}

class CurrencyConvertInitial extends CurrencyConvertState {}

class CurrencyConvertLoaded extends CurrencyConvertState {
  final double result;

  CurrencyConvertLoaded(this.result);
}
