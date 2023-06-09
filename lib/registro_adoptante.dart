import 'package:flutter/material.dart';
import 'package:flutter_proyecto/routing_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'http_functions.dart';
import 'inicio.dart';
import 'router.dart';
import 'package:image_picker/image_picker.dart';


class RegistroAdoptante extends StatefulWidget {

  final String name;
  final String email;
  final String type;
  final String password;

  const RegistroAdoptante(this.name, this.email, this.type, this.password);

  @override
  State<RegistroAdoptante> createState() => _RegistroAdoptanteState();
}

class _RegistroAdoptanteState extends State<RegistroAdoptante> {
  final formkey = GlobalKey<FormState>();
  late String size;
  late String time;
  Image? Logo;
  late XFile _imageFile;

  bool houseError = false;
  bool timeError = false;
  bool switchAnimales = false;
  bool switchTerraza = false;
  bool switchJardin = false;
  bool switchAnimalsBefore = false;
  bool imageError = false;
  RegExp regExp = RegExp(r'(^[0-9]*$)');

  Future<void> _selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final image = Image.memory(await pickedImage.readAsBytes());
      setState(() {
        _imageFile = pickedImage;
        Logo = image;
      });
    }
  }
  String? _imageValidator() {
    if (Logo == null) {
      return 'Por favor, seleccione una imagen';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PetMateAppBar(),
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xFFC4A484),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: Column(
                              children: [
                                Text(
                                  'REGISTRO ADOPTANTE',
                                  style: GoogleFonts.quicksand(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2.0),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              _selectImageFromGallery();
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: Logo != null
                                  ? null
                                  : BoxDecoration(
                                border: Border.all(
                                  color: imageError ? Colors.red : Colors.black,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Logo != null
                                    ? Logo
                                    : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Añadir imagen',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (imageError)
                                      Text(
                                        'La imagen es obligatoria',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.red,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )

                      ]),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  labelText: "Tamaño de la casa en m2*",
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: houseError
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                cursorColor: Colors.brown,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      houseError = true;
                                    });
                                    return 'Este campo es obligatorio';
                                  } else if (!regExp.hasMatch(value!)) {
                                    setState(() {
                                      houseError = true;
                                    });
                                    return 'Este campo requiere de números';
                                  } else {
                                    setState(() {
                                      houseError = false;
                                    });
                                    size = value;
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 40),
                            Column(children: <Widget>[
                              Row(children: <Widget>[
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
                                Text('Animales en casa',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ))
                              ]),
                              const SizedBox(height: 5),
                              Row(children: <Widget>[
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
                                Text('Terraza en casa',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ))
                              ]),
                              const SizedBox(height: 5),
                              Row(children: <Widget>[
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
                              ])
                            ]),
                            const SizedBox(height: 5),
                            Row(children: <Widget>[
                              Switch(
                                value: switchAnimalsBefore,
                                onChanged: (bool value) {
                                  setState(() {
                                    switchAnimalsBefore = value;
                                  });
                                },
                                activeTrackColor: Colors.brown,
                                activeColor: Colors.white,
                              ),
                              Text('Animales anteriormente',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ))
                            ]),
                            const SizedBox(height: 40),
                            TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  labelText: "Tiempo disponible en horas/día*",
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: timeError
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      timeError = true;
                                    });
                                    return 'Este campo es obligatorio';
                                  } else if (!regExp.hasMatch(value!)) {
                                    setState(() {
                                      timeError = true;
                                    });
                                    return 'Este campo requiere de números';
                                  } else {
                                    setState(() {
                                      timeError = false;
                                    });
                                    time = value;
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                if (formkey.currentState?.validate() ?? false ) {
                                  if (_imageValidator() != null) {
                                    setState(() {
                                      imageError = true;
                                    });
                                    return;
                                  }
                                  var data = {
                                    'type': widget.type ,
                                    'email': widget.email,
                                    'password': widget.password,
                                    'username': widget.name,
                                    'living_space': size ,
                                    'available_time': time,
                                    'terrace': switchTerraza,
                                    'garden': switchJardin,
                                    'animals_home': switchAnimales ,
                                    'animals_before': switchAnimalsBefore ,
                                  };
                                  var id = await sendRegisterRequest(data);
                                  postImage('users', _imageFile,id["user_id"].toString());
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          icon: const Icon(Icons.pets_rounded),
                                          title: const Text(
                                              'Registro como adoptante completado'),
                                          titleTextStyle: GoogleFonts.quicksand(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                          backgroundColor:
                                          const Color(0xFFC4A484),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          actions: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                        backgroundColor:
                                                        Colors.brown),
                                                    onPressed: () {
                                                      Navigator.pushNamed(context, InicioSesionRoute);
                                                    },
                                                    child: const Text('Cerrar'))
                                              ],
                                            )
                                          ],
                                        );
                                      });

                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.brown),
                              child: Text(
                                'REGISTRARSE',
                                style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
