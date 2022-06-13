import 'package:flutter/material.dart';
import 'package:diabetest/vistas/navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Registros extends StatefulWidget {
  const Registros({Key? key}) : super(key: key);

  @override
  State<Registros> createState() => _RegistrosState();
}

class _RegistrosState extends State<Registros> {
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
  late DateFormat dayFormat;
  late DateFormat dateFormat;
  bool isLoading = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late ScaffoldMessengerState scaffoldMessenger;

  final GlobalKey<FormState> _claveFormulario = GlobalKey<FormState>();

  final TextEditingController campo1 = TextEditingController();

  final TextEditingController campo2 = TextEditingController();

  final TextEditingController campo3 = TextEditingController();

  final TextEditingController campo4 = TextEditingController();

  final TextEditingController campo5 = TextEditingController();

  final TextEditingController campo6 = TextEditingController();

  var nivel_glucosa = 0;
  String fecha = "";

  clearTextInput() {
    campo1.clear();
    campo2.clear();
    campo3.clear();
    campo4.clear();
    campo5.clear();
    campo6.clear();
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dayFormat = new DateFormat.EEEE('es_MX');
    dateFormat = new DateFormat.yMMMMd('es_MX');
  }

  var dateTime = DateTime.now();
  DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('MM-dd-yyyy');
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextLiquidFill(
                            text: 'REGISTRO DE NIVELES',
                            waveColor: Color.fromARGB(255, 101, 93, 138),
                            boxBackgroundColor:
                                Color.fromARGB(255, 177, 188, 230),
                            textStyle: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                            ),
                            boxHeight: 150.0,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 1.1,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          color: const Color(0xff81e5cd),
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    const Text(
                                      'Glucosa (mg/dl)',
                                      style: TextStyle(
                                          color: Color(0xff0f4a3c),
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Registre los niveles de glucosa de hoy ' +
                                          dayFormat.format(dateTime) +
                                          " " +
                                          dateFormat.format(dateTime),
                                      style: TextStyle(
                                          color: Color(0xff379982),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Nivel de Glucosa',
                                        hintText: 'Ingrese el nivel de glucosa',
                                      ),
                                      onChanged: (val1) {
                                        nivel_glucosa = int.parse(val1);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'El nivel de glucosa es un campo obligatorio';
                                        }
                                        return null;
                                      },
                                      controller: campo1,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText:
                                            'Fecha: ${formatter.format(DateTime.now())}',
                                      ),
                                      onChanged: (val2) {
                                        fecha =
                                            formatter.format(DateTime.now());
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'La fecha es un campo obligatorio';
                                        }
                                        return null;
                                      },
                                      controller: campo2,
                                      enabled: false,
                                      readOnly: true,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Center(
                                      child: Stack(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 210,
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                if (isLoading) {
                                                  return;
                                                }
                                                if (campo1.text.isEmpty) {
                                                  scaffoldMessenger
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Por favor, ingrese el nivel de glucosa")));
                                                  return;
                                                }
                                                if (campo2.text.isEmpty) {
                                                  scaffoldMessenger
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Por favor, ingrese la fecha")));
                                                  return;
                                                }
                                                clearTextInput();
                                                /*signup(
                                            _nameController.text,
                                            _surnameController.text,
                                            _curpController.text,
                                            _emailController.text,
                                            _passwordController.text);*/
                                              },
                                              child: Text(
                                                "Enviar",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                            right: 30,
                                            bottom: 0,
                                            top: 0,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 0.95,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          color: Color.fromARGB(255, 143, 185, 219),
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    const Text(
                                      'Presión Arterial - Sistólica (mm Hg)',
                                      style: TextStyle(
                                          color: Color(0xff0f4a3c),
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Registre los niveles de presión arterial sistólica de hoy ' +
                                          dayFormat.format(dateTime) +
                                          " " +
                                          dateFormat.format(dateTime),
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 55, 106, 153),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText:
                                            'Nivel de Presión Arterial Sistólica',
                                        hintText:
                                            'Ingrese el nivel de presión arterial sistólica',
                                      ),
                                      onChanged: (val3) {
                                        nivel_glucosa = int.parse(val3);
                                      },
                                      validator: (value3) {
                                        if (value3!.isEmpty) {
                                          return 'El nivel de presión arterial sistólica es un campo obligatorio';
                                        }
                                        return null;
                                      },
                                      controller: campo3,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText:
                                            'Fecha: ${formatter.format(DateTime.now())}',
                                      ),
                                      onFieldSubmitted: (val4) {
                                        fecha =
                                            formatter.format(DateTime.now());
                                      },
                                      validator: (value4) {
                                        if (value4!.isEmpty) {
                                          return 'La fecha es un campo obligatorio';
                                        }
                                        return null;
                                      },
                                      controller: campo4,
                                      enabled: false,
                                      readOnly: true,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Center(
                                      child: Stack(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 210,
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                if (isLoading) {
                                                  return;
                                                }
                                                if (campo3.text.isEmpty) {
                                                  scaffoldMessenger
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Por favor, ingrese su nivel de presión arterial sistólica")));
                                                  return;
                                                }
                                                /**if (campo4.text.isEmpty) {
                                                  scaffoldMessenger
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Por favor, ingrese la fecha")));
                                                  return;
                                                }**/
                                                clearTextInput();
                                                /*signup(
                                            _nameController.text,
                                            _surnameController.text,
                                            _curpController.text,
                                            _emailController.text,
                                            _passwordController.text);*/
                                              },
                                              child: Text(
                                                "Enviar",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                            right: 30,
                                            bottom: 0,
                                            top: 0,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 0.95,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          color: Color.fromARGB(255, 143, 185, 219),
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    const Text(
                                      'Presión Arterial - Diastólica (mm Hg)',
                                      style: TextStyle(
                                          color: Color(0xff0f4a3c),
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Registre los niveles de presión arterial diastólica de hoy ' +
                                          dayFormat.format(dateTime) +
                                          " " +
                                          dateFormat.format(dateTime),
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 55, 106, 153),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText:
                                            'Nivel de Presión Arterial Diastólica',
                                        hintText:
                                            'Ingrese el nivel de presión arterial diastólica',
                                      ),
                                      onChanged: (val1) {
                                        nivel_glucosa = int.parse(val1);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'El nivel de presión arterial diastólica es un campo obligatorio';
                                        }
                                        return null;
                                      },
                                      controller: campo1,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText:
                                            'Fecha: ${formatter.format(DateTime.now())}',
                                      ),
                                      onChanged: (val2) {
                                        fecha =
                                            formatter.format(DateTime.now());
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'La fecha es un campo obligatorio';
                                        }
                                        return null;
                                      },
                                      controller: campo2,
                                      enabled: false,
                                      readOnly: true,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Center(
                                      child: Stack(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 210,
                                            padding: EdgeInsets.all(10),
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                if (isLoading) {
                                                  return;
                                                }
                                                if (campo1.text.isEmpty) {
                                                  scaffoldMessenger
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Por favor, ingrese su nivel de presión arterial diastólica")));
                                                  return;
                                                }
                                                if (campo2.text.isEmpty) {
                                                  scaffoldMessenger
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Por favor, ingrese la fecha")));
                                                  return;
                                                }
                                                clearTextInput();
                                                /*signup(
                                            _nameController.text,
                                            _surnameController.text,
                                            _curpController.text,
                                            _emailController.text,
                                            _passwordController.text);*/
                                              },
                                              child: Text(
                                                "Enviar",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                            right: 30,
                                            bottom: 0,
                                            top: 0,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
