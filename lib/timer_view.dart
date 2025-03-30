import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hola_mundo/base_view.dart';

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  late Timer _timer; // Temporizador
  int _contador = 0; // Contador de segundos
  bool _activo = false; // Indica si el temporizador está en ejecución

  @override
  void initState() {
    super.initState();
  }

  // Método para iniciar el temporizador
  void _iniciarTemporizador() {
    if (!_activo) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _contador++;
        });
      });
      setState(() {
        _activo = true;
      });
    }
  }

  // Método para pausar el temporizador
  void _pausarTemporizador() {
    if (_activo) {
      _timer.cancel();
      setState(() {
        _activo = false;
      });
    }
  }

  // Método para reiniciar el contador
  void _reiniciarTemporizador() {
    _pausarTemporizador(); // Pausa el temporizador si está activo
    setState(() {
      _contador = 0; // Reinicia el contador a cero
    });
    _iniciarTemporizador(); // Inicia el temporizador de nuevo
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancela el temporizador para evitar fugas de memoria
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Contador con Timer',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Segundos: $_contador',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _iniciarTemporizador,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Iniciar'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _pausarTemporizador,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text('Pausar'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _reiniciarTemporizador,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Reiniciar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
