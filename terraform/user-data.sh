#!/bin/bash
sudo apt update -y
sudo apt install -y docker.io git unzip
sudo systemctl enable docker
sudo systemctl start docker

cd /home/ubuntu

# Clonar la app (reemplaza con tu repo)
if [ ! -d "app" ]; then
  git clone https://github.com/TUUSUARIO/tu-app.git app || true
fi

cd app || exit 0
docker compose up -d --build
