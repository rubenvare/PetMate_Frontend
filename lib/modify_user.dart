import 'package:flutter/material.dart';
import 'package:flutter_proyecto/saved_pets.dart';
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
  Map<String, dynamic> user = {};
  bool nameError = false;
  bool descriptionError = false;
  bool passwordError = false;
  bool confirmPasswordError = false;
  bool houseError = false;
  bool timeError = false;

  String password = "";
  late String confirmPassword;
  late XFile _imageFile;
  Image? userPicture;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool dataLoaded = false;

  Future<void> _selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final image = Image.memory(await pickedImage.readAsBytes());
      setState(() {
        _imageFile = pickedImage;
        userPicture = image;
      });
    }
  }

  Future<void> initAsync() async {
    Map<String, dynamic> user_info =
        await getProfileInfo({'user_id': UserSession().userId, 'type': "A"});
    setState(() {
      user['name'] = user_info['username'];
      user['photo'] = user_info['photo'];
      user['description'] = user_info['description'];
      user['size'] = user_info['living_space'];
      user['time'] = user_info['available_time'];
      user['terrace'] = user_info['terrace'];
      user['garden'] = user_info['garden'];
      user['animals_home'] = user_info['animals_home'];
      user['animals_before'] = user_info['animals_before'];
      userPicture = getImage(user['photo']);
      dataLoaded = true;
    });
  }

  RegExp regExp = RegExp(r'(^[A-z]*$)');
  RegExp regExp2 = RegExp(r'(^[0-9]*$)');
  @override
  void initState() {
    super.initState();
    initAsync();
  }

  Widget build(BuildContext context) {
    return !dataLoaded
        ? Center(child: CircularProgressIndicator())
        : Builder(
            builder: (context) => Scaffold(
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
                                          horizontal: 7, vertical: 20.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          _selectImageFromGallery();
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: userPicture?.image != null
                                              ? null
                                              : BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                          child: Center(
                                            child: userPicture?.image != null
                                                ? userPicture
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Añadir imagen',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextFormField(
                                            decoration: InputDecoration(
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.brown)),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.brown)),
                                              labelText: 'Nombre',
                                              hintText: user['name'],
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
                                              if (!regExp.hasMatch(value!)) {
                                                setState(() {
                                                  nameError = true;
                                                });
                                                return 'Este campo requiere de letras';
                                              } else {
                                                setState(() {
                                                  nameError = false;
                                                  user['name'] = value!;
                                                });
                                                return null;
                                              }
                                            }),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          validator: (value) {
                                            if (value?.isEmpty ?? false) {
                                              setState(() {
                                                passwordError = false;
                                                password = value!;
                                              });
                                              return null;
                                            }
                                          },
                                          obscureText: obscurePassword,
                                          decoration: InputDecoration(
                                            labelText: "Contraseña",
                                            labelStyle: GoogleFonts.quicksand(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: confirmPasswordError
                                                    ? Colors.red
                                                    : Colors.black),
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.brown),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.brown)),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  obscurePassword =
                                                      !obscurePassword;
                                                });
                                              },
                                              icon: Icon(
                                                  obscurePassword
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          cursorColor: Colors.brown,
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          onSaved: (value) =>
                                              confirmPassword = value!,
                                          validator: (value) {
                                            if (value != password) {
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
                                                color: confirmPasswordError
                                                    ? Colors.red
                                                    : Colors.black),
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.brown),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.brown)),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  obscureConfirmPassword =
                                                      !obscureConfirmPassword;
                                                });
                                              },
                                              icon: Icon(
                                                  obscureConfirmPassword
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          cursorColor: Colors.brown,
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                            //initialValue: "${user['size']}",
                                            decoration: InputDecoration(
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.brown)),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.brown)),
                                              labelText:
                                                  "Tamaño de la casa en m2*",
                                              hintText: "${user['size']}",
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
                                              if (!regExp2.hasMatch(value!)) {
                                                setState(() {
                                                  houseError = true;
                                                });
                                                return 'Este campo requiere de números';
                                              } else {
                                                setState(() {
                                                  houseError = false;
                                                });
                                                user['size'] = value;
                                                return null;
                                              }
                                            }),
                                        const SizedBox(height: 40),
                                        Column(children: <Widget>[
                                          Row(children: <Widget>[
                                            Switch(
                                              value: user['animals_home'],
                                              onChanged: (bool value) {
                                                setState(() {
                                                  user['animals_home'] = value;
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
                                              value: user['terrace'],
                                              onChanged: (bool value) {
                                                setState(() {
                                                  user['terrace'] = value;
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
                                              value: user['animals_before'],
                                              onChanged: (bool value) {
                                                setState(() {
                                                  user['animals_before'] =
                                                      value;
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
                                              value: user['garden'],
                                              onChanged: (bool value) {
                                                setState(() {
                                                  user['garden'] = value;
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
                                            decoration: InputDecoration(
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.brown)),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.brown)),
                                              labelText:
                                                  "Tiempo disponible en horas/día*",
                                              hintText: "${user['time']}",
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
                                              if (!regExp2.hasMatch(value!)) {
                                                setState(() {
                                                  timeError = true;
                                                });
                                                return 'Este campo requiere de números';
                                              } else {
                                                setState(() {
                                                  timeError = false;
                                                  user['time'] = value;
                                                });
                                                return null;
                                              }
                                            }),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          onSaved: (value) =>
                                              user['description'] = value!,
                                          validator: (value) {
                                            setState(() {
                                              descriptionError = false;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Descripción",
                                            hintText: user['description'],
                                            labelStyle: GoogleFonts.quicksand(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: descriptionError
                                                    ? Colors.red
                                                    : Colors.black),
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.brown),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.brown)),
                                          ),
                                          cursorColor: Colors.brown,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                var data = {
                                                  'user_id':
                                                      UserSession().userId,
                                                };
                                                var correcto =
                                                    await deleteHistory(data);
                                                if (correcto == true) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          icon: const Icon(Icons
                                                              .pets_rounded),
                                                          title: const Text(
                                                              'LIKES Y DISLIKE BORRADOS CORRECTAMENTE'),
                                                          titleTextStyle:
                                                              GoogleFonts.quicksand(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .black),
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFFC4A484),
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20))),
                                                          actions: <Widget>[
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .brown),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: const Text(
                                                                        'Cerrar'))
                                                              ],
                                                            )
                                                          ],
                                                        );
                                                      });
                                                }
                                                ;
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.brown),
                                              child: Text(
                                                'RESETEAR LIKES',
                                                style: GoogleFonts.quicksand(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 2.0),
                                              ),
                                            ),
                                            const SizedBox(width: 50),
                                            ElevatedButton(
                                              onPressed: () async {
                                                if (formkey.currentState
                                                        ?.validate() ??
                                                    false) {
                                                  var data = {
                                                    'user_id':
                                                        UserSession().userId,
                                                    'type': "A",
                                                    'username': user['name'],
                                                    'description':
                                                        user['description'],
                                                    'password': password,
                                                    'living_space':
                                                        user['size'],
                                                    'available_time':
                                                        user['time'],
                                                    'terrace': user['terrace'],
                                                    'garden': user['garden'],
                                                    'animals_home':
                                                        user['animals_home'],
                                                    'pet_before':
                                                        user['pet_before']
                                                  };
                                                  var id =
                                                      await sendModifyUserRequest(
                                                          data);
                                                  if (userPicture != null) {
                                                    postImage(
                                                        'animals',
                                                        _imageFile,
                                                        id.values
                                                            .toString()
                                                            .replaceAll(
                                                                RegExp(
                                                                    r"[\(\)]"),
                                                                ""));
                                                  }
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          icon: const Icon(Icons
                                                              .pets_rounded),
                                                          title: const Text(
                                                              'Usuario modificado correctamente'),
                                                          titleTextStyle:
                                                              GoogleFonts.quicksand(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .black),
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFFC4A484),
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20))),
                                                          actions: <Widget>[
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .brown),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: const Text(
                                                                        'Cerrar'))
                                                              ],
                                                            )
                                                          ],
                                                        );
                                                      });
                                                }
                                                ;
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.brown),
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
                                        SizedBox(height: 15),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                InicioSesion start =
                                                    InicioSesion();
                                                Navigator.pop(context);
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => start,
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'CERRAR SESIÓN',
                                                style: GoogleFonts.quicksand(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 2.0),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                            ),
                                            SizedBox(width: 30),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SavedPets(
                                                                UserSession()
                                                                    .userId)));
                                              },
                                              child: Text(
                                                'GUARDADOS',
                                                style: GoogleFonts.quicksand(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 2.0),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.brown),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Center(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    var data = {
                                                      'user_id':
                                                          UserSession().userId
                                                    };
                                                    var boolean =
                                                        await deleteProfile(
                                                            data);
                                                    if (boolean) {
                                                      InicioSesion start =
                                                          InicioSesion();
                                                      Navigator.pop(context);
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              start,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                          minimumSize:
                                                              const Size(
                                                                  165, 35),
                                                          backgroundColor:
                                                              Colors.brown),
                                                  child: Text("DARSE DE BAJA",
                                                      style: GoogleFonts
                                                          .quicksand(
                                                              fontSize: 14.0,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              letterSpacing:
                                                                  2.0))),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                ));
  }
}
