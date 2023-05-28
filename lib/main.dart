import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'package:flutter_proyecto/pantalla_filtro.dart';
import 'package:flutter_proyecto/pantalla_protectora.dart';
import 'package:flutter_proyecto/pantalla_perfil_protectora.dart';
import 'package:flutter_proyecto/routing_constants.dart';
import 'package:flutter_proyecto/historial_adopciones.dart';
import 'package:flutter_proyecto/visualizar_animales.dart';
import 'app_localizations.dart';
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
      supportedLocales: [
        Locale('es', 'ES'),
        Locale('en', 'UK')
      ],
      locale: const Locale('es', 'ES'),
      localizationsDelegates: [
        // THIS CLASS WILL BE ADDED LATER
        // A class which loads the translations from JSON files
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
