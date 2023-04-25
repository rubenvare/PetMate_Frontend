import 'package:flutter/material.dart';
import 'package:flutter_proyecto/inicio.dart';

class PantallaProtectoraItems extends StatefulWidget {

  final String nombre;
  final String descripcion;

  const PantallaProtectoraItems(this.nombre, this.descripcion, {super.key});

  @override
  State<PantallaProtectoraItems> createState() => PantallaProtectoraItemsState();
}

class PantallaProtectoraItemsState extends State<PantallaProtectoraItems> {
  
  final List<PantallaProtectoraItems> elementos = [
    const PantallaProtectoraItems("Elemento 1", "Descripción del elemento 1"),
    const PantallaProtectoraItems("Elemento 2", "Descripción del elemento 2"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PetMateAppBar(),
      body:Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: elementos.length,
              itemBuilder: (context, index) {
                final elemento = elementos[index];
                return GestureDetector(
                  onTap: () => _mostrarPopUp(context, elemento),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          elemento.nombre,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                        Row(
                          children: const [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage("assets/imagen1.png"),
                            ),
                            SizedBox(width: 8.0),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage("assets/imagen2.png"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton (
              onPressed: () { null; },
              child: Text("+"),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Establece el índice del elemento seleccionado actualmente
        onTap: (index) {
          // Agrega aquí la lógica para manejar el cambio de pantalla según el índice seleccionado
        },
        fixedColor: Colors.black, // Establece el color de fondo de los botones
        selectedFontSize: 14, // Aumenta el tamaño del texto de los botones seleccionados
        iconSize: 24, // Establece el tamaño de los íconos de los botones
        type: BottomNavigationBarType.fixed, // Fuerza la alineación de los botones
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

void _mostrarPopUp(BuildContext context, PantallaProtectoraItems elemento) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(elemento.nombre),
        content: Text(elemento.descripcion),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cerrar"),
          ),
        ],
      );
    },
  );
}

