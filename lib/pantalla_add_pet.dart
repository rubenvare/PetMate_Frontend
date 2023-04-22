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
  bool dropdownError = false;
  String? dropdownValue;
  late String name;
  late String breed;
  late String tone;
  late String size;
  late String age;
  late String description;

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
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'AÑADIR MASCOTA',
                              style: GoogleFonts.quicksand(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.0),
                            ),
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
                                    });
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(

                                  border: Border.all(
                                      color: dropdownError ? Colors.red : Colors.black),
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
                                    dropdownValue = changedValue!;
                                    setState(() {
                                      dropdownValue;
                                    });
                                  },
                                  isExpanded: true,
                                  style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  value: dropdownValue,
                                  items: <String>["Perro", "Gato", "Pajaro"]
                                      .map((item) => DropdownMenuItem(
                                    child: Text(item),
                                    value: item,

                                  ))
                                      .toList(),
                                validator: (value) => value == null ? 'Este campo es requerido' : null,)
                            ),
                            const SizedBox(height: 20),
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(

                                    border: Border.all(
                                        color: dropdownError ? Colors.red : Colors.black),
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
                                    dropdownValue = changedValue!;
                                    setState(() {
                                      dropdownValue;
                                    });
                                  },
                                  isExpanded: true,
                                  style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  value: dropdownValue,
                                  items: <String>["Claro", "Neutro", "Oscuro"]
                                      .map((item) => DropdownMenuItem(
                                    child: Text(item),
                                    value: item,

                                  ))
                                      .toList(),
                                  validator: (value) => value == null ? 'Este campo es requerido' : null,)
                            ),
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

                                  }
                                }),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                if (formkey.currentState?.validate() ?? false ) {
                                  var data = {

                                  };
                                  if(await sendRegisterRequest(data)) {
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
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            icon: const Icon(Icons.pets_rounded),
                                            title: const Text(
                                                'Error en el registro'),
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