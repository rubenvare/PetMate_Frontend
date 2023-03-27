import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

bool switchAnimales = false;
bool switchTerraza = false;
bool switchJardin = false;

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}
class MyAppState extends State<MyApp> {
  final formkey = GlobalKey<FormState>();
  bool errorCasa = false;
  bool errorTiempo = false;

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
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'REGISTRO COMO ADOPTANTE',
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown)
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown)
                            ),
                            labelText: "Tamaño de la casa en m2*",
                            labelStyle: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: errorCasa ? Colors.red : Colors.black
                              ),
                            ),
                          cursorColor: Colors.brown,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              setState(() {
                                errorCasa = true;
                              });
                              return 'Este campo es obligatorio';
                            } else {
                              setState(() {
                                errorCasa = false;
                              });
                              return null;
                            }
                          }
                        ),
                        SizedBox(height: 40),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
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
                                Text(
                                  'Animales en casa',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  )
                                )
                              ]
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
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
                                Text(
                                  'Terraza en casa',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  )
                                )
                              ]
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
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
                              ]
                            )
                          ]
                        ),
                        SizedBox(height: 40),  
                        TextFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown)
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown)
                            ),
                            labelText: "Tiempo disponible en horas/día*",
                            labelStyle: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: errorTiempo ? Colors.red : Colors.black
                              ),
                            ),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              setState(() {
                                errorTiempo = true;
                              });
                              return 'Este campo es obligatorio';
                            } else {
                              setState(() {
                                errorTiempo = false;
                              });
                              return null;
                            }
                          }
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                          onPressed: () async {
                            print('Registro completado');
                            if (formkey.currentState?.validate() ?? false) {
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Registro Completado'),
                                    actions: <Widget>[
                                      TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }, 
                                      child: Text('Cerrar')
                                      )
                                    ],
                                  );
                                }
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown
                          ), 
                          child: Text(
                            'REGISTRARSE',
                            style: GoogleFonts.quicksand(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}