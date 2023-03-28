import 'package:flutter/material.dart';
import 'main.dart';
import 'package:google_fonts/google_fonts.dart';

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


  Widget build(BuildContext context){
    return Scaffold(
      appBar: PetMateAppBar(),
      resizeToAvoidBottomInset: false,
      body: Container(
        width:MediaQuery.of(context).size.width,
        color: Color(0xFFC4A484),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: ListView(
                  children: <Widget>[
                    Text(
                      "REGISTRO",
                      style: GoogleFonts.quicksand(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          onSaved: (value) => nombreCompleto = value!,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Rellene el campo de nombre";
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: "Nombre completo",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown)
                            ),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          onSaved: (value) => correoElectronico = value!,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Llene el campo de correo";
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: "Correo electronico",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown)
                            ),
                          ),
                        )),
                    DropdownButton(
                        onChanged: (String? changedValue){
                          dropdownValue = changedValue!;
                          setState(() {
                            dropdownValue;
                          });
                        },
                        value: dropdownValue,
                        items: <String>["Adoptante", "Protectora"].map((item) => DropdownMenuItem(child: Text(item), value: item,)).toList()
                    ),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          onSaved: (value) => password = value!,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Rellene el campo de contraseña";
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: "Contraseña",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown)
                            ),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          onSaved: (value) => confirmPassword = value!,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Rellene el campo de confirmar contraseña";
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: "Confirmar contraseña",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown)
                            ),
                          ),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()){
                            formKey.currentState!.save();
                            // Falta validar y pasar info a la otra page
                          }
                        },
                        child: Text("Siguiente"))
                  ]
              ),
            )
        ) ,
      )
    );
  }
}



