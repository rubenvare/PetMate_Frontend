import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_proyecto/inicio.dart';
import 'router.dart';

class RegistroProtectora extends StatefulWidget {
  @override
  State<RegistroProtectora> createState() => _RegistroProtectoraState();
}
class _RegistroProtectoraState extends State<RegistroProtectora> {
  final formkey = GlobalKey<FormState>();
  bool NumberError = false;
  bool DirectionError = false;

  RegExp regExp = RegExp(r'(^[0-9]*$)');
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
              children:<Widget> [
                TextFormField(
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
                      color: NumberError
                        ? Colors.red
                        : Colors.black),

                  ),

                  cursorColor: Colors.brown,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                  if (value?.isEmpty ?? true) {
                      setState(() {
                      NumberError = true;
                    });
                    return 'Este campo es obligatorio';
                  } else if (!regExp.hasMatch(value!)) {
                      setState(() {
                      NumberError = true;
                    });
                    return 'Este campo requiere de números';
                  } else {
                    setState(() {
                    NumberError = false;
                    });
                  return null;
                }
            }
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



