import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_proyecto/registro_protectora.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(home: RegistroProtectora()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: PetMateAppBar(),

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Text(
                "Iniciar sesión",
                style:
                GoogleFonts.alfaSlabOne(fontSize: 37.0, color: Colors.black, fontWeight: FontWeight.normal,
                letterSpacing: 2.0),
              ),
              Container()
            ],
          ),
        )
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
