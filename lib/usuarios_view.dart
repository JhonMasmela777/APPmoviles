import 'package:flutter/material.dart';

class UsuariosView extends StatefulWidget {
  final String? valorInicial;

  const UsuariosView({super.key, this.valorInicial});

  @override
  State<UsuariosView> createState() => _UsuariosViewState();
}

class _UsuariosViewState extends State<UsuariosView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.valorInicial ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _guardar() {
    final texto = _controller.text.trim();
    if (texto.isNotEmpty) {
      Navigator.pop(context, texto);
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.valorInicial != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar Usuario' : 'Nuevo Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Nombre del usuario',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardar,
              child: Text(esEdicion ? 'Guardar Cambios' : 'Guardar Usuario'),
            ),
          ],
        ),
      ),
    );
  }
}
