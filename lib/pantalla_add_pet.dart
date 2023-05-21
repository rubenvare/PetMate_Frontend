import 'package:flutter/material.dart';
import 'package:flutter_proyecto/singleton_user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_proyecto/inicio.dart';
import 'http_functions.dart';
import 'router.dart';
import 'package:image_picker/image_picker.dart';


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
  bool imageError = false;

  late String name;
  late String breed;
  late int tone;
  late int size;
  late String selectedMonth, selectedYear;
  late String birth;
  late String description;
  Image? shelterLogo;
  late XFile _imageFile;

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
  String? _imageValidator() {
    if (shelterLogo == null) {
      return 'Por favor, seleccione una imagen';
    }
    return null;
  }

  RegExp regExp = RegExp(r'(^[A-z, ]*$)');
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
                                horizontal: 20.0, vertical: 20.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              _selectImageFromGallery();
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: shelterLogo != null
                                  ? null
                                  : BoxDecoration(
                                border: Border.all(
                                  color: imageError ? Colors.red : Colors.black,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: shelterLogo != null
                                    ? shelterLogo
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
                                          switch(value) {
                                            case 'Claro':
                                              tone = 0;
                                              break;
                                            case 'Neutro':
                                              tone = 1;
                                              break;
                                            case 'Oscuro':
                                              tone = 2;
                                              break;
                                          }

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
                                          switch(value) {
                                            case 'Pequeño':
                                              size = 0;
                                              break;
                                            case 'Mediano':
                                              size = 1;
                                              break;
                                            case 'Grande':
                                              size = 2;
                                              break;
                                          }
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
                                labelText: "Mes de nacimiento",
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
                                final int? yearOfMonth = int.tryParse(value ?? '');
                                if (yearOfMonth == null) {
                                  return 'Este campo es obligatorio';
                                }
                                if (yearOfMonth < 1 || yearOfMonth > 12) {
                                  return 'Por favor, ingresa un mes válido';
                                }
                                selectedMonth = value!;
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
                                selectedYear = value!;
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
                                  if (_imageValidator() != null) {
                                    setState(() {
                                      imageError = true;
                                    });
                                    return;
                                  }
                                  birth = "${selectedMonth}-${selectedYear}";
                                  var data = {
                                    'user_id': UserSession().userId,
                                    'name': name,
                                    'species': breed,
                                    'birth': birth,
                                    'color': tone,
                                    'size': size,
                                    'description': description
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