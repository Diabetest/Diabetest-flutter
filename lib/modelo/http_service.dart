import 'dart:convert';
import 'dart:io';
import 'package:diabetest/vistas/inicio-sesion.dart';
import 'package:diabetest/vistas/inicio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:diabetest/vistas/bienvenida.dart';

class HttpService {
  static final _client = http.Client();

  static var _loginUrl =
      Uri.parse('https://flaskflutterlogin.herokuapp.com/login');

  static var _registerUrl =
      Uri.parse('https://flaskflutterlogin.herokuapp.com/register');

  static login(email, password, context) async {
    http.Response response = await _client.post(_loginUrl, body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      if (json[0] == 'success') {
        await EasyLoading.showSuccess(json[0]);
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Inicio()));
      } else {
        EasyLoading.showError(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Código de error : ${response.statusCode.toString()}");
    }
  }

  static register(name, surname, curp, email, password, info, context) async {
    http.Response response = await _client.post(_registerUrl, body: {
      "name": name,
      "surname": surname,
      "curp": curp,
      "email": email,
      "password": password,
      "info": info,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'El nombre de usuario y/o correo ya existe') {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    } else {
      await EasyLoading.showError(
          "Código de error : ${response.statusCode.toString()}");
    }
  }
}
