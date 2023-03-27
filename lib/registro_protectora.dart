import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

class RegistroProtectora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PetMateAppBar(),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xFFC4A484),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
            "Registro como protectora",
             style: GoogleFonts.quicksand(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
             ),
            ),
          SizedBox(height: 70),
          Container(
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown)
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown)
                      ),
                    labelText: 'Número de contacto',
                    labelStyle: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                    )
                  ),
                  cursorColor: Colors.brown
                ),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown)
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown)
                  ),
                labelText: 'Dirección de la protectora',
                labelStyle: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
          ),
          cursorColor: Colors.brown
        ),
        SizedBox(height: 20),
        ElevatedButton(onPressed: (){print("Registro pulsado");},
        child: Text(
          "Registrarse",
          style: GoogleFonts.quicksand(
            fontSize: 14.0,
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0
        )),
        style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown,
    ))
              ],
            ),
          ),
            ],
          ),
        ),


      ),
    ),
    );
  }
}


