import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

class RegistroProtectora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
      backgroundColor: Color(0xFFC4A484),
      appBar: PetMateAppBar(),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Número del contacto",
                    border: OutlineInputBorder(),
                    labelStyle: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                    )
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Dirección de la protectora",
                    border: OutlineInputBorder(),
                    labelStyle: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                    )
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {print("Registro pulsado");},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                    child: Text("Registrarse"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
     )
    );
  }
}
