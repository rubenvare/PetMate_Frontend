import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'inicio.dart';

class DogSearchScreen extends StatefulWidget {
  @override
  _DogSearchScreenState createState() => _DogSearchScreenState();
}

class DogApi {
  static Future<List<String>> getImages() async {
    final response =
    await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random/20'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final images = List<String>.from(data['message'] as List<dynamic>);
      return images;
    } else {
      throw Exception('Failed to load images');
    }
  }
}

class _DogSearchScreenState extends State<DogSearchScreen> {
  final List<String> _images = [];
  final List<String> _names = List.generate(20, (index) => 'PERRO $index');
  int _currentIndex = 0;
  SwiperController _swiperController = SwiperController();

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final images = await DogApi.getImages();

    setState(() {
      _images.clear();
      _images.addAll(images);
      _currentIndex = 0;
    });
  }

  void _handleAccept() {
    // this method should be overrided with specific actions when backend is ready
    // the following method erases the card when accepted
    setState(() {
      _images.removeAt(_currentIndex);
      _currentIndex = _currentIndex < _images.length ? _currentIndex : _images.length - 1;
      _currentIndex = _currentIndex < _names.length ? _currentIndex : _names.length - 1;
    });
    _swiperController.next();
  }

  void _handleReject() {
    // this method should be overrided with specific actions when backend is ready
    // the following method erases the card when declined
    setState(() {
      _images.removeAt(_currentIndex);
      _currentIndex = _currentIndex < _images.length ? _currentIndex : _images.length - 1;
      _currentIndex = _currentIndex < _names.length ? _currentIndex : _names.length - 1;
    });
    _swiperController.next();
  }


  void _handleDetails() {
    // Navigate to the details screen for the current image
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PetMateAppBar(),
      body: _images.isEmpty ? const Center(child: CircularProgressIndicator()) :
      Container(
        color: Color(0xFFC4A484),
        child: Swiper(
          controller: _swiperController,
          itemCount: _images.length,
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
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Image.network(
                          _images[index],
                          fit: BoxFit.cover,
                        ),
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
                                _names[index],
                                style:
                                GoogleFonts.zillaSlab(fontSize: 35.0, color: Colors.black),
                              ),
                              const SizedBox(height: 45.0),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(

                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    child: IconButton(
                                      onPressed: _handleReject,
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                        size: 32.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[300],
                                    ),
                                    child: IconButton(
                                      onPressed: _handleDetails,
                                      icon: const Icon(
                                        Icons.info,
                                        size: 32.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                    child: IconButton(
                                      onPressed: _handleAccept,
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

