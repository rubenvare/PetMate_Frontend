import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_proyecto/inicio.dart';
import 'http_functions.dart';
import 'router.dart';

class AddPet extends StatefulWidget {
  @override
  State<AddPet> createState() => AddPetState();
}

class AddPetState extends State<AddPet> {
  final formkey = GlobalKey<FormState>();
  bool NumberError = false;
  bool DirectionError = false;
  bool DescriptionError = false;
  bool dropdownError1 = false;
  String? dropdownValue1;
  bool dropdownError2 = false;
  String? dropdownValue2;
  bool dropdownError3 = false;
  String? dropdownValue3;
  late String name;
  late String breed;
  late String tone;
  late String size;
  late int age;
  late String description;
  String photo = "";

  RegExp regExp = RegExp(r'(^[A-z]*$)');
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
                                  'AÑADIR MASCOTA',
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
                              child: Image.network(
                                'https://static.eldiario.es/clip/4b05608f-487e-4d02-aa28-01dc1dc30135_16-9-discover-aspect-ratio_default_0.jpg',
                                fit: BoxFit.contain,
                              ),
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
                                      color: NumberError
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                cursorColor: Colors.brown,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      NumberError = true;
                                    });
                                    return 'Este campo es obligatorio';
                                  } else if (!regExp.hasMatch(value!)) {
                                    setState(() {
                                      NumberError = true;
                                    });
                                    return 'Este campo requiere de letras';
                                  } else {
                                    setState(() {
                                      NumberError = false;
                                      name = value!;
                                    });
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 20),
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(

                                    border: Border.all(
                                        color: dropdownError1 ? Colors.red : Colors.black),
                                    borderRadius: BorderRadius.circular(5)
                                ),

                                child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Especie',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    dropdownColor: Colors.brown,
                                    onChanged: (String? changedValue) {
                                      dropdownValue1 = changedValue!;
                                      setState(() {
                                        dropdownValue1;
                                      });
                                    },
                                    isExpanded: true,
                                    style: GoogleFonts.quicksand(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    value: dropdownValue1,
                                    items: <String>["Perro", "Gato", "Pajaro"]
                                        .map((item) => DropdownMenuItem(
                                      child: Text(item),
                                      value: item,

                                    ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        setState(() {
                                          dropdownError1 = true;
                                        });
                                        return 'Este campo es obligatorio';
                                      }
                                      else {
                                        setState(() {
                                          dropdownError1 = false;
                                          breed = value!;
                                        });
                                        return null;
                                      }}
                                )
                            ),
                            const SizedBox(height: 20),
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(

                                    border: Border.all(
                                        color: dropdownError2 ? Colors.red : Colors.black),
                                    borderRadius: BorderRadius.circular(5)
                                ),

                                child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Tonalidad',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    dropdownColor: Colors.brown,
                                    onChanged: (String? changedValue) {
                                      dropdownValue2 = changedValue!;
                                      setState(() {
                                        dropdownValue2;
                                      });
                                    },
                                    isExpanded: true,
                                    style: GoogleFonts.quicksand(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    value: dropdownValue2,
                                    items: <String>["Claro", "Neutro", "Oscuro"]
                                        .map((item) => DropdownMenuItem(
                                      child: Text(item),
                                      value: item,

                                    ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        setState(() {
                                          dropdownError2 = true;
                                        });
                                        return 'Este campo es obligatorio';
                                      }
                                      else {
                                        setState(() {
                                          dropdownError2 = false;
                                          tone = value!;
                                        });
                                        return null;
                                      }})
                            ),
                            const SizedBox(height: 20),
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(

                                    border: Border.all(
                                        color: dropdownError3 ? Colors.red : Colors.black),
                                    borderRadius: BorderRadius.circular(5)
                                ),

                                child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Tamaño',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    dropdownColor: Colors.brown,
                                    onChanged: (String? changedValue) {
                                      dropdownValue3 = changedValue!;
                                      setState(() {
                                        dropdownValue3;
                                      });
                                    },
                                    isExpanded: true,
                                    style: GoogleFonts.quicksand(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    value: dropdownValue3,
                                    items: <String>["Pequeño", "Mediano", "Grande"]
                                        .map((item) => DropdownMenuItem(
                                      child: Text(item),
                                      value: item,

                                    ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        setState(() {
                                          dropdownError3 = true;
                                        });
                                        return 'Este campo es obligatorio';
                                      }
                                      else {
                                        setState(() {
                                          dropdownError3 = false;
                                          size = value!;
                                        });
                                        return null;
                                      }})
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
                                labelText: "Año de nacimiento",
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
                                final int? yearOfBirth = int.tryParse(value ?? '');
                                if (yearOfBirth == null) {
                                  return 'Este campo es requerido';
                                }
                                if (yearOfBirth < 1900 || yearOfBirth > DateTime.now().year) {
                                  return 'Por favor, ingresa un año válido';
                                }
                                age = yearOfBirth;
                                return null;
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
                                  labelText: "Descripción",
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: NumberError
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                cursorColor: Colors.brown,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      DescriptionError = true;
                                    });
                                    return 'Este campo es obligatorio';
                                  } else if (!regExp.hasMatch(value!)) {
                                    setState(() {
                                      DescriptionError = true;
                                    });
                                    return 'Este campo requiere de letras';
                                  } else {
                                    setState(() {
                                      DescriptionError = false;
                                      description = value;
                                    });
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                if (formkey.currentState?.validate() ?? false ) {
                                  var data = {
                                    'user_id': 8,
                                    'name': name,
                                    'photo': photo,
                                    'species': breed,
                                    'age': age,
                                    'color': tone,
                                    'size': size,
                                    'description' : description
                                  };
                                  if(await sendAddPetRequest(data)) {
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
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            icon: const Icon(Icons.pets_rounded),
                                            title: const Text(
                                                'Error en añadir la mascota'),
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
                                } else {
                                  return;
                                }
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