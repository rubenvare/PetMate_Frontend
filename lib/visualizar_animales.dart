import 'package:flutter/material.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'inicio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'http_functions.dart';

class VisualizarAnimales extends StatefulWidget {
  int userId;

  VisualizarAnimales(this.userId);

  @override
  State<VisualizarAnimales> createState() => VisualizarAnimalesState(userId);
}

class VisualizarAnimalesState extends State<VisualizarAnimales> {
  int userId;
  Map<String, dynamic> datos = {};
  Map<String, dynamic> shelter = {};
  Image? shelterLogo;

  VisualizarAnimalesState(this.userId);

  @override
  void initState() {
    super.initState();
    getDatos(userId);
  }

  Future<void> getDatos(int userId) async {
    Map<String, dynamic> response = await showPets({'user_id': userId});
    setState(() {
      datos = response;
    });
    Map<String, dynamic> shelterResponse = await getProfileInfo({'user_id': userId, 'type': 'S'});
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
            Row(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(165, 35),
                            backgroundColor: Colors.brown),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text("PROTECTORA",
                              style: GoogleFonts.quicksand(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.0)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print(datos);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(165, 35),
                            backgroundColor: Colors.brown),
                        child: Text("MASCOTAS",
                            style: GoogleFonts.quicksand(
                                fontSize: 14.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.0)),
                      ),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: Container(
                    width: 100,
                    child: shelterLogo,
                  ))
            ]),
            Expanded(
              child: ListView.builder(
                  itemCount: datos.values.length,
                  itemBuilder: (context, index) {
                    final data = datos.values.elementAt(index);
                    Image? animalPhoto = getImage(data['photo']);
                    ImageProvider<Object>? imageProvider = animalPhoto.image;
                    return GestureDetector(
                        onTap: () {
                          print("hola soy " + data['name']);
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
