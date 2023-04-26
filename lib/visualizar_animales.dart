import 'package:flutter/material.dart';
import 'inicio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'http_functions.dart';

class VisualizarAnimales extends StatefulWidget {
  int userId;
  
  VisualizarAnimales(this.userId);
  @override
  State<VisualizarAnimales> createState() => VisualizarAnimalesState(userId);
}

class VisualizarAnimalesState extends State<VisualizarAnimales> {
  int userId;
  Map<String, dynamic> datos = {};

  VisualizarAnimalesState(this.userId);

  @override
    void initState() {
      super.initState();
      getDatos(userId);
    }
  
  Future<void> getDatos(int userId) async {
    try {
      var response = await showPets({'user_id': userId});
      datos = response;
    } catch (error){
      print('Error al obtener los datos: $error');
    }
  }
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
                      horizontal: 30.0, vertical: 10.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print(datos);
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
              children: datos.entries.map((entry) {
                final animalData = entry.value;
                return GestureDetector(
                  onTap: () {
                    print("animal ${entry.key}");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black
                      )
                    ),
                    child: SizedBox(
                      height: 100,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 30,
                            top: 45,
                            child: Text("${animalData['pet_name']}",
                            style: GoogleFonts.quicksand(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0))
                          ),
                          Positioned(
                            right: 0,
                            child: SizedBox(
                              height: 100,
                              child: Image.network('${animalData['photo_pet']}'),
                            ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
            ),
            const SizedBox(height: 30),
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