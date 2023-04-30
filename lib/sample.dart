import 'package:flutter/material.dart';
import 'package:flutter_proyecto/http_functions.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late XFile _imageFile;
  late int id = 1;

  Future<void> _selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi página principal'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _selectImageFromGallery,
              child: Text("Imagen"),
            ),
            ElevatedButton(
              onPressed: () {
                          //1     //2          //3
                postImage('users', _imageFile, id.toString()); //1 --> debe ser users(shelter y usuarios) o animals, sino da error
                                                                      //2 --> es la imagen que se pasa
                                                                      //3 --> el nombre de la imagen, será el id, se pasará y habrá que ponerlo
            }, 
            child: Text("Post"))
          ],
      )),
    );
  }
}
