import 'package:flutter/material.dart';
import 'package:flutter_proyecto/inicio.dart';
import 'package:flutter_proyecto/pantalla_registro.dart';
import 'package:flutter_proyecto/pantalla_test.dart';
import 'package:flutter_proyecto/registro_adoptante.dart';
import 'package:flutter_proyecto/registro_protectora.dart';
import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name) {
    case InicioSesionRoute:
      return MaterialPageRoute(builder: (context) => InicioSesion());
    case RegistroRoute:
      return MaterialPageRoute(builder: (context) => pantallaRegistro());
    case RegistroProtectoraRoute:
      return MaterialPageRoute(builder: (context) => RegistroProtectora());
    case RegistroAdoptanteRoute:
      return MaterialPageRoute(builder: (context) => RegistroAdoptante());
    case PantallaTestRoute:
      return MaterialPageRoute(builder: (context) => PantallaTest());
    default:
      return MaterialPageRoute(builder: (context) => InicioSesion());
  }
}