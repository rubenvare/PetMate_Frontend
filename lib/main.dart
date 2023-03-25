import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
    )));
  }
}
