import 'package:flutter/material.dart';
import 'package:flutter_proyecto/inicio.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
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
                return GestureDetector(
                  onTap: () => _mostrarPopUp(context, elemento),
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
                          children: const [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://picsum.photos/id/64/200/300'),
                            ),
                            SizedBox(width: 8.0),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://picsum.photos/id/237/200/300'),
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
              onPressed: () { null; },
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


void _mostrarPopUp(BuildContext context, Map<String,dynamic> elemento) {
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
                  backgroundImage: NetworkImage(
                      'https://picsum.photos/id/64/200/300'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    elemento['username'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.info_outline),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://picsum.photos/id/237/200/300'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    elemento['name'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Aceptar'),
          ),
        ],
      );
    },
  );
}

