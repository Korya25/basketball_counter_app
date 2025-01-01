import 'package:basketball_counter_app/screens/counter_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BasketballCounterApp());
}

class BasketballCounterApp extends StatelessWidget {
  const BasketballCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basketball Counter',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const CounterScreen(),
    );
  }
}
