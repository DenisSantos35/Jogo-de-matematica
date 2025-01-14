import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jogo_match/controller/intial_controller.dart';
import 'package:jogo_match/pages/initial_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: InitialPage(
          controller: IntialController(),
        ));
  }
}
