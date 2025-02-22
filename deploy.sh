#!/bin/bash
# Instalar Flutter (si no está instalado)
flutter channel stable
flutter upgrade
flutter doctor
flutter pub get
flutter build web