import 'package:flutter/material.dart';
import 'package:flutter_proyecto/singleton_user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_proyecto/inicio.dart';
import 'http_functions.dart';
import 'router.dart';
import 'package:image_picker/image_picker.dart';


class ModifyUser extends StatefulWidget {
  @override
  State<ModifyUser> createState() => ModifyUserState();
}

class ModifyUserState extends State<ModifyUser> {
  final formkey = GlobalKey<FormState>();
  bool nameError = false;
  bool emailError = false;
  bool passwordError = false;
  bool confirmPasswordError = false;
  bool houseError = false;
  bool timeError = false;

  late String name;
  late String email;
  late String password;
  late String confirmPassword;
  late String size;
  late String time;

  bool switchAnimales = false;
  bool switchTerraza = false;
  bool switchJardin = false;
  bool switchAnimalsbefore = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  late XFile _imageFile;

  Future<void> _selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = pickedImage;
      });
    }
  }


  RegExp regExp = RegExp(r'(^[A-z]*$)');
  RegExp regExp2 = RegExp(r'(^[0-9]*$)');
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
                                horizontal: 30.0, vertical: 20.0),
                            child: Column(
                              children: [
                                Text(
                                  'Mi perfil',
                                  style: GoogleFonts.quicksand(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2.0),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 20.0),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: ElevatedButton(onPressed: _selectImageFromGallery, child: Text("Imagen")),
                            ))
                      ]),

                      const SizedBox(height: 20),
                      SizedBox(
                        width: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              initialValue: name,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.brown)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.brown)),
                                  labelText: "Nombre",

                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: nameError
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                cursorColor: Colors.brown,
                                keyboardType: TextInputType.text,
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
                                    return 'Este campo requiere de letras';
                                  } else {
                                    setState(() {
                                      nameError = false;
                                      name = value!;
                                    });
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 20),
                            TextFormField(
                              onSaved: (value) => email = value!,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  setState(() {
                                    emailError = true;
                                  });
                                  return "Rellene el campo de correo";
                                } else {
                                  setState(() {
                                    emailError = false;
                                  });
                                  return null;
                                }
                              },
                              initialValue: email,
                              decoration: InputDecoration(
                                labelText: "Correo electrónico",
                                labelStyle: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: emailError
                                        ? Colors.red
                                        : Colors.black),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.brown)),
                              ),
                              cursorColor: Colors.brown,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              onSaved: (value) => password = value!,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  setState(() {
                                    passwordError = true;
                                  });
                                  return "Rellene el campo de contraseña";
                                } else {
                                  setState(() {
                                    passwordError = false;
                                    password = value!;
                                  });
                                  return null;
                                }
                              },

                              obscureText: obscurePassword,
                              initialValue: password,
                              decoration: InputDecoration(
                                labelText: "Contraseña",
                                labelStyle: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: confirmPasswordError ? Colors.red : Colors.black),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.brown)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  },
                                  icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.black),
                                ),
                              ),
                              cursorColor: Colors.brown,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              onSaved: (value) => confirmPassword = value!,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  setState(() {
                                    confirmPasswordError = true;
                                  });
                                  return "Rellene el campo de confirmar contraseña";
                                } else if (value != password) {
                                  setState(() {
                                    confirmPasswordError = true;
                                  });
                                  return "Las contraseñas no coinciden";
                                } else {
                                  setState(() {
                                    confirmPasswordError = false;
                                  });
                                  return null;
                                }
                              },
                              obscureText: obscureConfirmPassword,
                              initialValue: password,
                              decoration: InputDecoration(
                                labelText: "Confirmar contraseña",
                                labelStyle: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: confirmPasswordError ? Colors.red : Colors.black),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.brown)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscureConfirmPassword = !obscureConfirmPassword;
                                    });
                                  },
                                  icon: Icon(obscureConfirmPassword ? Icons.visibility_off : Icons.visibility, color: Colors.black),
                                ),
                              ),
                              cursorColor: Colors.brown,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                                initialValue: size,
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
                                  } else if (!regExp2.hasMatch(value!)) {
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
                                  value: switchAnimalsbefore,
                                  onChanged: (bool value) {
                                    setState(() {
                                      switchAnimalsbefore = value;
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

                            const SizedBox(height: 40),
                            TextFormField(
                                initialValue: time,
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
                                  } else if (!regExp2.hasMatch(value!)) {
                                    setState(() {
                                      timeError = true;
                                    });
                                    return 'Este campo requiere de números';
                                  } else {
                                    setState(() {
                                      timeError = false;
                                      time = value;
                                    });
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                if (formkey.currentState?.validate() ?? false ) {
                                  var data = {
                                    'user_id': 11,
                                    //UserSession().userId, a modificar cuando se cree usuario
                                    'username': name,
                                    'email': email,
                                    'password': password,
                                    'living_space' : size,
                                    'available_time': time,
                                    'terrace': switchTerraza,
                                    'garden': switchJardin,
                                    'animals_home': switchAnimales,
                                    'pet_before': switchAnimalsbefore
                                  };
                                  var id = await sendAddPetRequest(data);
                                  postImage('animals', _imageFile,
                                      id.values.toString().replaceAll(
                                          RegExp(r"[\(\)]"), ""));
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          icon: const Icon(Icons.pets_rounded),
                                          title: const Text(
                                              'Mascota añadida correctamente'),
                                          titleTextStyle: GoogleFonts.quicksand(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
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
                                };
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.brown),
                              child: Text(
                                'AÑADIR',
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