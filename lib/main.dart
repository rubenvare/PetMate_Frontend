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
                  "¡BIENVENIDO!",
                  style: GoogleFonts.quicksand(
                    fontSize: 37.0,
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
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Correo electrónico',
                            labelStyle: GoogleFonts.quicksand(
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                            )
                        ),
                      ),
                      SizedBox(height: 40),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Contraseña',
                            labelStyle: GoogleFonts.quicksand(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),

                      SizedBox(height: 20),
                      ElevatedButton(onPressed: (){print("Inicio de sesión pulsado");},
                          child: Text(
                              "LOGIN",
                              style: GoogleFonts.quicksand(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.0
                              )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                          )),
                      SizedBox(height: 50),
                      Text("¿No tienes cuenta?",
                          style: GoogleFonts.quicksand(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0
                          )
                      ),
                      SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){print("Registro pulsado");},
                          child: Text(
                              "REGISTRO",
                              style: GoogleFonts.quicksand(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.0
                              )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                          )),


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

class PetMateAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PetMateAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(70);
  @override
  Widget build(BuildContext context) {
    return AppBar(toolbarHeight: 70,
      title: Text(
        'PetMate',
        style:
        GoogleFonts.alfaSlabOne(fontSize: 35.0, color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Colors.brown,
      leading:
      const Icon(Icons.pets_rounded ),
    );
  }

}

