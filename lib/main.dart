import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redoq_assignment/bloc/home/card_bloc.dart';
import 'package:redoq_assignment/view/screens/home_screen.dart';
import 'package:get_it/get_it.dart';

void main() {
  // Set up the service locator
  setupServiceLocator();
  // Start the app
  runApp(const MyApp());
}

void setupServiceLocator() {
  GetIt.I.registerLazySingleton<CardBloc>(() => CardBloc());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardBloc>(
      create: (BuildContext context) { return GetIt.I<CardBloc>(); },
      child: MaterialApp(
        title: 'RedoQ Assignment',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
