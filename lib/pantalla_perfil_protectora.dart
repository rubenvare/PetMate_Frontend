import 'package:flutter/material.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'inicio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'http_functions.dart';

class PerfilProtectora extends StatefulWidget {
  int userId;
  String type;
  PerfilProtectora(this.userId, this.type);

  @override
  State<PerfilProtectora> createState() => PerfilProtectoraState(userId, type);
}

class PerfilProtectoraState extends State<PerfilProtectora> {
  int userId;
  String type;
  Map<String, dynamic> datos = {};

  PerfilProtectoraState(this.userId, this.type);

  @override
  void initState() {
    super.initState();
    getShelterInfo(userId, type);
  }

  Future<void> getShelterInfo(int userId, String type) async {
    Map<String, dynamic> response = await getProfileInfo({'user_id': userId, 'type': type});
    setState(() {
      datos = response;
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
          Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          
                        },
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
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      'https://www.huellascallejeras.com/wp-content/uploads/2016/05/logo-definitivo-web-blanco.png',
                      fit: BoxFit.contain,
                    ),
                  ))
            ]
          ),
        ],
      ),
      ),
      bottomNavigationBar: PetMateNavBar(),
    );
  }
}