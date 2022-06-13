import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

import 'package:diabetest/modelo/api.dart';
import 'package:diabetest/modelo/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  late String name, surname, email, password, curp;
  bool isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _surnameController = new TextEditingController();
  TextEditingController _curpController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(
                    "assets/background.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 13,
                      ),
                      Text(
                        "¡Bienvenido a Diabetest!",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 27,
                                color: Colors.white,
                                letterSpacing: 1)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 180,
                        child: Text(
                          "Diabetest Company",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.white54,
                                letterSpacing: 0.6,
                                fontSize: 11),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Regístrate",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontSize: 23,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 45),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _nameController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: "Nombre(s)",
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  name = val!;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _surnameController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: "Apellidos",
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  surname = val!;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _curpController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: "CURP",
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  curp = val!;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _emailController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: "Correo Electrónico",
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  email = val!;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: TextFormField(
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        controller: _passwordController,
                                        decoration: const InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          hintText: "Contraseña",
                                          hintStyle: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15),
                                        ),
                                        obscureText: _obscureText,
                                        onSaved: (val) {
                                          email = val!;
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                          onPressed: _toggle,
                                          child: Text(
                                            _obscureText
                                                ? "Mostrar"
                                                : "Ocultar",
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                  ]),
                              SizedBox(
                                height: 30,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (isLoading) {
                                          return;
                                        }
                                        if (_nameController.text.isEmpty) {
                                          scaffoldMessenger.showSnackBar(SnackBar(
                                              content: Text(
                                                  "Por favor, ingrese su nombre(s)")));
                                          return;
                                        }
                                        if (_surnameController.text.isEmpty) {
                                          scaffoldMessenger.showSnackBar(SnackBar(
                                              content: Text(
                                                  "Por favor, ingrese sus apellidos")));
                                          return;
                                        }
                                        if (_curpController.text.isEmpty) {
                                          scaffoldMessenger.showSnackBar(SnackBar(
                                              content: Text(
                                                  "Por favor, ingrese su CURP")));
                                          return;
                                        }
                                        if (!reg
                                            .hasMatch(_emailController.text)) {
                                          scaffoldMessenger.showSnackBar(SnackBar(
                                              content: Text(
                                                  "Por favor, ingrese su correo electrónico")));
                                          return;
                                        }
                                        if (_passwordController.text.isEmpty ||
                                            _passwordController.text.length <
                                                6) {
                                          scaffoldMessenger.showSnackBar(SnackBar(
                                              content: Text(
                                                  "Su contraseña debe de tener más de 6 carácteres")));
                                          return;
                                        }
                                        signup(
                                            _nameController.text,
                                            _surnameController.text,
                                            _curpController.text,
                                            _emailController.text,
                                            _passwordController.text);
                                      },
                                      child: Text(
                                        "Crear Cuenta",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                letterSpacing: 1)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: (isLoading)
                                        ? Center(
                                            child: Container(
                                                height: 26,
                                                width: 26,
                                                child:
                                                    const CircularProgressIndicator(
                                                  backgroundColor: Colors.green,
                                                )))
                                        : Container(),
                                    right: 30,
                                    bottom: 0,
                                    top: 0,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, "/inicio-sesion");
                        },
                        child: Text(
                          "Ya tengo una cuenta",
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  decoration: TextDecoration.underline,
                                  letterSpacing: 0.5)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  signup(name, surname, curp, email, password) async {
    setState(() {
      isLoading = true;
    });
    print("Calling");

    Map data = {
      'name': name,
      'surname': surname,
      'curp': curp,
      'email': email,
      'password': password,
    };

    print(data.toString());
    final response = await http.post(Uri.parse(REGISTRATION),
        headers: {
          "Content-type": "application/x-www-form-urlencoded",
          'Accept': 'application/json'
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      print("${response.statusCode}");
      print("${response.body}");
      Map<String, dynamic> resposne = json.decode(response.body);
      if (resposne['error'] != null && resposne['error'] != "null") {
        Map<String, dynamic> user = resposne['data'];
        print(" User name ${user['data']}");
        savePref(1, user['name'], user['surname'], user['curp'], user['email'],
            user['id']);
        Navigator.pushReplacementNamed(context, "/inicio-sesion");
      } else {
        print(" ${resposne['message']}");
      }
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text("${resposne['message']}")));
    } else {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Por favor, intente de nuevo")));
    }
  }

  savePref(int value, String name, String surname, String curp, String email,
      int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("value", value);
    preferences.setString("name", name);
    preferences.setString("surname", surname);
    preferences.setString("curp", curp);
    preferences.setString("email", email);
    preferences.setString("id", id.toString());
  }
}
