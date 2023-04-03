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
    return Scaffold(
      appBar: const PetMateAppBar(),
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xFFC4A484),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'REGISTRO COMO PROTECTORA',
                              style: GoogleFonts.quicksand(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.0),
                            ),
                          ]),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  labelText: "Número de contacto",
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
                                }),
                            const SizedBox(height: 40),
                            TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  labelText: "Dirección de la protectora",
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: DirectionError
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                cursorColor: Colors.black,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      DirectionError = true;
                                    });
                                    return 'Este campo es obligatorio';
                                  } else {
                                    setState(() {
                                      DirectionError = false;
                                    });
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                print('Registro completado');
                                if (formkey.currentState?.validate() ?? false) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          icon: const Icon(Icons.pets_rounded),
                                          title: const Text(
                                              'Registro como protectora completado'),
                                          titleTextStyle: GoogleFonts.quicksand(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                          backgroundColor:
                                              const Color(0xFFC4A484),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          actions: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.brown),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Cerrar'))
                                              ],
                                            )
                                          ],
                                        );
                                      });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.brown),
                              child: Text(
                                'REGISTRARSE',
                                style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
