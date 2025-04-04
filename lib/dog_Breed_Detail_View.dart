import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DogBreedDetailView extends StatefulWidget {
  final String breed;
  const DogBreedDetailView({super.key, required this.breed});

  @override
  State<DogBreedDetailView> createState() => _DogBreedDetailViewState();
}

class _DogBreedDetailViewState extends State<DogBreedDetailView> {
  late Future<List<String>> _futureImages;

  // Descripciones fijas por raza (puedes agregar más)
  final Map<String, String> breedDescriptions = {
    'affenpinscher': 'Pequeño, valiente y juguetón. De origen alemán.',
    'beagle': 'Raza amigable y curiosa, ideal para familias.',
    'chihuahua': 'Muy pequeño, pero valiente. Protector de su dueño.',
    'labrador': 'Muy sociable, obediente y excelente con niños.',
    'pug': 'Cariñoso, juguetón y excelente para espacios pequeños.',
    'bulldog': 'Raza calmada y leal. Requiere poco ejercicio.',
  };

  @override
  void initState() {
    super.initState();
    _futureImages = _fetchImages(widget.breed);
  }

  Future<List<String>> _fetchImages(String breed) async {
    String formattedBreed = breed.toLowerCase().replaceAll(' ', '-');
    String url = 'https://dog.ceo/api/breed/$formattedBreed/images/random/10';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message'] is List) {
          return List<String>.from(data['message']);
        }
      }
      throw Exception('Error al cargar imágenes.');
    } catch (e) {
      print('Error al obtener imágenes: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final description =
        breedDescriptions[widget.breed.toLowerCase()] ??
        'No hay descripción disponible.';

    return Scaffold(
      appBar: AppBar(title: Text('Fotos de ${widget.breed}')),
      body: FutureBuilder<List<String>>(
        future: _futureImages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No se pudieron cargar imágenes para esta raza.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            final images = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Descripción:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(description, style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          images[index],
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.broken_image,
                              size: 100,
                              color: Colors.grey,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
