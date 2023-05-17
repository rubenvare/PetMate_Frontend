import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'package:flutter_proyecto/pantalla_filtro.dart';
import 'package:flutter_proyecto/pantalla_protectora.dart';
import 'package:flutter_proyecto/pantalla_perfil_protectora.dart';
import 'package:flutter_proyecto/routing_constants.dart';
import 'package:flutter_proyecto/visualizar_animales.dart';
import 'router.dart' as router;
void main() {
  // el flag activado quita la etiqueta de Debug cuando ejecutas, aunque en el main no lo hace...
  runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PetMate',
      onGenerateRoute: router.generateRoute,
      initialRoute: InicioSesionRoute,
    );
  }
}
