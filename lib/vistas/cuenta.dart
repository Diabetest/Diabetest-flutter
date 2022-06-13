import 'package:flutter/material.dart';
import 'dart:async';
import 'package:diabetest/vistas/navbar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Cuenta extends StatefulWidget {
  const Cuenta({Key? key}) : super(key: key);

  @override
  State<Cuenta> createState() => _CuentaState();
}

String email = "";
String name = "";
String surname = "";
String curp = "";
Timer? timer;

class _CuentaState extends State<Cuenta> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.Style2,
      menuScreen: const NavBar(),
      mainScreen: const MAIN_SCREEN(),
      borderRadius: 40.0,
      showShadow: true,
      angle: -12.0,
      backgroundColor: Colors.grey,
      slideWidth: MediaQuery.of(context).size.width * .65,
      openCurve: Curves.easeIn,
      closeCurve: Curves.easeInOut,
    );
  }
}

class MAIN_SCREEN extends StatefulWidget {
  const MAIN_SCREEN({Key? key}) : super(key: key);

  @override
  _MAIN_SCREENState createState() => _MAIN_SCREENState();
}

class _MAIN_SCREENState extends State<MAIN_SCREEN> {
  final _formKey = GlobalKey<FormState>();
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

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 0), () {
      setState(() {
        obtenerPreferencias();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  bool _obscureText = true;
  bool _obscureText1 = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        extendBodyBehindAppBar: true,
        floatingActionButton: Builder(
          builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color.fromARGB(255, 172, 86, 221),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      //Scaffold.of(context).openDrawer();
                      ZoomDrawer.of(context)!.toggle();
                    },
                    child: SizedBox(
                      height: 50, // Your Height
                      width: 50, // Your width
                      child: Icon(Icons.menu,
                          color: Color.fromARGB(221, 255, 255, 255)),
                    ),
                  ),
                ),
                // Your widgets here
              ],
            );
          },
        ),
        body: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 15.0),
                    child: SizedBox(
                      width: 150.0,
                      child: TextLiquidFill(
                        text: 'CUENTA',
                        waveColor: Color.fromARGB(255, 101, 93, 138),
                        boxBackgroundColor: Color.fromARGB(255, 177, 188, 230),
                        textStyle: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                        boxHeight: 150.0,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 20.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          controller: _nameController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            labelText: "Nombre(s): $name",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15),
                          ),
                          onSaved: (val) {
                            name = val!;
                          },
                          enabled: false,
                          readOnly: true,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          controller: _surnameController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            labelText: "Apellido: $surname",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15),
                          ),
                          onSaved: (val) {
                            surname = val!;
                          },
                          enabled: false,
                          readOnly: true,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          controller: _curpController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            labelText: "CURP: $curp",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(179, 0, 0, 0),
                                fontSize: 15),
                          ),
                          onSaved: (val) {
                            curp = val!;
                          },
                          enabled: false,
                          readOnly: true,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          controller: _emailController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            labelText: "Correo Electrónico:",
                            hintText: "$email",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(179, 0, 0, 0),
                                fontSize: 15),
                          ),
                          onSaved: (val) {
                            email = val!;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 0, 0, 0))),
                                    labelText: "Antigua Contraseña: ",
                                    hintText: "Escribe tu antigua contraseña",
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(179, 0, 0, 0),
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
                                      _obscureText ? "Mostrar" : "Ocultar",
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    )),
                              ),
                            ]),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 0, 0, 0))),
                                    labelText: "Nueva Contraseña",
                                    hintText: "Escribe tu nueva contraseña",
                                    hintStyle: TextStyle(
                                        color: Color.fromARGB(179, 0, 0, 0),
                                        fontSize: 15),
                                  ),
                                  obscureText: _obscureText1,
                                  onSaved: (val) {
                                    email = val!;
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                    onPressed: _toggle1,
                                    child: Text(
                                      _obscureText1 ? "Mostrar" : "Ocultar",
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
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
                              width: 210,
                              padding: EdgeInsets.all(10),
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
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
                                  if (!reg.hasMatch(_emailController.text)) {
                                    scaffoldMessenger.showSnackBar(SnackBar(
                                        content: Text(
                                            "Por favor, ingrese su correo electrónico")));
                                    return;
                                  }
                                  if (_passwordController.text.isEmpty ||
                                      _passwordController.text.length < 6) {
                                    scaffoldMessenger.showSnackBar(SnackBar(
                                        content: Text(
                                            "Su contraseña debe de tener más de 6 carácteres")));
                                    return;
                                  }
                                  /*signup(
                                            _nameController.text,
                                            _surnameController.text,
                                            _curpController.text,
                                            _emailController.text,
                                            _passwordController.text);*/
                                },
                                child: Text(
                                  "Actualizar Cuenta",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
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
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future obtenerPreferencias() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  name = preferences.getString("name") ?? "";
  surname = preferences.getString("surname") ?? "";
  curp = preferences.getString("curp") ?? "";
  email = preferences.getString("email") ?? "";
}
