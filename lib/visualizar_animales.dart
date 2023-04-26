import 'package:flutter/material.dart';
import 'inicio.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarAnimales extends StatefulWidget {
  @override
  State<VisualizarAnimales> createState() => VisualizarAnimalesState();
}

class VisualizarAnimalesState extends State<VisualizarAnimales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PetMateAppBar(),
      body: Center(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFC4A484),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print("protectora");
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(165, 35),
                            backgroundColor: Colors.brown),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text("PROTECTORA",
                              style: GoogleFonts.quicksand(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.0)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print("mascotas");
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(165, 35),
                            backgroundColor: Colors.brown),
                        child: Text("MASCOTAS",
                            style: GoogleFonts.quicksand(
                                fontSize: 14.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.0)),
                      ),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      'https://www.huellascallejeras.com/wp-content/uploads/2016/05/logo-definitivo-web-blanco.png',
                      fit: BoxFit.contain,
                    ),
                  ))
            ]),
            const SizedBox(height: 20),
            Column(
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    print("entrada ${index + 1}");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: SizedBox(
                      height: 100,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 30,
                            top: 45,
                            child: Text("Perro ${index + 1}",
                                style: GoogleFonts.quicksand(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2.0)),
                          ),
                          Positioned(
                            right: 0,
                            child: SizedBox(
                              height: 100,
                              child: Image.network(
                                  'https://static.fundacion-affinity.org/cdn/farfuture/PVbbIC-0M9y4fPbbCsdvAD8bcjjtbFc0NSP3lRwlWcE/mtime:1643275542/sites/default/files/los-10-sonidos-principales-del-perro.jpg',
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('logout');
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 35),
                      backgroundColor: Colors.brown),
                  child: Text("LOGOUT",
                      style: GoogleFonts.quicksand(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0)),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                    onPressed: () {
                      print('submit');
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 35),
                        backgroundColor: Colors.brown),
                    child: Text('SUBMIT',
                    style: GoogleFonts.quicksand(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2.0
                                )))
              ],
            ),
            const SizedBox(height: 30)
          ],
        )),
      )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            0, // Establece el índice del elemento seleccionado actualmente
        onTap: (index) {
          // Agrega aquí la lógica para manejar el cambio de pantalla según el índice seleccionado
        },
        fixedColor: Colors.black, // Establece el color de fondo de los botones
        selectedFontSize:
            14, // Aumenta el tamaño del texto de los botones seleccionados
        iconSize: 24, // Establece el tamaño de los íconos de los botones
        type: BottomNavigationBarType
            .fixed, // Fuerza la alineación de los botones
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Editar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mensajes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}