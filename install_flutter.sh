#!/bin/bash

# Instalar dependencias necesarias
sudo apt-get update
sudo apt-get install -y ninja-build libgtk-3-dev

# Descargar Flutter
git clone https://github.com/flutter/flutter.git -b stable

# Añadir Flutter al PATH de manera temporal en el script
export PATH="$PATH:$(pwd)/flutter/bin"

# Verificar si Flutter está instalado
$(pwd)/flutter/bin/flutter --version

# Asegurarse de que las dependencias de Flutter estén correctamente instaladas
$(pwd)/flutter/bin/flutter doctor

# Ahora construir el proyecto
$(pwd)/flutter/bin/flutter build web