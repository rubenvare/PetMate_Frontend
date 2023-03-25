import 'package:flutter/material.dart';
import 'main.dart';

class RegistroProtectora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PetMateAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Contacto"),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Número del contacto",
                ),
              ),
              SizedBox(height: 16.0),
              Text("Ubicación"),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Dirección de la protectora",
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Registrarse"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
