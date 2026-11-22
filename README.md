# Tu Solution

Aplicación Android hecha con **Flutter** para los técnicos de un taller de reparación de celulares, tablets y laptops.
Resuelve los problemas del taller: evitar que dos técnicos reparen el mismo equipo, saber el estado exacto de cada equipo, controlar el stock de repuestos y conservar el historial de reparaciones por equipo y por cliente.

- **Asignatura:** Programación para Dispositivos Móviles
- **Trabajo:** Segundo Examen Parcial, Ingeniería Informática, 3er año
- **Profesor:** Ing. Roilán Rodríguez Castillo
- **Autor:** _<escribe aquí tu nombre>_

La aplicación es solo para técnicos: no tiene autenticación ni interacción con los clientes, y funciona **100 % sin conexión**. Los datos se guardan en el teléfono y se conservan al cerrar la app.

## Tecnologías

| Tecnología | Uso |
|---|---|
| Flutter (Android) | Interfaz de usuario |
| Drift + SQLite | Persistencia local (`drift`, `drift_flutter`, `drift_dev`) |
| Riverpod | Gestión de estado (`flutter_riverpod`) |
| build_runner | Generación del código de Drift |
| Navigator 1.0 | Navegación entre pantallas |

Arquitectura **MVVM**:

- **Model:** tablas, DAOs y clases de dominio (`database/`, `models/`).
- **ViewModel:** estado y lógica de cada pantalla con providers de Riverpod (`viewmodels/`, `providers/`).
- **View:** pantallas y widgets que solo muestran el estado y llaman al ViewModel (`views/`).

Drift emite los datos como `Stream`; Riverpod los expone con `StreamProvider` y la interfaz se actualiza sola cuando cambia la base de datos.

## Requisitos

- Flutter estable reciente (Dart ≥ 3.5) y Android Studio con el plugin de Flutter.
- Un emulador Android o un teléfono Android con **Depuración USB** activada.
- En **Windows**: activar el **Modo de desarrollador** (Configuración → Privacidad y seguridad → Para programadores). Sin esto, `flutter pub get` falla con el mensaje _"Building with plugins requires symlink support"_.
- Conexión a internet **solo la primera vez**, para descargar dependencias y que Gradle compile. Después la app no necesita internet.

## Cómo abrir y ejecutar (paso a paso)

1. **Clonar el repositorio**
   ```
   git clone https://github.com/marcelnaranjo911-sudo/Tu_Solution.git
   ```
2. **Abrir la carpeta** `Tu_Solution` en Android Studio.
3. **Instalar las dependencias**
   ```
   flutter pub get
   ```
   (o el botón **Pub get** que aparece sobre `pubspec.yaml`).
4. **Generar el código de Drift.** Crea `database.g.dart` y `daos.g.dart` en `lib/database/`:
   ```
   dart run build_runner build
   ```
   Debe terminar con `Succeeded` (puede mostrar avisos `W` que no afectan al funcionamiento).
5. **Elegir un dispositivo Android** (emulador o teléfono). Para ver los disponibles:
   ```
   flutter devices
   ```
6. **Ejecutar la aplicación**
   ```
   flutter run -d <id_del_dispositivo>
   ```
   o pulsar el botón ▶ de Android Studio con el dispositivo seleccionado. La primera compilación de Gradle puede tardar varios minutos.

La primera vez que se abre la app se crea la base de datos con **datos de ejemplo**. Para volver a ese estado inicial, desinstala la app del dispositivo y ejecútala de nuevo.

### Si algo falla

| Problema | Solución |
|---|---|
| Errores como _"Target of URI hasn't been generated"_ o _"Undefined name 'tecnicos'"_ | Falta generar el código: ejecuta `dart run build_runner build` |
| _"Building with plugins requires symlink support"_ | Activa el Modo de desarrollador de Windows y repite `flutter pub get` |
| _"Host desconocido (dl.google.com)"_ al compilar | Es la conexión a internet; revisa la red y vuelve a ejecutar |
| El teléfono no aparece en `flutter devices` | Activa la Depuración USB y acepta la autorización en la pantalla del teléfono |
| Errores raros de caché | `flutter clean`, luego `flutter pub get` y `dart run build_runner build` |

## Funcionalidades

La app tiene una barra de navegación inferior con cinco pantallas:

- **Inicio (dashboard):** órdenes abiertas, desglose por estado, repuestos con stock bajo (alertas) y carga de trabajo de cada técnico.
- **Órdenes:** lista de todas las órdenes con filtros por estado (Recibida, En reparación, Lista, Entregada, Cancelada). Cada tarjeta muestra el equipo, el estado y el técnico responsable. Botón flotante para crear una orden nueva.
- **Técnicos:** los 3 técnicos con sus órdenes en curso y terminadas; al tocar uno se ven sus órdenes asignadas y las que ya terminó.
- **Inventario:** repuestos con código, precio y stock. Los que tienen `stock <= stockMínimo` se resaltan en rojo. Permite reponer stock.
- **Historial:** buscador por número de serie o por teléfono del dueño. Muestra el equipo y todas sus órdenes pasadas con los trabajos realizados, las piezas usadas y el costo total.

### Pantalla de la orden

- Datos del equipo y del dueño, estado y técnico responsable (ambos editables desde la propia pantalla).
- **Trabajos de mano de obra:** descripción y costo.
- **Repuestos usados:** se eligen del inventario con su cantidad.
- **Costo total** = mano de obra + repuestos.
- **Editar orden** (icono de lápiz): reutiliza la pantalla de crear, con los datos cargados y las mismas validaciones.
- **Eliminar orden** (icono de papelera): pide confirmación y borra la orden, que deja de verse en el inicio, la lista y el historial.

### Crear una orden

Formulario con tipo, marca, modelo, número de serie, nombre y teléfono del dueño, falla reportada y técnico asignado. Todos los campos son obligatorios. En marca, modelo, nombre y teléfono se muestra un **desplegable de sugerencias** con los datos ya guardados, para seleccionarlos directamente.

## Reglas del taller implementadas

- **Un mismo equipo no puede tener dos órdenes abiertas a la vez.** Se identifica por el número de serie; si ya hay una orden abierta, la app lo rechaza e indica qué técnico la tiene. Esto evita que dos técnicos reparen el mismo equipo.
- **Responsable claro:** cada orden tiene un técnico asignado, visible en la lista y en el detalle, y se puede reasignar.
- **El stock baja automáticamente** al agregar un repuesto a una orden, en una transacción de base de datos (o se hace todo o nada). Si no hay stock suficiente, la app lo impide. Al quitar el repuesto de la orden, el stock se devuelve.
- **Alerta de stock bajo** cuando `stock <= stockMinimo`, en el inventario y en el inicio.
- **Órdenes cerradas** (entregada o cancelada): no se pueden agregar trabajos ni repuestos mientras estén en ese estado.
- **Un equipo puede volver muchas veces:** si se registra un número de serie que ya existe y no tiene orden abierta, se reutiliza el equipo y se actualizan sus datos de contacto y la falla.
- **Editar:** el número de serie no puede coincidir con el de otro equipo. Los datos del equipo pertenecen al equipo, por lo que se reflejan también en sus órdenes anteriores del historial.
- **Eliminar:** borra la orden con sus trabajos y repuestos usados. Si la orden no estaba entregada, las piezas vuelven al inventario; si estaba entregada, no, porque ya se gastaron. Si el equipo se queda sin órdenes, también se elimina.

## Base de datos (Drift / SQLite)

| Tabla | Campos principales |
|---|---|
| `Tecnicos` | id, nombre |
| `Equipos` | id, tipo, marca, modelo, numeroSerie (único), nombreDueno, telefonoDueno, fallaReportada |
| `OrdenesReparacion` | id, equipoId → Equipos, tecnicoId → Tecnicos, estado, costoManoObra, fecha |
| `Repuestos` | id, nombre, codigo (único), precio, stock, stockMinimo |
| `RepuestosUsados` | id, ordenId → OrdenesReparacion, repuestoId → Repuestos, cantidad |
| `TrabajosRealizados` | id, ordenId → OrdenesReparacion, descripcion, costoManoObra |

El estado de la orden es un enum: `recibida`, `enReparacion` (se muestra como "En reparación"), `lista`, `entregada` y `cancelada`.

### Datos de ejemplo (se cargan al crear la base)

- **3 técnicos:** Carlos, Ana y Luis.
- **6 repuestos:** pantalla, batería, conector de carga, módulo de cámara, teclado de laptop y pasta térmica. El conector de carga y el teclado arrancan con stock bajo para ver la alerta.
- **2 equipos con sus órdenes:** un Samsung Galaxy A52 _en reparación_ (técnico Carlos, con un trabajo y una pantalla usada) y un Lenovo IdeaPad 3 _recibido_ (técnica Ana).

## Estructura del proyecto

```
lib/
  main.dart                      Inicia Drift, Riverpod y el tema oscuro
  database/
    tables.dart                  Tablas y enum de estados
    database.dart                Base de datos y datos de ejemplo
    daos.dart                    Acceso a datos y reglas (stock, transacciones)
    database.g.dart, daos.g.dart Código generado por build_runner
  models/                        Clases de dominio, extensiones y errores de negocio
  providers/                     Providers de Riverpod (base de datos, DAOs y streams)
  viewmodels/                    Estado y lógica de cada pantalla
  views/
    main_shell.dart              Navegación inferior
    dashboard_screen.dart        Inicio
    ordenes_screen.dart          Lista y filtros
    crear_orden_screen.dart      Crear y editar orden
    orden_detalle_screen.dart    Detalle, trabajos, repuestos, editar y eliminar
    tecnicos_screen.dart         Técnicos y su carga
    inventario_screen.dart       Repuestos y stock
    historial_screen.dart        Búsqueda e historial
    widgets/                     Widgets reutilizables
  theme/app_theme.dart           Tema oscuro (morado, negro y gris oscuro)
```

## Capturas de pantalla

Las capturas reales de la aplicación corriendo en un teléfono Android están en la carpeta [`capturas/`](capturas/) de este repositorio.

## Pruebas

```
flutter test
```
