import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'dart:async';

import 'package:diabetest/vistas/inicio.dart';
import 'package:flutter/material.dart';
import 'package:diabetest/modelo/http_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diabetest/modelo/api.dart';

import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String user = "", email = "", password = "", val1 = "";
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  Timer? timer;
  bool _obscureText = true;

  checkValue() async {
    final val = await Validater().getUser();
    val == 0 ? val1 = "yes" : val1 = "no";
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 0), () {
      setState(() {
        checkValue();
      });
    });
    _progress = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      EasyLoading.showProgress(_progress,
          status: '${(_progress * 100).toStringAsFixed(0)} %');
      _progress += 0.03;

      if (_progress >= 1) {
        _timer?.cancel();
        EasyLoading.dismiss();
      }
      if (_progress >= 1) {
        EasyLoading.showSuccess('¡Bienvenido!');
      }
    });
  }

  Timer? _timer;
  late double _progress;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);

    /*if (!mounted) {
      Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {
          checkValue();
        });
      });
    } else {
      setState(() {
        checkValue();
      });
    }*/
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
                      const SizedBox(
                        height: 13,
                      ),
                      Text(
                        "¡Bienvenido a Diabetest!",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 27,
                                color: Colors.white,
                                letterSpacing: 1)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 180,
                        child: Text(
                          "Diabetest Company",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                color: Colors.white54,
                                letterSpacing: 0.6,
                                fontSize: 11),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Inicio de Sesión",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontSize: 23,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 45),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _emailController,
                                decoration: const InputDecoration(
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
                              const SizedBox(
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
                                  GestureDetector(
                                    onTap: () {
                                      if (isLoading) {
                                        return;
                                      }
                                      if (_emailController.text.isEmpty ||
                                          _passwordController.text.isEmpty) {
                                        scaffoldMessenger.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "Por favor, ingrese todos los datos solicitados")));
                                        return;
                                      }
                                      login(_emailController.text,
                                          _passwordController.text);
                                      setState(() {
                                        isLoading = true;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 0),
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        "Iniciar Sesión",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
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
                      if (val1 == "no")
                        const Text(
                          "O",
                          style: TextStyle(fontSize: 14, color: Colors.white60),
                        )
                      else
                        const SizedBox(
                          height: 1,
                        ),
                      if (val1 == "no")
                        const SizedBox(
                          height: 20,
                        )
                      else
                        const SizedBox(
                          height: 1,
                        ),
                      if (val1 == "no")
                        GestureDetector(
                          onTap: () async {
                            /*bool isAuthenticated =
                              await AuthService.authenticateUser();
                          if (isAuthenticated) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Inicio()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Autenticación Fallida.'),
                              ),
                            );
                          }*/
                            bool isAuthenticated =
                                await SessionParams.loginWithBiometrics(
                                    email, password, true);
                            if (isAuthenticated == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Inicio()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Autenticación Fallida.'),
                                ),
                              );
                            }
                          },
                          child: Image.asset(
                            "assets/fingerprint.png",
                            height: 36,
                            width: 36,
                          ),
                        )
                      else
                        const SizedBox(
                          height: 5,
                        ),
                      if (val1 == "no")
                        const SizedBox(
                          height: 30,
                        )
                      else
                        const SizedBox(
                          height: 1,
                        ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/registro");
                        },
                        child: Text(
                          "¿Aún no tienes una cuenta?",
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

  login(email, password) async {
    Map data = {'email': email, 'password': password};
    print(data.toString());
    final response = await http.post(Uri.parse(LOGIN),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (mounted) {
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);
        if (resposne['error'] != null && resposne['error'] != "null") {
          Map<String, dynamic> user = resposne['data'];
          print("User name ${user['id']}");
          savePref(1, user['name'], user['surname'], user['curp'],
              user['email'], user['id']);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/inicio', (Route<dynamic> route) => false);
        } else {
          print("${resposne['message']}");
        }
        scaffoldMessenger
            .showSnackBar(SnackBar(content: Text("${resposne['message']}")));
      } else {
        scaffoldMessenger.showSnackBar(
            const SnackBar(content: Text("Por favor, intente de nuevo")));
      }
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

class Validater {
  Future<int> getUser() async {
    var prefs = await SharedPreferences.getInstance();
    var user = prefs.getString("email") ?? '';
    //print("Usuario: $user");
    if (user == '') {
      return Future.value(0);
      ;
    } else {
      return Future.value(1);
      ;
    }
  }
}

class SessionParams {
  static final String _userKey = '_userKey';
  static final String _passwordKey = '_passwordKey';
  final String user;
  final String password;

  SessionParams._(this.user, this.password);

  static Future<void> deleteSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<SessionParams> getSession() async {
    var prefs = await SharedPreferences.getInstance();
    var user = prefs.getString(_userKey) ?? '';
    var password = prefs.getString(_passwordKey) ?? '';
    return SessionParams._(user, password);
  }

  /// ❗ Throwable Function
  Future<void> saveSession(String user, String password) async {
    var prefs = await SharedPreferences.getInstance();
    var isSaveUserParam = await prefs.setString(_userKey, user);
    var isSavePasswordParam = await prefs.setString(_passwordKey, password);

    if (isSaveUserParam && isSavePasswordParam) return;

    deleteSession();
    throw '<SessionParams> session not saved';
  }

  @override
  String toString() {
    return 'SessionParams {user: $user, password $password}';
  }

  Future<bool> _canCheckBiometrics() async {
    final LocalAuthentication _auth = LocalAuthentication();
    return await _auth.canCheckBiometrics;
  }

  Future<bool> _faceIdAvailable() async {
    final LocalAuthentication _auth = LocalAuthentication();
    List<BiometricType> availableBiometrics =
        await _auth.getAvailableBiometrics();
    if (Platform.isIOS && availableBiometrics.contains(BiometricType.face))
      return true;
    return false;
  }

  static Future<bool> _authenticateWithBiometrics() async {
    bool authenticated = false;

    final LocalAuthentication _auth = LocalAuthentication();

    try {
      authenticated = await _auth.authenticate(
          localizedReason: 'Escanea tu huella dactilar para iniciar sesión',
          options: const AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: true, biometricOnly: true));
    } on PlatformException catch (e) {
      print(e);
      return authenticated;
    } catch (e) {
      print('Oooopps Algo salio mal 🤷‍♂️');
    }

    return authenticated;
  }

  static Future<bool> loginWithBiometrics(
      String user, String password, bool remember) async {
    try {
      var session = await SessionParams.getSession();
      var authenticateWithBiometrics = await _authenticateWithBiometrics();

      if (authenticateWithBiometrics) {
        if (remember) {
          await (await SessionParams.getSession()).saveSession(user, password);
          return true;
        }
      }
    } catch (e) {
      print('Oooopps Algo salio mal 🤷‍♂️');
    }
    return false;
  }
}

/*class AuthService {
  static Future<bool> authenticateUser() async {
    final LocalAuthentication _localAuthentication = LocalAuthentication();

    bool isAuthenticated = false;

    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();

    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;

    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
            localizedReason: 'Escanea tu huella dactilar para iniciar sesión',
            options: const AuthenticationOptions(
                biometricOnly: true, useErrorDialogs: true, stickyAuth: true));
      } on PlatformException catch (e) {
        print(e);
      }
    }
    return isAuthenticated;
  }
}*/
