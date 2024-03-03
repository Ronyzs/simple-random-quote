import 'package:belajar_bloc/presentation/bloc/quote/quote_bloc.dart';
import 'package:belajar_bloc/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:belajar_bloc/injection.dart' as di;

void main() async {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<QuoteBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Simple Quote',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Random Quote'),
      ),
    );
  }
}
