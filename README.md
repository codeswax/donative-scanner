# Proyecto LP Grupo #3 - Donative Scanner App

Aplicación para dispositivos Android hecha para la materia de Lenguajes de Programación, desarrollada usando dos tecnologías: **Express.js** en el backend (**JavaScript**) y **Flutter** en el frontend (**Dart**).

# Descripción

Donative Scanner es una aplicación orientada a fundaciones sin fines de lucro que manejan grandes ingresos de productos como donativos en campañas de recolección.

<p align="center">
  <img src="https://github.com/user-attachments/assets/17ae0bcf-aced-45df-9eb0-edfa59f38fb8" />
</p>

## Funcionalidades

En la versión preliminar de la aplicación, el usuario puede:

 - Crear campañas de recolección con nombre, descripción y cantidad de donativos requeridos.
 - Crear categorías de productos con nombre, descripción y campos adicionales.
 - Escanear un código QR de producto y registrarlo en la base de datos. Además puede editar la cantidad donado del producto y eliminar el registro.

# Ejecución
Para poder correr la aplicación en modo debugging, se debe tener preparado lo siguiente:

- Editor de código
- Un dispositivo móvil con USB debugging activado
- Node.js y Express.js
- Flutter framework
- Base de datos no relacional Firestore

## Backend

En el editor de código de preferencia abre la carpeta "backend" y ejecuta en el terminal los siguientes comandos:

    npm install
    nodemon server.js

> Se instalarán las dependencias necesarias y se ejecutará el servidor.

## Frontend

En el editor de código de preferencia abre la carpeta "donative_scanner" y ejecuta en el terminal los siguientes comandos:

    flutter clean
    flutter pub get
    flutter run
    
> Realiza una limpieza de los archivos caché y luego procede a la reinstalación de todas las dependencias. Finalmente, ejecuta el proyecto.

Dependiendo de la plataforma donde requieras probar la app, debes escribir la opción en la línea de comandos.

    [1]: Windows (windows)
    [2]: Chrome (chrome)
    [3]: Edge (edge)
    Please choose one (or "q" to quit): 
  
 > Nota: Ejecutar la aplicación en navegadores hace que la funcionalidad de escaneo no esté disponible.

## Adicional (Uso de dispositivo móvil)

Para que el backend pueda funcionar en un dispositivo físico, se debe hacer lo siguiente:

1. Ingresa a DevTools. En la barra de navegación de tu navegador de preferencia, escribe: `[navegador]://inspect`.
2. En Devices, selecciona **Port Forwarding.**
3. Ingresa en los campos **5000** y **localhost**.
4. Marca **Enable Port Forwarding** y presiona **Done**.
5. Espera a que se realice la conexión. Debe aparecer el nombre del teléfono y un led de color verde.

En caso de tener conectado el dispositivo móvil, VS Code reconocerá automáticamente el equipo y lo seleccionará por ti.

## Consideraciones

- Validar que tanto el equipo como el dispositivo móvil estén conectadas a la misma red. 
- Desactivar el Firewall de Windows.
