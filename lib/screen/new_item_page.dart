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
 
  Future<void> _addItem(BuildContext context) async {
    if (_imagePath != null && nameController.text.isNotEmpty && descriptionController.text.isNotEmpty && _selectedType != null && priceController.text.isNotEmpty) {
      String name = nameController.text;
      String description = descriptionController.text;
      String type = _selectedType!;
      double price = double.tryParse(priceController.text) ?? 0.0;

      String transaction = _selectedTransaction ?? '';

      Map<String, dynamic> item = {
        'name': name,
        'description': description,
        'type': type,
        'price': price,
        'transaction_type': transaction,
        'fromUsers': userAccount[2],
        'image': _imagePath!,
      };

      await DatabaseHelper().insertItem(item);

      Fluttertoast.showToast(
        msg: 'Se cargó exitosamente la publicación',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: 'Por favor, complete todos los campos y agregue una imagen.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double gapBetweenTextfield = 11;
    double widthImagePicker = (width *0.93);
    print(widthImagePicker);

    return Scaffold(
      extendBody: true, // Extender el cuerpo detrás del bottomNavigationBar

      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0, // Aquí se añade la sombra
        shadowColor: Colors.grey.withOpacity(0.5), // Color de la sombra
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: colormainColor,
              fontSize: 14,
            ),
          ),
        ),
        leadingWidth: 82,
        title: Text('Nueva Publicación', style: TextStyle(color: colormainColor, fontWeight: FontWeight.bold),),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _addItem(context);
               
                        
                },
            child: Text(
              'Publicar',
              style: TextStyle(
                color: colormainColor,
                fontSize: 14,
                fontWeight: FontWeight.bold
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
        child:Row(
          children: [
          Container(


              decoration: BoxDecoration(
                shape: BoxShape.circle,
                
                border: Border.all(
                  color: colormainColor, // Color del borde
                  width: 1.0, // Ancho del borde
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3), // Espaciado entre el ícono y el borde
                child: Icon(Icons.person, color: colormainColor,size: 42,),
              ),
            ),
          SizedBox(width: 13),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,

            children: [
            Text(userAccount[0].toString()??  "Nombre Apellido"),
            Text(userAccount[1].toString() ??  "Nombre de Facultad", style: TextStyle(fontSize: 13, color:colorfaintColor),overflow: TextOverflow.ellipsis,
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
          
          width: widthImagePicker,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:Border.all(
              color: Colors.grey,

            )
          ),
        child:Center(
          child:Padding(
            padding:_image != null ?EdgeInsets.all(5) :EdgeInsets.all(25),
            child:_image != null
                ? Image.file(_image!)
                : Column(children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14159), // Rotación de 180 grados en radianes
            
              child: Icon(Icons.add_a_photo_outlined)),
              Text("Agregar fotos", )
              
            
          ],),)
          
          )
          ),
          ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child:Text("Elige primero la foto principal de la publicación"),),
Padding(
        padding: const EdgeInsets.all(16.0),
        
        child:Column(
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
            SizedBox(height: gapBetweenTextfield,),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border:OutlineInputBorder( // Define un borde redondeado
                borderSide: BorderSide(color: Colors.grey), // Color del borde
                borderRadius: BorderRadius.circular(10), // Radio de la esquina del borde
              ),
              labelText: 'Descripción'),
            ),
            SizedBox(height: gapBetweenTextfield,),
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
            SizedBox(height: gapBetweenTextfield,),
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
            ), SizedBox(height: gapBetweenTextfield,),
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
