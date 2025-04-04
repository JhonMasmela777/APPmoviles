import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/CicloVidaScreen.dart';
import 'package:hola_mundo/ParametrosScreen.dart';
import 'package:hola_mundo/PerfilScreen.dart';
import 'package:hola_mundo/dog_breed_detail_view.dart' show DogBreedDetailView;
import 'custom_drawer.dart'; // Asegúrate de importar tu CustomDrawer
import 'timer_view.dart';
import 'isolate_view.dart';
import 'future_view.dart';
import 'dog_breed_list_view.dart'; // Importar la nueva pantalla

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'App Móviles',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}

// Configuración de go_router con rutas nombradas
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/timerView',
      name: 'timerView',
      builder: (context, state) => const TimerView(),
    ),
    GoRoute(
      path: '/isolate',
      name: 'isolate',
      builder: (context, state) => const IsolateView(),
    ),
    GoRoute(
      path: '/dog_breeds',
      builder: (context, state) => const DogBreedListView(),
    ),
    GoRoute(
      path: '/dog_breed_detail/:breed',
      builder: (context, state) {
        final breed = state.pathParameters['breed']!;
        return DogBreedDetailView(breed: breed);
      },
    ),
    GoRoute(
      path: '/future',
      name: 'future',
      builder: (context, state) => const FutureView(),
    ),

    GoRoute(
      path: '/profile', // Corrige la ruta del perfil
      builder: (context, state) => PerfilScreen(),
    ),
    GoRoute(
      path: '/paso_parametros/:dato', // Asegura que espera un dato dinámico
      builder: (context, state) {
        final dato = state.pathParameters['dato'] ?? 'Sin Dato';
        return PantallaParametros(dato: dato);
      },
    ),
    GoRoute(
      path: '/ciclo_vida',
      builder: (context, state) => CicloVidaScreen(),
    ),
  ],
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú Principal')),
      drawer: const CustomDrawer(), // Usa el CustomDrawer
      body: const Center(
        child: Text('Bienvenido a la App', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
