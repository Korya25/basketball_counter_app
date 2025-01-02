import 'package:basketball_counter_app/cubits/countir_cubit.dart';
import 'package:basketball_counter_app/screens/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const BasketballCounterApp());
}

class BasketballCounterApp extends StatelessWidget {
  const BasketballCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Basketball Counter',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: CounterScreen(),
      ),
    );
  }
}
