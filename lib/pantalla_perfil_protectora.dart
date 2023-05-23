import 'package:flutter/material.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'package:flutter_proyecto/singleton_user.dart';
import 'package:flutter_proyecto/visualizar_animales.dart';
import 'package:image_picker/image_picker.dart';
import 'inicio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'http_functions.dart';
import 'package:flutter_proyecto/router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PerfilProtectora extends StatefulWidget {

  PerfilProtectora();

  @override
  State<PerfilProtectora> createState() => PerfilProtectoraState();
}

class PerfilProtectoraState extends State<PerfilProtectora> {

  Map<String, dynamic> datos = {};
  Map<String, dynamic> shelter = {};
  late XFile _imageFile;
  Image? shelterLogo;

  final formkey = GlobalKey<FormState>();

  bool nameError = false;
  bool errorMailRegExp = false;
  bool errorMailEmpty = false;
  bool numError = false;
  bool locationError = false;

  late String username;
  late String? password;
  late String description;
  late int phone;
  late String location;

  RegExp regExp = RegExp(r'(^[A-z]*$)');
  RegExp regExpNum = RegExp(r'(^[0-9]*$)');
  RegExp coincideMail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");


  @override
  void initState() {
    super.initState();
    getDatos(UserSession().userId);
    _imageFile = XFile('');
  }

  Future<void> getDatos(int userId) async {
    Map<String, dynamic> shelterResponse =
        await getProfileInfo({'user_id': userId, 'type': 'S'});
    setState(() {
      datos = shelterResponse;

      shelterLogo = getImage(shelterResponse['photo']);
    });
  }

  Future<void> _selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final image = Image.memory(await pickedImage.readAsBytes());
      setState(() {
        _imageFile = pickedImage;
        shelterLogo = image;
      });
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
          child: SingleChildScrollView(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(AppLocalizations.of(context)!.protectora,
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
                                          VisualizarAnimales(UserSession().userId)));
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(165, 35),
                                backgroundColor: Colors.brown),
                            child: Text(AppLocalizations.of(context)!.mascotas,
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
                      child: GestureDetector(
                          onTap: () {
                            _selectImageFromGallery();
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            child: shelterLogo,
                          )))
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
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  labelText: AppLocalizations.of(context)!.nombre,
                                  hintText: datos['username'],
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: nameError
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                cursorColor: Colors.brown,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      username = datos['username'];
                                    });
                                  } else if (!regExp.hasMatch(value!)) {
                                    setState(() {
                                      nameError = true;
                                    });
                                    return AppLocalizations.of(context)!.campoNum;
                                  } else {
                                    setState(() {
                                      username = value;
                                      nameError = false;
                                    });
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.brown)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.brown)),
                                labelText: AppLocalizations.of(context)!.contrasena,
                                labelStyle: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        nameError ? Colors.red : Colors.black),
                              ),
                              cursorColor: Colors.brown,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty == true) {
                                  setState(() {
                                    password = null;
                                  });
                                } else {
                                  setState(() {
                                    password = value;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  labelText: AppLocalizations.of(context)!.telefono,
                                  hintText: '+${datos['phone']}',
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          numError ? Colors.red : Colors.black),
                                ),
                                cursorColor: Colors.brown,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      phone = datos['phone'];
                                    });
                                  } else if (!regExpNum.hasMatch(value!)) {
                                    setState(() {
                                      numError = true;
                                    });
                                    return AppLocalizations.of(context)!.campoNum;
                                  } else {
                                    setState(() {
                                      phone = int.parse(value);
                                      numError = false;
                                    });
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 20),
                            TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  labelText: AppLocalizations.of(context)!.poblacion,
                                  hintText: datos['location'],
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: locationError
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                cursorColor: Colors.brown,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      location = datos['location'];
                                    });
                                  } else if (!regExp.hasMatch(value!)) {
                                    setState(() {
                                      locationError = true;
                                    });
                                    return AppLocalizations.of(context)!.campoLetras;
                                  } else {
                                    setState(() {
                                      location = value;
                                      locationError = false;
                                    });
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 20),
                            TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  labelText: AppLocalizations.of(context)!.descripcion,
                                  hintText: datos['description'],
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                cursorColor: Colors.brown,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      description = datos['description'];
                                    });
                                  } else {
                                    setState(() {
                                      description = value!;
                                    });
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 20),
                            Center(
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(165, 35),
                                        backgroundColor: Colors.brown),
                                    onPressed: () {},
                                    child: Text(AppLocalizations.of(context)!.cerrarSesion,
                                        style: GoogleFonts.quicksand(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 2.0))),
                                const SizedBox(width: 30),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(165, 35),
                                      backgroundColor: Colors.brown),
                                  onPressed: () async {
                                    if (formkey.currentState?.validate() ??
                                        false) {
                                      var data = {
                                        'user_id': UserSession().userId,
                                        'password': password,
                                        'username': username,
                                        'description': description,
                                        'type': 'S',
                                        'phone': phone,
                                        'location': location
                                      };
                                      var id =
                                          await sendUpdateShelterRequest(data);
                                      if (_imageFile.path != '') {
                                        postImage('users', _imageFile,
                                            data['user_id'].toString());
                                        _imageFile = XFile('');
                                      }
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              icon: const Icon(
                                                  Icons.pets_rounded),
                                              title:  Text(
                                                  AppLocalizations.of(context)!.perfilActualizado),
                                              titleTextStyle:
                                                  GoogleFonts.quicksand(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black),
                                              backgroundColor:
                                                  const Color(0xFFC4A484),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                              actions: <Widget>[
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .brown),
                                                        onPressed: () {
                                                          setState(() {
                                                            
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:  Text(
                                                            AppLocalizations.of(context)!.cerrar))
                                                  ],
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  child: Text(AppLocalizations.of(context)!.enviar,
                                      style: GoogleFonts.quicksand(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 2.0)),
                                )
                              ],
                            ))
                          ],
                        )),
                  ),
                )
              ],
            ),
          )),
      bottomNavigationBar: PetMateNavBar(),
    );
  }
}
