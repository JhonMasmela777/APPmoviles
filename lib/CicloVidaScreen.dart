import 'package:flutter/material.dart';

class CicloVidaScreen extends StatefulWidget {
  @override
  _CicloVidaScreenState createState() => _CicloVidaScreenState();
}

class _CicloVidaScreenState extends State<CicloVidaScreen> {
  String texto = "Estado inicial";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ciclo de Vida')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(texto, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  texto = "Estado actualizado";
                  print("setState: El estado ha cambiado");
                });
              },
              child: const Text("Actualizar Estado"),
            ),
          ],
        ),
      ),
    );
  }
}
