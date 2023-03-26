import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

GlobalKey formkey = GlobalKey<FormState>();
bool switchAnimales = false;
bool switchTerraza = false;
bool switchJardin = false;

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}
class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
    ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Color(0xFFC4A484),
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
                            color: Colors.black
                            ),
                          ),
                        cursorColor: Colors.brown,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Este campo es obligatorio';
                          }
                          return null;
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
                            color: Colors.black
                            ),
                          ),
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Este campo es obligatorio';
                          }
                          return null;
                        }
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: (){
                          print('Registro completado');
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
    );
  }
}