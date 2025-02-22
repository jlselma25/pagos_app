#!/bin/bash
# Descargar Flutter
git clone https://github.com/flutter/flutter.git -b stable

# Añadir Flutter al PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Verificar la instalación de Flutter
flutter doctor