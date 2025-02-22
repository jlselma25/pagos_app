#!/bin/bash

# Descargar Flutter
git clone https://github.com/flutter/flutter.git -b stable

# Añadir Flutter al PATH
export PATH="$PATH:$(pwd)/flutter/bin"

# Verificar si Flutter está instalado
flutter --version

# Asegurarse de que las dependencias de Flutter estén correctamente instaladas
flutter doctor