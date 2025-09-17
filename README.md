# Espeletia Visitor System (Laravel)

Production‑grade template for a **Visitor & Keys Management** system built with **Laravel** + **PostgreSQL**.  
Designed to be easy to run (Docker) and friendly for recruiters: clear README, CI, and screenshots.

> This repository ships as a **template**. The actual Laravel app will live inside `src/` after you scaffold it (see Quick Start).

## ✨ Features (current & planned)
- **Authentication & Roles**: Admin · Supervisor · User
- **Visitors module**: register entries/exits, **CSV/PDF exports**, filters by ID, date, department, card, exit status
- **Departments** & **Cards** modules (relations with Visitors)
- **Keys module**: types (`key_types`) + **Key logs** with multiple keys per record; **availability control** until return
- **Email notifications**: on new visitor (to department contact) and on new key log (to `key_types.email`)
- **AJAX reactive search** for Visitors & Key logs (smooth UX without full page reload)
- **User dashboard (guest)**: lightweight view without sidebar, accessible via a special route for “User” role
- **Welcome popup** only for specific roles (not Admin/Supervisor)
- **Reports** with filters + custom export view (`resources/exports/visitor_export.blade.php`)
- **Graph/Teams integration**: *deprecated* (kept as legacy, disabled by default)
- **CI ready**: PHPStan, PHPUnit, Laravel Pint; **Docker** for reproducible envs

> Tech: Laravel 11 (target), PHP 8.3, PostgreSQL, Nginx, Docker, GitHub Actions, Blade, maatwebsite/excel (exports).

## 🧪 Quick Start (Docker, recommended)
Prereqs: Docker + Docker Compose

```bash
# 1) Clone
git clone <your-repo-url> espeletia-visitor-system && cd espeletia-visitor-system

# 2) Scaffold Laravel into src/ (one-time)
bash scripts/init.sh
# (This runs composer in a container, creates Laravel in src/, and generates APP_KEY)

# 3) Configure environment (already included)
#   - src/.env points to the Docker Postgres service by default

# 4) Migrate & seed (optional seeds if you add them later)
docker compose exec app php artisan migrate --seed

# 5) Open the app
# http://localhost:8080
```

### Local Dev (without Docker)
```bash
# 1) Install PHP 8.3, Composer, Postgres
composer create-project laravel/laravel src
cp .env.example src/.env
php -d detect_unicode=0 -r "copy('src/.env', 'src/.env');" 2>/dev/null || true

# 2) Edit DB_* in src/.env to match your local Postgres
php -S localhost:8000 -t src/public   # or: php artisan serve (from src/)
```

## 🔧 Configuration
**Environment defaults (Docker)** — see `.env.example`:
```
APP_URL=http://localhost:8080

DB_CONNECTION=pgsql
DB_HOST=db
DB_PORT=5432
DB_DATABASE=espeletia
DB_USERNAME=espeletia
DB_PASSWORD=espeletia
```
**Mail** (optional for notifications):
```
MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
MAIL_FROM_ADDRESS="noreply@example.com"
MAIL_FROM_NAME="Espeletia"
```

## ✅ CI (GitHub Actions)
Workflow: `.github/workflows/php-ci.yml` (already included)
- Installs deps (if `src/composer.json` exists)
- **PHPStan** (static analysis) — non-blocking
- **Laravel Pint** (code style) — non-blocking
- **PHPUnit** — non-blocking (make tests pass when you add them)

> Non‑blocking = won’t fail your PRs until you add the tools; switch to strict later.

## 📁 Structure
```
src/                  # Laravel app (created by scripts/init.sh)
docs/assets/          # screenshots, diagrams (add your PNG/GIFs here)
scripts/
  init.sh             # scaffold & start Docker stack
  nginx.conf          # nginx vhost
.github/workflows/
  php-ci.yml          # CI pipeline
docker-compose.yml
.env.example
```

## 🖼 Screenshots
Place images in `docs/assets/` and embed them here, for example:
```
![Dashboard](docs/assets/dashboard.png)
![Visitors Table](docs/assets/visitors-table.png)
```

## 🗺 Roadmap (suggestions)
- Seeders with **sample roles/users** for easy demo
- Policies/Permissions (Gate) per module
- Basic audit trail (created_by / updated_by) + activity log
- Pagination + export on Key logs with **multiple keys**
- Optional Mailhog container for previewing emails
- Containerized **Mailhog** and **pgAdmin** services for dev

## 🛡 License
MIT — see [LICENSE](LICENSE).

---

### Notes
- This is a template; your existing Espeletia app can be migrated here by moving code into `src/`.
- Sensitive configs must live in `.env` (never commit secrets). Use `.env.example` as a reference.
