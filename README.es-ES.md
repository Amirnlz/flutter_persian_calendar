

# PersianCalendar

Un widget **selector de fechas persa (Jalali)** ligero pero potente para Flutter.  
Permite a tus usuarios seleccionar fácilmente años, meses y días en una interfaz de calendario Jalali hermosa, localizada y desplazable.
[![pub package](https://img.shields.io/pub/v/flutter_persian_calendar.svg?color=%23e67e22&label=pub&logo=flutter_persian_calendar)](https://pub.dev/packages/flutter_persian_calendar)

---

## Características

- **Calendario Jalali**: Todo lo que necesitas para seleccionar fechas persas (Jalali).
- **Interfaz flexible**: Colores de fondo, primarios y secundarios personalizables, además de estilos de texto.
- **Configurable**: Pasa tu propio callback `onDateChanged`, un `confirmButton`, o utiliza los valores predeterminados.
- **Desplazamiento**: Permite navegar a través de un amplio rango de fechas mediante vistas de año, mes y día.
- **Localización integrada**: La dirección se establece automáticamente en RTL (de derecha a izquierda) para el persa.

---

## Instalación

1. Agrega este paquete a tu `pubspec.yaml`:
   ```yaml
   dependencies:
     persian_calendar: ^0.0.3
   ```
2. Ejecuta `flutter pub get`.
3. Imprótalo en tu código Dart:
   ```dart
   import 'package:persian_calendar/persian_calendar.dart';
   ```

---

## Inicio Rápido

A continuación se muestra un ejemplo mínimo que ilustra cómo incrustar el widget **PersianCalendar** en tu aplicación:

```dart
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart'; // or your Jalali library
import 'package:persian_calendar/persian_calendar.dart';

class CalendarExample extends StatelessWidget {
  const CalendarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Persian Calendar Example')),
      body: Center(
        child: PersianCalendar(
          initialDate: Jalali(1402, 12, 25), // Optional: Defaults to Jalali.now()
          startingDate: Jalali(1300, 1, 1), // Optional range start
          endingDate: Jalali(1405, 1, 1), // Optional range end
          onDateChanged: (selectedDate) {
            debugPrint('Selected date: $selectedDate');
          },
        ),
      ),
    );
  }
}
```

Esto muestra inmediatamente un calendario Jalali que por defecto utiliza la `initialDate` especificada. Cuando el usuario selecciona el año, mes y día, `onDateChanged` se activará con la fecha final.

---

## Captura de Pantalla

A continuación se muestra una captura de pantalla de ejemplo (el diseño y el estilo pueden variar según el tema y la configuración):

![Persian Calendar Banner](sceenshots/banner.png?raw=true)

---

## Uso Avanzado

### 1. Altura y Colores Personalizados

Si necesitas ajustar la altura o cambiar los colores:

```dart
PersianCalendar(
  height: 350.0,
  backgroundColor: Colors.grey.shade100,
  primaryColor: Colors.pink.shade200,
  secondaryColor: Colors.blue.shade200,
  textStyle: const TextStyle(fontSize: 16, color: Colors.black87),
  onDateChanged: (selectedDate) {
  // do something interesting
  },
)
```

### 2. Botón de Confirmación Personalizado

Por defecto, si no se proporciona `confirmButton`, mostramos un `ElevatedButton` con la etiqueta "تایید". Para inyectar tu propio botón:
```dart
PersianCalendar(
  onDateChanged: (selectedDate) {
  debugPrint('User picked: $selectedDate');
  },
  confirmButton: ElevatedButton(
  onPressed: () {
  // Close dialog or do something else
  debugPrint('User confirmed date selection');
  },
    child: const Text('Confirm'),
  ),
)
```
Tú decides cómo manejar la fecha elegida en tu propio flujo de interfaz.

### 3. Uso en un Diálogo
Para colocar el `PersianCalendar` dentro de un diálogo:
```dart
Future<void> _showPersianCalendarDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (dialogCtx) {
      return AlertDialog(
        content: PersianCalendar(
          onDateChanged: (jalaliDate) {
            debugPrint('Dialog - selected date: $jalaliDate');
          },
        ),
      );
    },
  );
}
```

Luego llama a `_showPersianCalendarDialog(context)` desde cualquier parte de tu árbol de widgets (por ejemplo, al tocar un botón).

---

## Contribuciones

- No dudes en enviar pull requests o reportar problemas.
- Añade nuevas funcionalidades o mejora el diseño.
- No olvides dar estrella al repositorio si lo encuentras útil (¡las estrellas son sorprendentemente motivadoras, incluso para Calendarios Persas!).
