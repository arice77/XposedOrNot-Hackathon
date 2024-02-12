import 'package:flutter/material.dart';
import 'package:xpose/Screens/analytics_email_breach.dart';
import 'Screens/data_breaches_screen.dart';
import 'Screens/email_breach_screen.dart';
import 'Screens/home_screen.dart';

import 'Screens/exposed_password_scren.dart';

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
      routes: {
        EmailBreachScreen.routeName: (context) => const EmailBreachScreen(),
        AnalyticsEmailBreach.routeName: (context) =>  const AnalyticsEmailBreach(),
        ExposedPasswordScreen.routeName: (context) => const ExposedPasswordScreen(),
        DataBreachScreen.routeName: (context) => const DataBreachScreen(),
      
      },
      home: const HomeScreen()
    );
  }
}