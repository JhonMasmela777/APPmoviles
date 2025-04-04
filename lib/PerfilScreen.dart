import 'package:flutter/material.dart';
import 'package:hola_mundo/custom_drawer.dart';

class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Perfil'),
          bottom: TabBar(tabs: [Tab(text: 'GridView'), Tab(text: 'Lista')]),
        ),
        drawer: CustomDrawer(),
        body: TabBarView(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 6,
              itemBuilder:
                  (context, index) =>
                      Card(child: Center(child: Text('Item \$index'))),
            ),
            ListView.builder(
              itemCount: 10,
              itemBuilder:
                  (context, index) => ListTile(title: Text('Elemento \$index')),
            ),
          ],
        ),
      ),
    );
  }
}
