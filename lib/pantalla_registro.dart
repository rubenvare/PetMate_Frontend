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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nombre completo",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown)
                  ),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Correo electronico",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown)
                  ),
                ),
              ),
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
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown)
                  ),
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirmar contraseña",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown)
                  ),
                ),
              )
            ]
          ),
        )
      )
    );
  }
}



