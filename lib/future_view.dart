import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hola_mundo/base_view.dart';

class FutureView extends StatefulWidget {
  const FutureView({super.key});

  @override
  State<FutureView> createState() => _FutureViewState();
}

class _FutureViewState extends State<FutureView> {
  List<String> _nombres =
      []; // Lista para almacenar los nombres de los estudiantes

  @override
  void initState() {
    super.initState();
    obtenerDatos(); // Llama a la función para cargar los datos cuando el widget se inicializa
  }

  // Función que simula una carga de datos asincrónica con Future.delayed
  Future<List<String>> cargarNombres() async {
    await Future.delayed(
      const Duration(seconds: 5),
    ); // Simula un retraso de 5 segundos
    return [
      'Juan',
      'Pedro',
      'Luis',
      'Ana',
      'Maria',
      'Jose',
      'Carlos',
      'Sofia',
      'Laura',
      'Fernando',
      'Ricardo',
      'Diana',
      'Elena',
      'Miguel',
      'Rosa',
      'Luz',
      'Carmen',
      'Pablo',
      'Jorge',
      'Roberto',
    ];
  }

  // Función que obtiene los datos y actualiza el estado del widget
  Future<void> obtenerDatos() async {
    final datos = await cargarNombres(); // Obtiene la lista de nombres
    if (!mounted)
      return; // Verifica que el widget aún esté montado antes de actualizar el estado
    setState(() {
      _nombres = datos; // Asigna los nombres a la lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Lista de Estudiantes', // Título de la pantalla
      body:
          _nombres.isEmpty
              ? const Center(
                child: CircularProgressIndicator(),
              ) // Muestra un indicador de carga si la lista está vacía
              : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                  itemCount: _nombres.length, // Número de elementos en la lista
                  separatorBuilder:
                      (context, index) =>
                          const Divider(), // Agrega una línea divisoria entre elementos
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Bordes redondeados
                      ),
                      elevation: 3, // Sombra para el efecto de elevación
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Colors.teal, // Color de fondo del avatar
                          child: Text(
                            _nombres[index][0], // Primera letra del nombre
                            style: const TextStyle(
                              color: Colors.white,
                            ), // Texto en color blanco
                          ),
                        ),
                        title: Text(
                          _nombres[index], // Nombre del estudiante
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: const Text(
                          'Estudiante registrado',
                        ), // Subtítulo fijo
                        trailing: const Icon(
                          Icons.school,
                          color: Colors.teal,
                        ), // Ícono decorativo
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
