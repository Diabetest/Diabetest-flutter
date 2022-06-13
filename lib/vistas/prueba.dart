import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:diabetest/vistas/navbar.dart';
import 'package:diabetest/controlador/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

class Prueba extends StatefulWidget {
  Prueba({Key? key}) : super(key: key);

  @override
  State<Prueba> createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
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

_onBasicAlertPressed(context, resp) {
  showDialog(
    context: context,
    barrierDismissible: true, // <-- Set this to false.
    builder: (_) => Container(
      child: AlertDialog(
        title: Text("DIAGNOSTICO DIABETES",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 30)),
        content: Container(
          height: 140,
          child: Column(children: [
            Text(resp,
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.black, fontSize: 22)),
            Spacer(),
            DialogButton(
              child: const Text(
                "Salir",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop('dialog'),
              width: 120,
            )
          ]),
        ),
      ),
    ),
  );
  /*Alert(
    context: context,
    title: "DIAGNOSTICO DIABETES",
    desc: resp,
    barrierDismissible: false,
    buttons: [
      DialogButton(
        child: const Text(
          "Salir",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();*/
}

class MAIN_SCREEN extends StatefulWidget {
  const MAIN_SCREEN({Key? key}) : super(key: key);

  @override
  _MAIN_SCREENState createState() => _MAIN_SCREENState();
}

class _MAIN_SCREENState extends State<MAIN_SCREEN> {
  final GlobalKey<FormState> _claveFormulario = GlobalKey<FormState>();

  final TextEditingController campo1 = TextEditingController();

  final TextEditingController campo2 = TextEditingController();

  final TextEditingController campo3 = TextEditingController();

  final TextEditingController campo4 = TextEditingController();

  final TextEditingController campo5 = TextEditingController();

  final TextEditingController campo6 = TextEditingController();

  final TextEditingController campo7 = TextEditingController();

  final TextEditingController campo8 = TextEditingController();

  var embarazos = 0,
      glucosa = 0,
      presion = 0,
      grosor = 0,
      insulina = 0,
      bmi = 0.0,
      funcion = 0.0,
      edad = 0;

  Future<String?> predecirDiabetes(var body) async {
    var client = http.Client();
    var uri = Uri.parse("https://diabetest-app-api.herokuapp.com/predict");
    //print(uri);
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Access-Control_Allow_Origin": "*"
    };
    String jsonString = json.encode(body);
    try {
      var resp = await client.post(uri, headers: headers, body: jsonString);
      //var resp1 = await http.get(uri);
      if (resp.statusCode == 200) {
        print("DATA FETCHED SUCCESSFULLY");
        var result = json.decode(resp.body);
        print("El resultado es: " + result["prediction"]);
        //print(result["prediction"]);
        return result["prediction"];
      }
    } catch (e) {
      print("EXCEPTION OCCURRED: $e");
      return null;
    }
    return null;
  }

  clearTextInput() {
    campo1.clear();
    campo2.clear();
    campo3.clear();
    campo4.clear();
    campo5.clear();
    campo6.clear();
    campo7.clear();
    campo8.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _claveFormulario,
      child: Scaffold(
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
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        extendBodyBehindAppBar: true,
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
                    child: SizedBox(
                      width: 150.0,
                      child: TextLiquidFill(
                        text: 'PRUEBA DE DIABETEST',
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
                  SizedBox(
                    width: 300.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontFamily: 'Bobbers',
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                              'El modelo de machine learning para la detección de problemas del azúcar como lo es la diabetes, haciendo uso del aprendizaje automático por medio de una serie de preguntas con análisis profundo para poder proveer una predicción sobre si se sufre de este padecimiento.'),
                        ],
                        repeatForever: false,
                        totalRepeatCount: 1,
                        displayFullTextOnTap: true,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: [
                          Text(
                            "Formulario",
                            style: TextStyle(fontSize: 25.0),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Número de Embarazos',
                              hintText: 'Ingrese el número de embarazos',
                            ),
                            onChanged: (val1) {
                              embarazos = int.parse(val1);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El número de embarazos es un campo obligatorio';
                              }
                              return null;
                            },
                            controller: campo1,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Nivel de Glucosa',
                              hintText: 'Ingrese el nivel de glucosa',
                            ),
                            onChanged: (val2) {
                              glucosa = int.parse(val2);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El nivel de glucosa es un campo obligatorio';
                              }
                              return null;
                            },
                            controller: campo2,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Presión Arterial',
                              hintText: 'Ingrese la presión arterial',
                            ),
                            onChanged: (val3) {
                              presion = int.parse(val3);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'La presión arterial es un campo obligatorio';
                              }
                              return null;
                            },
                            controller: campo3,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Grosor de la Piel',
                              hintText: 'Ingrese el grosor de la piel',
                            ),
                            onChanged: (val4) {
                              grosor = int.parse(val4);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El grosor de la piel es un campo obligatorio';
                              }
                              return null;
                            },
                            controller: campo4,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Nivel de Insulina',
                              hintText: 'Ingrese el nivel de insulina',
                            ),
                            onChanged: (val5) {
                              insulina = int.parse(val5);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El nivel de insulina es un campo obligatorio';
                              }
                              return null;
                            },
                            controller: campo5,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Índice de Masa Corporal (IMC)',
                              hintText: 'Ingrese el índice de masa corporal',
                            ),
                            onChanged: (val6) {
                              bmi = double.parse(val6);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El índice de masa corporal es un campo obligatorio';
                              }
                              return null;
                            },
                            controller: campo6,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Predisposición Diabetica',
                              hintText: 'Ingrese la predisposición diabetica',
                            ),
                            onChanged: (val7) {
                              funcion = double.parse(val7);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'La predisposición diabetica es un campo obligatorio';
                              }
                              return null;
                            },
                            controller: campo7,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Edad',
                              hintText: 'Ingrese su edad',
                            ),
                            onChanged: (val8) {
                              edad = int.parse(val8);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'La edad es un campo obligatorio';
                              }
                              return null;
                            },
                            controller: campo8,
                          ),
                          Container(
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(20)),
                              ),
                              onPressed: () async {
                                if (!_claveFormulario.currentState!
                                    .validate()) {
                                  return;
                                } else {
                                  var body = [
                                    {
                                      "Pregnancies": embarazos,
                                      "Glucose": glucosa,
                                      "BloodPressure": presion,
                                      "SkinThickness": grosor,
                                      "Insulin": insulina,
                                      "BMI": bmi,
                                      "DiabetesPedigreeFunction": funcion,
                                      "Age": edad
                                    }
                                  ];
                                  print(body[0]);
                                  var resp = await predecirDiabetes(body);
                                  print(resp);
                                  if (resp == '1') {
                                    resp =
                                        "Tienes una probabilidad considerable de tener diabetes.";
                                  } else if (resp == '0') {
                                    resp =
                                        "Felicidades, usted está libre de diabetes.";
                                  } else {
                                    resp =
                                        "Se encontró un problema. Vuelva a intentar más tarde.";
                                  }
                                  _onBasicAlertPressed(context, resp);
                                  clearTextInput();
                                }
                              },
                              child: const Text(
                                "Obtener predicción",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            margin: const EdgeInsets.only(top: 20.0),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
