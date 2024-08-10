import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:tracker/data/workout_data.dart';
import 'package:tracker/onboarding_views/onboarding_page.dart';


void main() async {
  //initialize hive
  await  Hive.initFlutter();

  //open a hive box
  await Hive.openBox("mybox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => workoutData(),
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnboardingPage(),
      )
    );
  }
}
