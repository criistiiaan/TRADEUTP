import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:tradeutp/asset/colors.dart';
import 'package:tradeutp/asset/database_helper.dart';
import 'package:tradeutp/asset/userAccount.dart';

class NewItemPage extends StatefulWidget {
  const NewItemPage({super.key});

  @override
  State<NewItemPage> createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String? _selectedType;
  String? _selectedTransaction;
  File? _image;
  String? _imagePath;

  List<String> opcionesFilter = [
    'Ropa',
    'Comida',
    'Útiles',
    'Tecnología',
  ];

  List<String> opcionesTransaction = [
    'Venta',
    'Alquiler',
    'Donación',
    'Intercambio'
  ];
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final permanentImage = await _saveImagePermanently(File(pickedFile.path));
      setState(() {
        _image = permanentImage;
        _imagePath = permanentImage.path;
      });
    }
  }

  Future<File> _saveImagePermanently(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(image.path);
    final imagePath = '${directory.path}/$name';
    return image.copy(imagePath);
  }

  Future<void> _addItem() async {
    if (_imagePath != null) {
      String name = nameController.text;
      String description = descriptionController.text;
      String type = _selectedType ?? ''; // Use selected type here
      double price = double.tryParse(priceController.text) ?? 0.0;
      String transaction =  _selectedTransaction ?? ''; // Use selected type here

      Map<String, dynamic> item = {
        'name': name,
        'description': description,
        'type': type,
        'price': price,
        'transaction': transaction,
        'image': _imagePath!,
      };

      await DatabaseHelper().insertItem(item);
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double gap_between_TextField = 11;
    double width_image_picker = (width *0.9);

    return Scaffold(
      extendBody: true, // Extender el cuerpo detrás del bottomNavigationBar

      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        leadingWidth: 85,
        title: Text('Nueva Publicación'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _addItem();
            Fluttertoast.showToast(
                  msg: 'Se cargó exitosamente la publicación',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );              
                },
            child: Text(
              'Publicar',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView (child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
        Padding(
          
        padding: EdgeInsets.only(left: 20, top: 13,bottom: 13, right:20),
        child:Row(children: [
          Icon(Icons.account_circle_rounded, size: 48,),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,

            children: [
            Text(userAccount[0] != Null ? userAccount[0]: "Nombre Apellido"),
            Text(userAccount[1] != Null ? userAccount[1]: "Nombre de Facultad", style: TextStyle(fontSize: 13, color:colorfaintColor),overflow: TextOverflow.ellipsis,
                        maxLines: 2,softWrap: true,)
          ],)
        ],),),
        GestureDetector (
          onTap: (){
            _pickImage();
            },
          
        child:Center( 
          child:Container(
          height: 100,
          width: width_image_picker,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:Border.all(
              color: Colors.grey,

            )
          ),
        child:Center(
          child:Padding(
            padding: EdgeInsets.all(25),
            child:Column(children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14159), // Rotación de 180 grados en radianes
            
              child: Icon(Icons.add_a_photo_outlined)),
              Text("Agregar fotos", )
              
            
          ],),)
          
          )),),),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child:Text("Elige Primero la foto principal de la publicación"),),
Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(

              controller: nameController,
              decoration: InputDecoration(
                border:OutlineInputBorder( // Define un borde redondeado
                borderSide: BorderSide(color: Colors.grey), // Color del borde
                borderRadius: BorderRadius.circular(10), // Radio de la esquina del borde
              ),
                labelText: 'Título'),
            ),
            SizedBox(height: gap_between_TextField,),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border:OutlineInputBorder( // Define un borde redondeado
                borderSide: BorderSide(color: Colors.grey), // Color del borde
                borderRadius: BorderRadius.circular(10), // Radio de la esquina del borde
              ),
              labelText: 'Descripción'),
            ),
            SizedBox(height: gap_between_TextField,),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                border:OutlineInputBorder( // Define un borde redondeado
                borderSide: BorderSide(color: Colors.grey), // Color del borde
                borderRadius: BorderRadius.circular(10), // Radio de la esquina del borde
              ),
              labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: gap_between_TextField,),
            DropdownButtonFormField<String>(
              value: _selectedType,
              items: opcionesFilter.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue;
                });
              },
              decoration: InputDecoration(
                
                labelText: 'Categoría',
                fillColor: colorfaintColor,
                border:OutlineInputBorder( // Define un borde redondeado
                borderSide: BorderSide(color: Colors.grey), // Color del borde
                borderRadius: BorderRadius.circular(10), // Radio de la esquina del borde
              ),              ),
            ),
           SizedBox(height: gap_between_TextField,),
            DropdownButtonFormField<String>(
              value: _selectedTransaction,
              items: opcionesTransaction.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTransaction = newValue;
                });
              },
              decoration: InputDecoration(
                
                labelText: 'Tipo de transacción',
                fillColor: colorfaintColor,
                border:OutlineInputBorder( // Define un borde redondeado
                borderSide: BorderSide(color: Colors.grey), // Color del borde
                borderRadius: BorderRadius.circular(10), // Radio de la esquina del borde
              ),              ),
            ),
          ],
        ),
      ),
      ],),),
      
      
      
    );
  }
}
