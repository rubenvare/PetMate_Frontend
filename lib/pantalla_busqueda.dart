import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_proyecto/pantalla_detalles.dart';
import 'package:flutter_proyecto/pantalla_filtro.dart';
import 'package:flutter_proyecto/singleton_user.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'inicio.dart';
import 'http_functions.dart';

class DogSearchScreen extends StatefulWidget {
  @override
  _DogSearchScreenState createState() => _DogSearchScreenState();
}

class _DogSearchScreenState extends State<DogSearchScreen> {
  bool aplicar_filtros = false;
  bool dataLoaded = false;
  bool saveForLater = false;
  bool emptyAnimalList = false;
  Image? currentAnimalPhoto;
  Map<String, dynamic> currentAnimal = {};
  double containerSize = 50.0;
  Map<String, dynamic> currentFilters = {};


  Widget PetMateLoading() {
    return Container(
      color: Color(0xFFC4A484),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.pets,
                size: 72,
                color: Colors.brown,
              ),
              SizedBox(height: 16),
              Text(
                'Loading...',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.brown,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    var firstPet = {
      'user_id': 1,
      'animal_id': null,
      'action': null,
      'filters': {
        'species': null,
        'size': null,
        'age': null,
        'color': null
      }
    };
    initAsync(firstPet);
  }

  Future<void> initAsync(pet) async {
    // first petition to the server

    Map<String, dynamic> response = await getNextPet(pet);
    setState(() {
      currentAnimal['user_id'] = UserSession().userId;
      // para pruebas: currentAnimal['user_id'] = 1;
      currentAnimal['age'] = response['age'];
      currentAnimal['animal_id'] = response['animal_id'];
      currentAnimal['name'] = response['name'];
      currentAnimal['photo'] = response['photo'];
      currentAnimal['shelter_id'] = response['shelter_id'];
      currentFilters['color'] = null;
      currentFilters['size'] = null;
      currentFilters['age'] = null;
      currentFilters['species'] = null;
      currentAnimalPhoto = getImage(response['photo']);
      dataLoaded = true;
    });
  }

  Future<void> _handleAction(nextPetData) async {
    var response = await getNextPet(nextPetData);
    containerSize = 70.0;
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        if (response.isEmpty) {
          emptyAnimalList = true;
        } else {
          emptyAnimalList = false;
          containerSize = 50.0;
          currentAnimal['age'] = response['age'];
          currentAnimal['animal_id'] = response['animal_id'];
          currentAnimal['name'] = response['name'];
          currentAnimal['photo'] = response['photo'];
          currentAnimal['shelter_id'] = response['shelter_id'];
          currentAnimalPhoto = getImage(response['photo']);
          dataLoaded = true;
        }
      });
    });
  }

  void _handleDetails(BuildContext context, int pet_id) {
    // Navigate to the details screen for the current pet
    DetailScreen detailScreen = DetailScreen(pet_id);
    // Navegar a la pantalla de detalles del animal
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detailScreen,
      ),
    );
  }

  void _handleFilters(BuildContext context) {
    PantallaFiltro filterScreen = PantallaFiltro(currentFilters);
    // Navegar a la pantalla de filtro de caracteristicas
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => filterScreen,
      ),
    ).then((resultado) {
      setState(() {
        currentFilters = resultado[0];
        aplicar_filtros = resultado[1];

        // si resultado[1] es true significa que se ha pulsado el boton de aplicar filtros
        // si es false significa que simplemente le ha dado atras sin hacer cambios
        if (aplicar_filtros) {
          var body = {
            'user_id': currentAnimal['user_id'],
            'animal_id': null,
            'action': null,
            'filters': currentFilters
          };
          _handleAction(body);
        }
      });
      });
  }

  void _showMessage(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.alfaSlabOne(fontSize: 20.0)),
        duration: Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (emptyAnimalList){
      return AlertDialog(
        icon: const Icon(Icons.pets_rounded),
        title: const Text(
            'No existen animales con los filtros actuales.'),
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
                    setState(() {
                      // esto soluciona el error de que los filtros no cambiaban nunca cuando no encontrabas coincidencias
                      currentFilters['age'] = null;
                      currentFilters['size'] = null;
                      currentFilters['species'] = null;
                      currentFilters['color'] = null;
                      _handleFilters(context);
                    });
                  },
                  child: const Text('CAMBIAR FILTROS'))
            ],
          )
        ],
      );
    } else {
      return Scaffold(
          appBar: PetMateAppBar(),
          body: dataLoaded == false ? PetMateLoading() :
          Container(
            color: Color(0xFFC4A484),
            child: Swiper(
              itemCount: 1,
              loop: false,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.5,
                            child: Center(child: currentAnimalPhoto),
                          ),
                        ),
                        Positioned(
                          top: 10.0,
                          left: 15.0,
                          child: IconButton(
                            icon: Icon(Icons.edit, size: 45,),
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                _handleFilters(context);
                              });
                            },
                          ),
                        ),
                        Positioned(
                          top: 10.0,
                          right: 15.0,
                          child: IconButton(
                            icon: saveForLater == false ? Icon(
                              Icons.bookmark_border_outlined, size: 50,) : Icon(
                                Icons.bookmark, size: 50),
                            color: Colors.black,
                            onPressed: () {
                              // TODO: implementar la logica para el 10 (guardar animal en la bd para luego)
                              setState(() {
                                saveForLater = !saveForLater;
                              });
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.white.withOpacity(0.7),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentAnimal['name'] ?? "",
                                    style:
                                    GoogleFonts.zillaSlab(
                                        fontSize: 35.0, color: Colors.black),
                                  ),
                                  const SizedBox(height: 45.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        width: containerSize,
                                        height: containerSize,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                        child: IconButton(
                                          onPressed: () async {
                                            _showMessage(context,
                                                'You disliked ${currentAnimal['name']} :/',
                                                Colors.blue);
                                            var body = {
                                              'user_id': currentAnimal['user_id'],
                                              'animal_id': currentAnimal['animal_id'],
                                              'action': 2,
                                              'filters': currentFilters
                                            };
                                            setState(() {
                                              dataLoaded = false;
                                            });
                                            _handleAction(body);
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                            size: 32.0,
                                          ),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration: const Duration(
                                            milliseconds: 200),
                                        width: containerSize,
                                        height: containerSize,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[300],
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            _handleDetails(context,
                                                currentAnimal['animal_id']);
                                          },
                                          icon: const Icon(
                                            Icons.info,
                                            size: 32.0,
                                          ),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration: const Duration(
                                            milliseconds: 200),
                                        width: containerSize,
                                        height: containerSize,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        child: IconButton(
                                          onPressed: () async {
                                            _showMessage(context,
                                                'You liked ${currentAnimal['name']} <3',
                                                Colors.red);
                                            var body = {
                                              'user_id': currentAnimal['user_id'],
                                              'animal_id': currentAnimal['animal_id'],
                                              'action': 1,
                                              'filters': currentFilters
                                            };
                                            setState(() {
                                              dataLoaded = false;
                                            });
                                            _handleAction(body);
                                          },
                                          icon: const Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                            size: 32.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 45.0)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          bottomNavigationBar: const PetMateNavBar()
      );
    }
  }
}

class PetMateNavBar extends StatelessWidget {
  const PetMateNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          icon: Icon(Icons.message),
          label: 'Mensajes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}



