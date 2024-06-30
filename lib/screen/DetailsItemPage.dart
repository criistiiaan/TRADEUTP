import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tradeutp/asset/colors.dart';
import 'package:tradeutp/asset/database_helper.dart';

class DetailsItemPage extends StatefulWidget {
  final int idItem;

  const DetailsItemPage({Key? key, required this.idItem}) : super(key: key);

  @override
  State<DetailsItemPage> createState() => _DetailsItemPageState();
}

class _DetailsItemPageState extends State<DetailsItemPage> {
  
  late Future<List<Map<String, dynamic>>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _loadItem(); // Cargar artículo al iniciar la pantalla
  }

  Future<void> _loadItem() async {
    setState(() {
      _itemsFuture = DatabaseHelper().getItemsId(widget.idItem); // Usar getItemById en lugar de getItemsId
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Extender el cuerpo detrás del bottomNavigationBar
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_circle_left_outlined,
          ),
          iconSize: 40,
          color: colormainColor,
        ),
        title: Text(
          'Detalles',
          style: TextStyle(color: colormainColor, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Acción para manejar favoritos
            },
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: colormainColor),
              ),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: colormainColor, // Color del icono de corazón
                  size: 30, // Tamaño del icono
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No se encontró el artículo'));
          } else {
            List<Map<String, dynamic>> items = snapshot.data!;
            Map<String, dynamic> item = items[0];
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item['image'].isNotEmpty)
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: colorbackgroundColor,

                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Image.file(
                        File(item['image']),
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  else
                    Placeholder(), // Placeholder en caso de no haber imagen
                  SizedBox(height: 16.0),
                  Text(
                    item['name'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    item['description'],
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '\$${item['price']}',
                    style: TextStyle(fontSize: 16, color: colorfaintColor),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
