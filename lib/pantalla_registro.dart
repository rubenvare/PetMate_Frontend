import 'package:flutter/material.dart';
import 'main.dart';
import 'package:google_fonts/google_fonts.dart';

class pantallaRegistro extends StatefulWidget {
  @override
  State<pantallaRegistro> createState() => _pantallaRegistroState();
}


class _pantallaRegistroState extends State<pantallaRegistro> {
  GlobalKey formKey = GlobalKey<FormState>();
  String? dropdownValue;
  String? nombreCompleto;
  String? correoElectronico;
  String? password;
  String? confirmPassword;


  Widget build(BuildContext context){
    return Scaffold(
      appBar: PetMateAppBar(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: formKey,
          child: Column(
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
                    onSaved: (value) => nombreCompleto = value,
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
                    onSaved: (value) => correoElectronico = value,
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
                    dropdownValue = changedValue;
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
                    onSaved: (value) => password = value,
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
                    onSaved: (value) => confirmPassword = value,
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
              ElevatedButton(onPressed: null, child: Text("Siguiente"))
            ]
          ),
        )
      )
    );
  }
}



