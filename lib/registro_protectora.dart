import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_proyecto/inicio.dart';
import 'http_functions.dart';
import 'router.dart';
import 'package:image_picker/image_picker.dart';


class RegistroProtectora extends StatefulWidget {

  final String name;
  final String email;
  final String type;
  final String password;

  const RegistroProtectora(this.name, this.email, this.type, this.password);
  @override
  State<RegistroProtectora> createState() => _RegistroProtectoraState();
}

class _RegistroProtectoraState extends State<RegistroProtectora> {
  final formkey = GlobalKey<FormState>();
  bool NumberError = false;
  bool DirectionError = false;
  bool imageError = false;

  String phone = '';
  String location = '';
  Image? Logo;
  late XFile _imageFile;
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
                                horizontal: 10.0, vertical: 0.0),
                            child: Column(
                              children: [
                                Text(
                                  'REGISTRO PROTECTORA',
                                  style: GoogleFonts.quicksand(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2.0),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
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
                                  labelText: "Número de contacto",
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: NumberError
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                cursorColor: Colors.brown,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  phone = value!;
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      NumberError = true;
                                    });
                                    return 'Este campo es obligatorio';
                                  } else if (!regExp.hasMatch(value!)) {
                                    setState(() {
                                      NumberError = true;
                                    });
                                    return 'Este campo requiere de números';
                                  } else {
                                    setState(() {
                                      NumberError = false;
                                    });
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 40),
                            TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown)),
                                  labelText: "Dirección de la protectora",
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: DirectionError
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                cursorColor: Colors.black,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      DirectionError = true;
                                    });
                                    return 'Este campo es obligatorio';
                                  } else {
                                    setState(() {
                                      DirectionError = false;
                                    });
                                    location = value!;
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
                                    'phone': phone,
                                    'location': location,
                                  };
                                  var id = await sendRegisterRequest(data);
                                  postImage('users', _imageFile,
                                      id.values.toString().replaceAll(
                                          RegExp(r"[\(\)]"), ""));
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            icon: const Icon(Icons.pets_rounded),
                                            title: const Text(
                                                'Registro como protectora completado'),
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
                                                        Navigator.of(context)
                                                            .pop();
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
