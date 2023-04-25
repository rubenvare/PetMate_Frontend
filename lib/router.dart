import 'package:flutter/material.dart';
import 'package:flutter_proyecto/inicio.dart';
import 'package:flutter_proyecto/pantalla_protectora.dart';
import 'package:flutter_proyecto/pantalla_registro.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name) {
    case InicioSesionRoute:
      return MaterialPageRoute(builder: (context) => InicioSesion());
    case RegistroRoute:
      return MaterialPageRoute(builder: (context) => pantallaRegistro());
    case PantallaAdoptanteRoute:
      return MaterialPageRoute(builder: (context) => DogSearchScreen());
    case PantallaProtectoraRoute:
      return MaterialPageRoute(builder: (context) => PantallaProtectoraItems("null", "null"));
    default:
      return MaterialPageRoute(builder: (context) => InicioSesion());
  }
}