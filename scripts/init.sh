#!/usr/bin/env bash
set -e
echo "[*] Scaffolding Laravel into src/ ..."
docker run --rm -v "$PWD/src":/app -w /app composer:2 sh -lc "composer create-project laravel/laravel . && php artisan key:generate"
echo "[*] Starting Docker stack ..."
docker compose up -d
echo "[*] Run migrations:"
echo "    docker compose exec app php artisan migrate --seed"
echo "[*] Open http://localhost:8080"
