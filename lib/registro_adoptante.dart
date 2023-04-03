import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'inicio.dart';
import 'router.dart';

class RegistroAdoptante extends StatefulWidget {
  @override
  State<RegistroAdoptante> createState() => _RegistroAdoptanteState();
}

class _RegistroAdoptanteState extends State<RegistroAdoptante> {
  final formkey = GlobalKey<FormState>();
  bool houseError = false;
  bool timeError = false;
  bool switchAnimales = false;
  bool switchTerraza = false;
  bool switchJardin = false;

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
                              'REGISTRO COMO ADOPTANTE',
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
                                  labelText: "Tamaño de la casa en m2*",
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: houseError
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                cursorColor: Colors.brown,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      houseError = true;
                                    });
                                    return 'Este campo es obligatorio';
                                  } else if (!regExp.hasMatch(value!)) {
                                    setState(() {
                                      houseError = true;
                                    });
                                    return 'Este campo requiere de números';
                                  } else {
                                    setState(() {
                                      houseError = false;
                                    });
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 40),
                            Column(children: <Widget>[
                              Row(children: <Widget>[
                                Switch(
                                  value: switchAnimales,
                                  onChanged: (bool value) {
                                    setState(() {
                                      switchAnimales = value;
                                    });
                                  },
                                  activeTrackColor: Colors.brown,
                                  activeColor: Colors.white,
                                ),
                                Text('Animales en casa',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ))
                              ]),
                              const SizedBox(height: 5),
                              Row(children: <Widget>[
                                Switch(
                                  value: switchTerraza,
                                  onChanged: (bool value) {
                                    setState(() {
                                      switchTerraza = value;
                                    });
                                  },
                                  activeTrackColor: Colors.brown,
                                  activeColor: Colors.white,
                                ),
                                Text('Terraza en casa',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ))
                              ]),
                              const SizedBox(height: 5),
                              Row(children: <Widget>[
                                Switch(
                                  value: switchJardin,
                                  onChanged: (bool value) {
                                    setState(() {
                                      switchJardin = value;
                                    });
                                  },
                                  activeTrackColor: Colors.brown,
                                  activeColor: Colors.white,
                                ),
                                Text(
                                  'Jardín',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ])
                            ]),
                            const SizedBox(height: 40),
                            TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  labelText: "Tiempo disponible en horas/día*",
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: timeError
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      timeError = true;
                                    });
                                    return 'Este campo es obligatorio';
                                  } else if (!regExp.hasMatch(value!)) {
                                    setState(() {
                                      timeError = true;
                                    });
                                    return 'Este campo requiere de números';
                                  } else {
                                    setState(() {
                                      timeError = false;
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
                                          title:
                                              const Text('Registro Completado'),
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
