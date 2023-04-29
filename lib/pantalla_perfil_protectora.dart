import 'package:flutter/material.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'package:flutter_proyecto/visualizar_animales.dart';
import 'inicio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'http_functions.dart';
import 'package:flutter_proyecto/router.dart';

class PerfilProtectora extends StatefulWidget {
  int userId;
  PerfilProtectora(this.userId);

  @override
  State<PerfilProtectora> createState() => PerfilProtectoraState(userId);
}

class PerfilProtectoraState extends State<PerfilProtectora> {
  int userId;

  Map<String, dynamic> datos = {};
  Map<String, dynamic> shelter = {};

  Image? shelterLogo;

  final formkey = GlobalKey<FormState>();

  bool nameError = false;
  bool errorMailRegExp = false;
  bool errorMailEmpty = false;
  bool numError = false;

  RegExp regExp = RegExp(r'(^[A-z]*$)');
  RegExp coincideMail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  PerfilProtectoraState(this.userId);

  @override
  void initState() {
    super.initState();
    getDatos(userId);
  }

  Future<void> getDatos(int userId) async {
    Map<String, dynamic> shelterResponse =
        await getProfileInfo({'user_id': userId, 'type': 'S'});
    setState(() {
      datos = shelterResponse;
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
                        onPressed: () {
                          print(datos);
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VisualizarAnimales(userId)));
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
            Center(
              child: SingleChildScrollView(
                child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: datos['username'],
                              labelStyle: GoogleFonts.quicksand(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: nameError ? Colors.red : Colors.black),
                            ),
                            cursorColor: Colors.brown,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                setState(() {
                                  nameError = true;
                                });
                                return 'Este campo es obligatorio';
                              } else if (!regExp.hasMatch(value!)) {
                                setState(() {
                                  nameError = true;
                                });
                                return 'Este campo requiere de números';
                              } else {
                                setState(() {
                                  nameError = false;
                                });
                                return null;
                              }
                            }),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown)),
                            labelText: datos['email'],
                            labelStyle: GoogleFonts.quicksand(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: nameError ? Colors.red : Colors.black),
                          ),
                          cursorColor: Colors.brown,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty == true) {
                              setState(() {
                                errorMailEmpty = true;
                              });
                              return 'Este campo es obligatorio';
                            } else {
                              if (!coincideMail.hasMatch(value)) {
                                setState(() {
                                  errorMailRegExp = true;
                                });
                                return 'por favor, sigue el formato user@domain.com';
                              } else {
                                return null;
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: datos['phone'].toString(),
                              labelStyle: GoogleFonts.quicksand(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: nameError ? Colors.red : Colors.black),
                            ),
                            cursorColor: Colors.brown,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                setState(() {
                                  numError = true;
                                });
                                return 'Este campo es obligatorio';
                              } else if (!regExp.hasMatch(value!)) {
                                setState(() {
                                  numError = true;
                                });
                                return 'Este campo requiere de números';
                              } else {
                                setState(() {
                                  numError = false;
                                });
                                return null;
                              }
                            }),
                            const SizedBox(height: 20),
                            TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: datos['location'],
                              labelStyle: GoogleFonts.quicksand(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: nameError ? Colors.red : Colors.black),
                            ),
                            cursorColor: Colors.brown,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                setState(() {
                                  nameError = true;
                                });
                                return 'Este campo es obligatorio';
                              } else if (!regExp.hasMatch(value!)) {
                                setState(() {
                                  nameError = true;
                                });
                                return 'Este campo requiere de números';
                              } else {
                                setState(() {
                                  nameError = false;
                                });
                                return null;
                              }
                            }),
                            const SizedBox(height: 20),
                            TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)),
                              labelText: "Nombre",
                              labelStyle: GoogleFonts.quicksand(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: nameError ? Colors.red : Colors.black),
                            ),
                            cursorColor: Colors.brown,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                setState(() {
                                  nameError = true;
                                });
                                return 'Este campo es obligatorio';
                              } else if (!regExp.hasMatch(value!)) {
                                setState(() {
                                  nameError = true;
                                });
                                return 'Este campo requiere de números';
                              } else {
                                setState(() {
                                  nameError = false;
                                });
                                return null;
                              }
                            }),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: PetMateNavBar(),
    );
  }
}
