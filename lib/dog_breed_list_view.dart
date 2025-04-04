import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dog_breed_detail_view.dart';

class DogBreedListView extends StatefulWidget {
  const DogBreedListView({super.key});

  @override
  State<DogBreedListView> createState() => _DogBreedListViewState();
}

class _DogBreedListViewState extends State<DogBreedListView> {
  late Future<List<String>> _futureBreeds;

  @override
  void initState() {
    super.initState();
    _futureBreeds = _fetchBreeds();
  }

  Future<List<String>> _fetchBreeds() async {
    try {
      final response = await http.get(
        Uri.parse('https://dog.ceo/api/breeds/list/all'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message'] is Map<String, dynamic>) {
          return List<String>.from(data['message'].keys);
        }
      }
      throw Exception('Error al cargar las razas');
    } catch (e) {
      print('Error obteniendo razas: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Razas de Perros')),
      backgroundColor: Colors.blueGrey[50], // Fondo suave

      body: FutureBuilder<List<String>>(
        future: _futureBreeds,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Error al cargar las razas o no hay razas disponibles',
              ),
            );
          }

          final breeds = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: breeds.length,
            itemBuilder: (context, index) {
              final breed = breeds[index];
              final color =
                  index % 2 == 0
                      ? Colors.blueAccent.withOpacity(0.1)
                      : Colors.greenAccent.withOpacity(0.1);

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DogBreedDetailView(breed: breed),
                    ),
                  );
                },
                child: Card(
                  color: color,
                  elevation: 3, // Sombra
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    title: Text(
                      breed.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    trailing: const Icon(Icons.pets, color: Colors.blue),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
