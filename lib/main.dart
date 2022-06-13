import 'package:diabetest/vistas/ajustes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:diabetest/vistas/bienvenida.dart';
import 'package:diabetest/vistas/inicio.dart';
import 'package:diabetest/vistas/prueba.dart';
import 'package:diabetest/vistas/estadisticas.dart';
import 'package:diabetest/vistas/registros.dart';
import 'package:diabetest/vistas/inicio-sesion.dart';
import 'package:diabetest/vistas/registro.dart';
import 'package:diabetest/vistas/cuenta.dart';
import 'package:diabetest/controlador/custom_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // ignore: prefer_const_constructors
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));

  runApp(const MaterialApp(
    home: MyApp(),
  ));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Diabetest",
      home: const LoginPage(),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/inicio': (context) => const Inicio(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/prueba': (context) => Prueba(),
        '/registros': (context) => const Registros(),
        '/estadisticas': (context) => const Estadisticas(),
        '/cuenta': (context) => const Cuenta(),
        //
        '/inicio-sesion': (context) => const LoginPage(),
        '/registro': (context) => const RegisterPage(),
        '/ajustes': (context) => const Ajustes(),
      },
    );
  }
}
