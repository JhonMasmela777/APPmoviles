import 'package:flutter/material.dart';

class PantallaParametros extends StatelessWidget {
  final String dato;

  const PantallaParametros({super.key, required this.dato});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paso de Parámetros')),
      body: Center(
        child: Text(
          'Dato recibido: $dato',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
