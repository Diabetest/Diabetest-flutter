import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:diabetest/vistas/inicio-sesion.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

String email = "";
String name = "";
String surname = "";
Timer? timer;

class _NavBarState extends State<NavBar> {
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

  Widget build(BuildContext context) {
    /*if (!mounted) {
      Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {
          obtenerPreferencias();
        });
      });
    } else {
      setState(() {
        obtenerPreferencias();
      });
    }*/
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("$name $surname"),
            accountEmail: Text("$email"),
            otherAccountsPictures: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.fill,
                ),
              ),
            ],
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: /*Image.network(
                  'https://scontent.fmex11-1.fna.fbcdn.net/v/t39.30808-6/271766994_2103641959802745_1110799881618958964_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=6wsJVqet-_IAX_gF4FI&_nc_ht=scontent.fmex11-1.fna&oh=00_AT_fNE5rEeAOTNBM0m4cowtAte7pWU-Zwnt749oR0W55sg&oe=628D4099',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),*/
                    Center(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      "assets/foto_perfil_gen.jpeg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () => {
              // Navigate to the second screen using a named route.
              Navigator.of(context).pushNamed('/inicio')
            },
          ),
          ListTile(
            leading: Icon(Icons.biotech),
            title: Text('Prueba'),
            onTap: () => {
              // Navigate to the second screen using a named route.
              Navigator.of(context).pushNamed('/prueba')
            },
          ),
          ListTile(
            leading: Icon(Icons.bloodtype),
            title: Text('Registros'),
            onTap: () => {Navigator.of(context).pushNamed('/registros')},
          ),
          ListTile(
            leading: Icon(Icons.analytics),
            title: Text('Estadisticas'),
            onTap: () => {Navigator.of(context).pushNamed('/estadisticas')},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Cuenta'),
            onTap: () => {
              // Navigate to the second screen using a named route.
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/cuenta', (Route<dynamic> route) => false)
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ajustes'),
            onTap: () => {Navigator.of(context).pushNamed('/ajustes')},
          ),
          Divider(),
          ListTile(
              title: Text('Cerrar Sesión'),
              leading: Icon(Icons.logout),
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  '/inicio-sesion', (Route<dynamic> route) => false)),
          ListTile(
            title: Text('Salir'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => exit(0),
          ),
        ],
      ),
    );
  }
}

Future obtenerPreferencias() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  name = preferences.getString("name") ?? "";
  surname = preferences.getString("surname") ?? "";
  email = preferences.getString("email") ?? "";
}
