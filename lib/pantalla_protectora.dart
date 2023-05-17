import 'package:flutter/material.dart';
import 'package:flutter_proyecto/inicio.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'package:flutter_proyecto/pantalla_detalles_protectora.dart';
import 'package:flutter_proyecto/routing_constants.dart';
import 'package:flutter_proyecto/singleton_user.dart';
import 'package:google_fonts/google_fonts.dart';

import 'http_functions.dart';

class PantallaProtectoraItems extends StatefulWidget {

  final String nombreAdoptante;
  final String nombreAnimal;

  const PantallaProtectoraItems(this.nombreAdoptante, this.nombreAnimal, {super.key});

  @override
  State<PantallaProtectoraItems> createState() => PantallaProtectoraItemsState();
}

class PantallaProtectoraItemsState extends State<PantallaProtectoraItems> {
  
  Map<String, dynamic> animalsLiked = {};

  @override
  void initState(){
    super.initState();
    dynamic data = {
      "user_id":UserSession().userId
    };

    initAsync(data);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PetMateAppBar(),
      body:Column(
        children: [
          Text("Posibles adopciones",
          style: GoogleFonts.quicksand(
            fontSize: 30.0,
            color: Colors.black,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
          )),
          Expanded(
            child: ListView.builder(
              itemCount: animalsLiked.length,
              itemBuilder: (context, index) {
                String key = animalsLiked.keys.elementAt(index);
                Map<String, dynamic> elemento = animalsLiked[key];
                Image photoUser = getImage(elemento["user_photo"]);
                Image photoAnimal = getImage(elemento["animal_photo"]);
                return GestureDetector(
                  onTap: () => _mostrarPopUp(context, elemento, photoUser, photoAnimal),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children:[
                            Text(
                              elemento['username'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                              ),
                            ),
                            Text(
                                elemento['name'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                )),
                          ]
                        ),
                        Row(
                          children:  [
                            CircleAvatar(
                              backgroundImage: photoUser.image,
                            ),
                            SizedBox(width: 8.0),
                          CircleAvatar(
                            backgroundImage: photoAnimal.image,
                          ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton (
              onPressed: () { Navigator.pushNamed(context, PantallaAddAnimalRoute); },
              child: Text("+"),
            ),
          ),
        ],
      ),
      bottomNavigationBar: PetMateNavBar(),
    );
  }

  Future<void> initAsync(data) async {
    Map<String, dynamic> response = await showLikesReceived(data);

    setState(() {
      response.forEach((key, value) {
        animalsLiked[key] = value;
      });
    });
  }
}


void _mostrarPopUp(BuildContext context, Map<String,dynamic> elemento, Image photoUser, Image photoAnimal) {
  Map<String, dynamic> data = {};
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Información adoptante y animal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: photoUser.image),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    elemento['username'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreenShelter(elemento['user_id'], "A")));
                  },
                  icon: Icon(Icons.info_outline),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: photoAnimal.image),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    elemento['name'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreenShelter(elemento['animal_id'], "B")));
                  },
                  icon: Icon(Icons.info_outline),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              '¿Deseas que el adoptante conozca a la mascota?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      data = {
                        "user_id": elemento["user_id"],
                        "animal_id": elemento["animal_id"],
                        "action": 1,
                      };
                      if(await resolveLikeReceived(data)){
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.check),
                  ),
                  IconButton(
                    onPressed: () async {
                      data = {
                        "user_id": elemento["user_id"],
                        "animal_id": elemento["animal_id"],
                        "action": 2,
                      };
                      if(await resolveLikeReceived(data)){
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}

