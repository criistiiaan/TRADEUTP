import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.0,
        backgroundColor: const Color.fromARGB(255, 248, 255, 245),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 235, 253, 228)),
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            children: [
              Positioned(
                left: 25.0,
                top: 35.0,
                child: const Text(
                  'Favoritos',
                  style: TextStyle(
                    color: Color.fromARGB(255, 34, 72, 33),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              Positioned(
                right: 25.0,
                top: 30.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromARGB(255, 34, 72, 33),
                      width: 2.0,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 34, 72, 33),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Buscar',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildItem(context, 'Libro de Cálculo', 'https://i5.walmartimages.com.mx/mg/gm/3pp/asr/fa85b12c-5e4b-45ef-8dec-f469c4af7b92.5ab96015b275f02dfbda5952827a4b52.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF'),
                  buildItem(context, 'Calculadora', 'https://i5.walmartimages.com.mx/mg/gm/3pp/asr/fa85b12c-5e4b-45ef-8dec-f469c4af7b92.5ab96015b275f02dfbda5952827a4b52.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF'),
                  buildItem(context, 'Termo de agua', 'https://i5.walmartimages.com.mx/mg/gm/3pp/asr/fa85b12c-5e4b-45ef-8dec-f469c4af7b92.5ab96015b275f02dfbda5952827a4b52.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF'),
                  buildItem(context, 'Artículo', 'https://i5.walmartimages.com.mx/mg/gm/3pp/asr/fa85b12c-5e4b-45ef-8dec-f469c4af7b92.5ab96015b275f02dfbda5952827a4b52.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemDetailPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 150, // Aumentar la altura del contenedor blanco
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2, // Hacer más angosto el contenedor verde
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 233, 233, 233),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 34, 72, 33),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
  'Lorem ipsum dolor sit amet, consectetur adipisc...',
  style: TextStyle(color: Color.fromARGB(255, 192, 192, 192), fontSize: 12.0), // Tamaño más pequeño
),
Row(
  children: [
    const Text(
      'Venta ',
      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Texto "Venta" color negro
    ),
    const Text(
      '\$0.00',
      style: TextStyle(color: Color.fromARGB(255, 0, 128, 0), fontSize: 18.0), // Precio más grande y color verde
    ),
  ],
),
const Text(
  'Vendedor',
  style: TextStyle(color: Color.fromARGB(255, 34, 72, 33)), // Corregido el valor ARGB
),
                ],
              ),
            ),
            const SizedBox(width: 40, height: 20,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imagePath,
                width: 80, // Aumentar el tamaño de la imagen
                height: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Artículo'),
      ),
      body: const Center(
        child: Text('Contenido de la página de detalle del artículo'),
      ),
    );
  }
}

