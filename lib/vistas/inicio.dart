import 'package:flutter/material.dart';
import 'package:diabetest/vistas/navbar.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
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
  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.fill,
                    height: 350,
                    width: 350,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 20.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: [],
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
    );
  }
}
