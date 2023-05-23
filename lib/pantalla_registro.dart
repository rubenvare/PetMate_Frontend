import 'package:flutter/material.dart';
import 'package:flutter_proyecto/inicio.dart';
import 'package:flutter_proyecto/registro_adoptante.dart';
import 'package:flutter_proyecto/registro_protectora.dart';
import 'package:flutter_proyecto/routing_constants.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class pantallaRegistro extends StatefulWidget {
  @override
  State<pantallaRegistro> createState() => _pantallaRegistroState();
}

class _pantallaRegistroState extends State<pantallaRegistro> {
  final formKey = GlobalKey<FormState>();
  String? dropdownValue;
  String nombreCompleto = "";
  String correoElectronico = "";
  String password = "";
  String confirmPassword = "";
  bool nameError = false;
  bool correoError = false;
  bool dropdownError = false;
  bool passwordError = false;
  bool confirmPasswordError = false;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PetMateAppBar(),
        body: Center(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFFC4A484),
          child: Center(
            child: SingleChildScrollView(
                child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.registro,
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
                                onSaved: (value) => nombreCompleto = value!,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      nameError = true;
                                    });
                                    return AppLocalizations.of(context)!.campoObligatorio;
                                  } else {
                                    setState(() {
                                      nameError = false;
                                    });
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.nombreCompleto,
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: nameError
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
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                onSaved: (value) => correoElectronico = value!,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      correoError = true;
                                    });
                                    return AppLocalizations.of(context)!.campoObligatorio;
                                  } else {
                                    setState(() {
                                      correoError = false;
                                    });
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.correo,
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: correoError
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
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: dropdownError ? Colors.red : Colors.black),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: DropdownButton(
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
                                    items: <String>["Adoptante", "Protectora"]
                                        .map((item) => DropdownMenuItem(
                                              child: Text(item),
                                              value: item,
                                            ))
                                        .toList()),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                onSaved: (value) => confirmPassword = value!,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      passwordError = true;
                                    });
                                    return AppLocalizations.of(context)!.campoObligatorio;
                                  } else {
                                    setState(() {
                                      passwordError = false;
                                    });
                                    return null;
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.contrasena,
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: passwordError
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
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                onSaved: (value) => password = value!,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    setState(() {
                                      confirmPasswordError = true;
                                    });
                                    return AppLocalizations.of(context)!.campoObligatorio;
                                  } else {
                                    setState(() {
                                      confirmPasswordError = false;
                                    });
                                    return null;
                                  }
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.confirmarContra,
                                  labelStyle: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: confirmPasswordError
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
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      if (dropdownValue == "Protectora") {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroProtectora(nombreCompleto,correoElectronico,"S", password)));
                                      } else {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegistroAdoptante(nombreCompleto,correoElectronico,"A", password)));
                                      }
                                      // Falta validar y pasar info a la otra page
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.brown),
                                  child: Text(
                                    AppLocalizations.of(context)!.siguiente,
                                    style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 2.0),
                                  ))
                            ]))
                  ]),
            )),
          ),
        )));
  }
}
