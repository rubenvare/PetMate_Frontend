import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// hay que resolver dependencias de google fonts!!!!
// entra a pubspec.yaml y añade, en dependencies, "google_fonts: ^4.0.3" y luego haz pub get
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          toolbarHeight: 70,

          title: Text(
            'PetMate',
            style:
              GoogleFonts.alfaSlabOne(fontSize: 35.0, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.brown,
          leading:
            const Icon(Icons.pets_rounded ),
    ))


    ;
  }
}
