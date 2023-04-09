import 'package:flutter/material.dart';

class PantallaTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
          padding: EdgeInsets.all(150.0),
          child: Text("Usuario encontrado"),
      )
    );
  }
}