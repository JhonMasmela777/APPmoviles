# 🚀 Aplicación Flutter: Navegación y Ciclo de Vida de Widgets  

## 📖 Descripción  
Este proyecto es un ejercicio práctico en Flutter que explora el uso de navegación, widgets y el ciclo de vida de un `StatefulWidget`.  

Se implementan los siguientes conceptos clave:  
- 📌 **Navegación entre pantallas** utilizando `Navigator.push()` y `Navigator.pop()`.  
- 📌 **Widgets importantes**: `GridView`, `TabBar`, `Switch` y `TextField`.  
- 📌 **Evidencia del ciclo de vida** con `print()` en métodos como `initState()`, `didChangeDependencies()`, `build()`, `setState()` y `dispose()`.  

---

## 🛠️ **Tecnologías utilizadas**  
- Flutter 3.x  
- Dart  
- Material Design  

---

## 🎯 **Características del Proyecto**  
### 1️⃣ **Pantalla Principal (`MyHomePage`)**  
📌 Contiene un `TabBar` con dos pestañas:  
- **Lista** → Muestra una cuadrícula (`GridView`) con elementos numerados.  
- **Opciones** → Contiene un `Switch` para activar/desactivar una opción.  

📌 Al tocar un elemento del `GridView`, se abre la pantalla secundaria (`FormView`).  

📌 Se imprime en consola el **ciclo de vida del StatefulWidget** al ejecutarse los siguientes métodos:  
- `initState()` → Se ejecuta al crear el widget.  
- `didChangeDependencies()` → Se ejecuta cuando cambian las dependencias.  
- `build()` → Se ejecuta cada vez que la UI se redibuja.  
- `setState()` → Se ejecuta cuando cambia el estado del widget.  
- `dispose()` → Se ejecuta cuando el widget es eliminado.  

---

### 2️⃣ **Pantalla Secundaria (`FormView`)**  
📌 Recibe un **parámetro** desde `MyHomePage`, que muestra en un `Text`.  

📌 Contiene un `TextField` para escribir texto y un botón para regresar a la pantalla principal.  

📌 Se evidencian los métodos del ciclo de vida en consola.  

---

## 📸 **Evidencia del Ciclo de Vida**  
Cada método imprime un mensaje en la consola cuando se ejecuta.  

Ejemplo de salida en consola:  
```bash
initState() → Se ejecuta cuando el widget se crea por primera vez.
didChangeDependencies() → Se ejecuta cuando cambian las dependencias.
build() → Se ejecuta cada vez que el widget necesita reconstruirse.
setState() → Se ejecuta cuando cambia el estado del switch.
dispose() → Se ejecuta cuando el widget es eliminado permanentemente.
