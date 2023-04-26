
import 'package:flutter/material.dart';
import 'package:flutter_proyecto/inicio.dart';
import 'package:flutter_proyecto/pantalla_registro.dart';
import 'package:flutter_proyecto/pantalla_test.dart';
import 'package:flutter_proyecto/registro_adoptante.dart';
import 'package:flutter_proyecto/registro_protectora.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'package:flutter_proyecto/visualizar_animales.dart';
import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name) {
    case InicioSesionRoute:
      return MaterialPageRoute(builder: (context) => InicioSesion());
    case RegistroRoute:
      return MaterialPageRoute(builder: (context) => pantallaRegistro());
    case PantallaAdoptanteRoute:
      return MaterialPageRoute(builder: (context) => DogSearchScreen());
    case VisualizarAnimalesRoute:
      return MaterialPageRoute(builder: (context) => VisualizarAnimales(11));

    default:
      return MaterialPageRoute(builder: (context) => InicioSesion());
  }
}