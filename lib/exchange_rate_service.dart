import 'dart:math';

class ExchangeRateService {
  // method return stream of latest exchange rate of from and to currencies and return random values but inside a range which is also random
  // random value also has decimal points. and the difference between last and current value less than 0.1
  Stream<double> getExchangeRate(String from, String to) async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 3));
      yield (1 + (1 - 2 * (0.5 - Random().nextDouble())) * 0.1);
    }
  }
}
