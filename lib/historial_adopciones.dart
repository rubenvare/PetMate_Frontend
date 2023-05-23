import 'package:flutter/material.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'package:flutter_proyecto/pantalla_perfil_protectora.dart';
import 'editar_animal.dart';
import 'inicio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'http_functions.dart';

class HistorialAdopciones extends StatefulWidget {
  int userId;

  HistorialAdopciones(this.userId);

  @override
  State<HistorialAdopciones> createState() => HistorialAdopcionesState(userId);
}

class HistorialAdopcionesState extends State<HistorialAdopciones> {
  int userId;
  Map<String, dynamic> datos = {};
  Map<String, dynamic> shelter = {};
  Image? shelterLogo;

  HistorialAdopcionesState(this.userId);

  @override
  void initState() {
    super.initState();
    getDatos(userId);
  }

  Future<void> getDatos(int userId) async {
    Map<String, dynamic> response = await retiredRecord({'user_id': userId});
    setState(() {
      datos = response;
    });
    Map<String, dynamic> shelterResponse =
        await getProfileInfo({'user_id': userId, 'type': 'S'});
    setState(() {
      shelterLogo = getImage(shelterResponse['photo']);
    });
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
                          print('isma perro');
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


