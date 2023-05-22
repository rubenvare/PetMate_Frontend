import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'package:flutter_proyecto/pantalla_detalles.dart';
import 'package:flutter_proyecto/pantalla_detalles_protectora.dart';
import 'package:flutter_proyecto/pantalla_perfil_protectora.dart';
import 'package:flutter_proyecto/singleton_user.dart';
import 'editar_animal.dart';
import 'inicio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'http_functions.dart';

class SavedPets extends StatefulWidget {
  int userId;

  SavedPets(this.userId);

  @override
  State<SavedPets> createState() => SavedPetsState(userId);
}

class SavedPetsState extends State<SavedPets> {
  int userId;
  Map<String, dynamic> datos = {};
  Map<String, dynamic> dato = {};
  StreamController<Map<String, dynamic>> _streamController = StreamController<Map<String, dynamic>>();

  SavedPetsState(this.userId);

  @override
  void initState() {
    super.initState();
    getDatos(userId);
  }

  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Future<void> getDatos(int userId) async {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      Map<String, dynamic> response = await savedRecord({'user_id': userId});
      setState(() {
        datos = response;
      });
      _streamController.add(datos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PetMateAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFC4A484),
        child: Column(
          children: [
            Container(
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      'HISTORIAL DE ANIMALES',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: datos.values.length,
                  itemBuilder: (context, index) {
                    final data = datos.values.elementAt(index);
                    Image? animalPhoto = getImage(data['photo']);
                    ImageProvider<Object>? imageProvider = animalPhoto.image;
                    return GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      Center(child: Text('Que quieres hacer?')),
                                  titleTextStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                  backgroundColor: const Color(0xFFC4A484),
                                  actions: [
                                    Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            dato = {
                                              "user_id": UserSession().userId,
                                              "animal_id": data['animal_id'],
                                              "action": 2
                                            };
                                            if (await resolveSavePet(dato)) {
                                              Navigator.pop(context);
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.black,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailScreen(data[
                                                              'animal_id'])));
                                            },
                                            icon: const Icon(
                                              Icons.info,
                                              color: Colors.black,
                                            )),
                                        IconButton(
                                            onPressed: () async {
                                              dato = {
                                                "user_id": UserSession().userId,
                                                "animal_id": data['animal_id'],
                                                "action": 1
                                              };
                                              if (await resolveSavePet(dato)) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: Colors.black,
                                            ))
                                      ],
                                    ))
                                  ],
                                );
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    data['name'],
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 24.0),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: imageProvider,
                                  )
                                ],
                              )
                            ],
                          ),
                        ));
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: PetMateNavBar(),
    );
  }
}
