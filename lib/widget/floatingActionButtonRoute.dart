// ignore: file_names

import 'package:flutter/material.dart';
import 'package:tradeutp/asset/colors.dart';
import 'package:tradeutp/screen/new_item_page.dart';

class FloatingActionButtonRoute extends StatefulWidget {
  const FloatingActionButtonRoute({super.key});

  @override
  State<FloatingActionButtonRoute> createState() => _FloatingActionButtonRouteState();
}

class _FloatingActionButtonRouteState extends State<FloatingActionButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight, // Alineación en la esquina inferior derecha
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0, right: 16.0), // Ajusta los valores para la posición deseada
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewItemPage()),
              );
            },
            backgroundColor: colormainColor,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
