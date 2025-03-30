import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hola_mundo/base_view.dart';

class IsolateView extends StatefulWidget {
  const IsolateView({super.key});

  @override
  State<IsolateView> createState() => _IsolateViewState();
}

class _IsolateViewState extends State<IsolateView> {
  String resultado = "Presiona el botón para ejecutar";
  bool _isProcessing = false; // Indica si la tarea está en ejecución

  //!Función que ejecuta la tarea pesada en un Isolate
  Future<void> isolateTask() async {
    setState(() {
      _isProcessing = true; // Muestra el indicador de carga
    });

    final receivePort = ReceivePort(); // Buzón para recibir datos
    await Isolate.spawn(_simulacionTareaPesada, receivePort.sendPort);

    final sendPort = await receivePort.first as SendPort;
    final response = ReceivePort();

    sendPort.send(["Ejecutando suma", response.sendPort]);
    final result = await response.first as String;

    if (!mounted) return;
    setState(() {
      _isProcessing = false; // Oculta el indicador de carga
      resultado = result;
    });

    // Muestra el resultado en un SnackBar
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result), duration: const Duration(seconds: 3)),
      );
    }
  }

  //! Función que simula una tarea pesada en un Isolate
  static void _simulacionTareaPesada(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final message in port) {
      final data = message[0] as String;
      final puertoReceptor = message[1] as SendPort;

      int counter = 0;
      for (int i = 1; i <= 2000000; i++) {
        counter += i;
      }

      puertoReceptor.send("Suma total: $counter - Mensaje: '$data'");
      port.close();
      Isolate.exit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: "Tarea Pesada - Isolate",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isProcessing
                      ? const CircularProgressIndicator()
                      : Text(
                        resultado,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _isProcessing ? null : isolateTask,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Ejecutar tarea"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
