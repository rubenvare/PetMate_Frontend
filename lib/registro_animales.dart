import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(16.0), //Bordes a la pantalla en px
          child: Form(
            key: formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Tamaño de la vivienda en m2*"),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  }
                ),
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
                        Text('Animales en casa')
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
                        Text('Terraza en casa')
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
                        Text('Jardín')
                        
                      ]
                    )
                  ]
                ),
                  
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Tiempo disponible en horas/día"),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  }
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: (){

                  }, 
                  child: const Text('Registrarse'),
                  )
              ],
            ),
          ),
          ),));
  }
}