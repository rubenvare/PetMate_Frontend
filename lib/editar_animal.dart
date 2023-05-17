import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'package:flutter_proyecto/routing_constants.dart';
import 'package:google_fonts/google_fonts.dart';

import 'http_functions.dart';
import 'inicio.dart';

class PerfilAnimal extends StatefulWidget{

  int idAnimal;
  ImageProvider<Object> imageProvider;

  PerfilAnimal(this.idAnimal, this.imageProvider);

  @override
  State<StatefulWidget> createState() => PerfilAnimalState();

}

class PerfilAnimalState extends State<PerfilAnimal>{

  final formkey = GlobalKey<FormState>();
  Map<String, dynamic> datos = {};

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
  late int tone;
  late int size;
  late int age;
  late String description;

  @override
  void initState(){
    super.initState();
    getDatosAnimal(widget.idAnimal);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PetMateAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFC4A484),
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Image(image: widget.imageProvider),
                  ),
                  Form(
                    key: formkey,
                    child:Column(
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
                              labelText: "Nombre",
                              hintText: datos['name'],
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
                                  name = datos['name'];
                                });
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
                            hintText: datos['birth'],
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
                              age = int.parse(datos['birth']);
                            }
                            if (yearOfBirth! < 1900 || yearOfBirth > DateTime.now().year) {
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
                              hintText: datos['description'],
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
                                  description = datos['description'];
                                });
                              } else {
                                setState(() {
                                  DescriptionError = false;
                                  description = value!;
                                });
                                return null;
                              }
                            }),
                        const SizedBox(height: 20),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(165, 35),
                                  backgroundColor: Colors.brown),
                              onPressed: () async {
                                if(formkey.currentState?.validate() ?? false){

                                  switch(dropdownValue2) {
                                    case 'Claro':
                                      tone = 0;
                                      break;
                                    case 'Neutro':
                                      tone = 1;
                                      break;
                                    case 'Oscuro':
                                      tone = 2;
                                      break;
                                    default:
                                      tone = 0;
                                      break;
                                  }

                                  switch(dropdownValue3) {
                                    case 'Pequeño':
                                      size = 0;
                                      break;
                                    case 'Mediano':
                                      size = 1;
                                      break;
                                    case 'Grande':
                                      size = 2;
                                      break;
                                    default:
                                      size = 0;
                                      break;
                                  }

                                  var data = {
                                    'animal_id':widget.idAnimal,
                                    'name': name,
                                    'species': breed,
                                    'birth': age,
                                    'color': tone,
                                    'size': size,
                                    'description': description
                                  };
                                  if(await sendUpdateAnimalRequest(data)){
                                    Navigator.pushNamed(context, PantallaProtectoraRoute);
                                  } else {
                                    print("esta mal");
                                  }
                                }
                              },
                              child: Text(
                                'ENVIAR',
                                  style: GoogleFonts.quicksand(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2.0),
                              ),
                            ),
                            Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(165, 35),
                                  backgroundColor: Colors.brown),
                              onPressed: () async {
                                var data = {
                                  'animal_id': widget.idAnimal,
                                  'status': 2,
                                };
                                if(await retirePet(data)){
                                  Navigator.pushNamed(context, PantallaProtectoraRoute);
                                } else {
                                  print("esta mal");
                                }
                              },
                              child: Text(
                                  "ELIMINAR ANIMAL",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2.0)
                              ),
                            ),
                          ]
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ),

        ),
        bottomNavigationBar:PetMateNavBar(),
      );
  }

  Future<void> getDatosAnimal(int idAnimal) async {
    Map<String, dynamic> response = await getPetDetails({'animal_id':idAnimal});
    setState(
        (){
          datos = response;
        }
    );
  }

}