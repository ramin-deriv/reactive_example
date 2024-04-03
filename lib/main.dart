import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_example/currency_converter_cubit.dart';
import 'package:reactive_example/currency_converter_cubit_imperative.dart';
import 'package:reactive_example/currency_converter_cubit_reactive.dart';
import 'package:reactive_example/exchage_rate_state.dart';
import 'package:reactive_example/exchange_rate_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => ImperativeStyle();
}

class ImperativeStyle extends State<HomePage> {
  late final CurrencyConverterCubit _currencyConverterCubit;
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currencyConverterCubit =
        CurrencyConverterCubitReactive(ExchangeRateService());

    _amountController.addListener(() {
      if (_amountController.text.isEmpty) return;
      _currencyConverterCubit
          .convertCurrency(double.parse(_amountController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market state'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountController,
              ),
              BlocBuilder<CurrencyConverterCubit, CurrencyConvertState>(
                bloc: _currencyConverterCubit,
                builder: (context, state) {
                  if (state is CurrencyConvertInitial) {
                    return const Text('Enter amount to convert');
                  } else if (state is CurrencyConvertLoaded) {
                    return Text(
                      'Converted amount: ${state.result.toStringAsFixed(4)}',
                    );
                  } else {
                    return const Text('Error');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _currencyConverterCubit.close();
    super.dispose();
  }
}
