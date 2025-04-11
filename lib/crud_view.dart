import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'usuarios_view.dart';

class CrudView extends StatefulWidget {
  const CrudView({super.key});

  @override
  State<CrudView> createState() => _CrudViewState();
}

class _CrudViewState extends State<CrudView> {
  List<String> usuarios = [];

  @override
  void initState() {
    super.initState();
    _cargarUsuarios();
  }

  Future<void> _cargarUsuarios() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('usuarios');
    if (data != null) {
      setState(() {
        usuarios = data;
      });
    }
  }

  Future<void> _guardarUsuarios() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('usuarios', usuarios);
  }

  void _agregarUsuario(String usuario) async {
    setState(() {
      usuarios.add(usuario);
    });
    await _guardarUsuarios();
  }

  void _editarUsuario(int index, String nuevoValor) async {
    setState(() {
      usuarios[index] = nuevoValor;
    });
    await _guardarUsuarios();
  }

  void _eliminarUsuario(int index) async {
    setState(() {
      usuarios.removeAt(index);
    });
    await _guardarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CRUD de Usuarios')),
      body:
          usuarios.isEmpty
              ? const Center(child: Text('No hay usuarios guardados'))
              : ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(usuarios[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () async {
                            final nuevoNombre = await Navigator.push<String>(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => UsuariosView(
                                      valorInicial: usuarios[index],
                                    ),
                              ),
                            );
                            if (nuevoNombre != null && nuevoNombre.isNotEmpty) {
                              _editarUsuario(index, nuevoNombre);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _eliminarUsuario(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final resultado = await Navigator.push<String>(
            context,
            MaterialPageRoute(builder: (_) => const UsuariosView()),
          );
          if (resultado != null && resultado.isNotEmpty) {
            _agregarUsuario(resultado);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
