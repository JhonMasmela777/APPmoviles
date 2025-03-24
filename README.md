# 📱 Flutter Navigation & Widgets App

Este proyecto demuestra la navegación en Flutter usando `go_router`, la implementación de `GridView`, `TabBar` y la evidencia del ciclo de vida de los widgets.

## 🚀 Características  
- **Navegación con parámetros** entre pantallas.  
- **Lista de elementos con imágenes** usando `GridView`.  
- **Secciones con `TabBar`** para alternar entre vista de lista y configuración.  
- **Switch interactivo** para cambiar opciones.  
- **Evidencia del ciclo de vida** con `print()` en `initState()`, `build()`, `setState()` y `dispose()`.  

## 📌 Implementación  
1. **Navegación:** Se usa `Navigator.push()` para enviar parámetros a la pantalla `FormView`.  
2. **GridView:** Se muestran elementos con imágenes y descripciones.  
3. **TabBar:** Permite cambiar entre "Lista" y "Opciones".  
4. **Switch:** Controla un estado booleano con `setState()`.  

## 🛠️ Ciclo de Vida (Salida en consola)  
- Al iniciar la app:  
🟢 initState() de MyHomePage 🔵 didChangeDependencies() de MyHomePage 🟡 build() de MyHomePage

markdown
Copiar
Editar
- Al navegar a `FormView`:  
➡ Navegando a FormView con Elemento X 🟢 initState() de FormView 🔵 didChangeDependencies() de FormView 🟡 build() de FormView

markdown
Copiar
Editar
- Al modificar el `TextField` o `Switch`:  
⚡ setState() - Cambio detectado 🟡 build() actualizado

markdown
Copiar
Editar
- Al cerrar `FormView`:  
🔴 dispose() de FormView

diff
Copiar
Editar
- Al cerrar la app:  
🔴 dispose() de MyHomePage

markdown
Copiar
Editar

## 📸 Capturas de Pantalla  
*(Agrega imágenes aquí si es necesario)*  

### 📂 Estructura del Proyecto  
- `main.dart`: Punto de entrada de la app.  
- `home_page.dart`: Contiene `TabBar`, `GridView` y `Switch`.  
- `form_view.dart`: Pantalla secundaria que recibe parámetros.  

🔹 *Desarrollado con Flutter y Dart*  