# SWAT  
### Symfony Webpack Automation Toolkit

![PHP](https://img.shields.io/badge/PHP-8.2+-777BB4)
![Symfony](https://img.shields.io/badge/Symfony-7.x-000000)
![License](https://img.shields.io/badge/license-MIT-green)

A modern Symfony starter with CI/CD, automated deployments and built-in testing.

👉 Documentation: https://swat.depatin-florian.fr

SWAT is a **modern Symfony starter template** designed to bootstrap a production-ready application with a clean architecture, automated CI/CD, and a lightweight frontend stack.

It provides everything needed to start a new Symfony project with:

- ⚙️ automated CI pipelines
- 🚀 automated deployments
- 🧪 integrated testing
- 🎨 modern frontend tooling
- 📦 clean project structure
- 📚 integrated documentation

SWAT focuses on **developer productivity, performance and simplicity**, without introducing unnecessary complexity or heavy frontend frameworks.

---

## Philosophy

SWAT was created with a simple goal:

> Provide a clean, modern and production-ready Symfony foundation without overengineering the stack.

Many starters either:
- include **too many tools and abstractions**
- or provide **almost no structure at all**

SWAT aims to sit in the middle by offering:

- a **clean project structure**
- **modern frontend tooling**
- **automated CI/CD**
- **minimal dependencies**
- **predictable development workflow**

Everything included in SWAT is there to **solve a real development problem**.

---

## Core features

### Modern Symfony stack
Built on the latest Symfony version with a clean and production-ready configuration.

### Lightweight frontend
Twig + Webpack Encore + TypeScript + Turbo + SCSS.

No heavy SPA frameworks. Just fast and maintainable code.

### Automated CI/CD
GitHub Actions pipelines handle:

- dependency installation
- asset build
- tests execution
- automated deployments

### Integrated developer diagnostics
The homepage includes runtime checks to verify that:

- Symfony
- Twig
- Webpack Encore
- Turbo
- frontend assets

are correctly running.

### Clean project structure
The project is structured to be easily understandable and scalable.

### Template-ready
SWAT is designed to be used as a **GitHub template repository** to quickly bootstrap new projects.

---

## Tech stack

**Backend**

- PHP 8.2+
- Symfony
- Doctrine ORM
- Twig
- Turbo

**Frontend**

- Webpack Encore
- TypeScript
- SCSS

**Quality & Testing**

- PHPUnit
- PHPStan
- ESLint
- Vitest

**DevOps**

- GitHub Actions
- Automated deployments
- Preproduction + production workflows

---

## Getting started

SWAT is intended to be used as a **GitHub template repository**.

### 1 — Create your project

Open the SWAT repository and click **Use this template**.

Create your own repository from it.

Then clone it locally:

```bash
git clone https://github.com/your-username/your-project.git
cd your-project
```

---

### 2 — Install dependencies

```bash
composer install
npm install
```

---

### 3 — Build frontend assets

```bash
npm run dev
```

---

### 4 — Start the application

With Symfony CLI (recommended):

```bash
symfony serve
```

Or with PHP built-in server:

```bash
php -S localhost:8000 -t public
```

---

### 5 — Verify your setup

Open:

```text
http://localhost:8000
```

The homepage acts as a **technical diagnostic page** confirming that Symfony, Twig, Encore and frontend assets are working correctly.

---

## Cleaning the template

SWAT contains example pages, assets and configuration used to demonstrate the starter capabilities.

To start a real project, you can clean the template using the provided scripts.

PowerShell:

```bash
.\scripts\cleanup\clean-example-files.ps1
```

Linux / macOS:

```bash
./scripts/cleanup/clean-example-files.sh
```

These scripts remove example content while preserving the core project structure.

---

## CI/CD

SWAT includes GitHub Actions workflows providing:

- automated build
- test execution
- preproduction deployment
- production deployment via release tags

The pipelines are designed to be **simple, predictable and easily customizable**.

Deployment configuration relies on repository secrets for secure SSH access to the target servers.

---

## Documentation

The project includes a complete documentation website covering:

- setup guide
- CI/CD configuration
- project structure
- customization
- FAQ

👉 **Online documentation:** https://swat.depatin-florian.fr

---

## License

This project is released under the **MIT License**.

```text
MIT License

Copyright (c) 2026 Florian Depatin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## Author

**Florian Depatin**

Creator of the SWAT starter template.

---

## Roadmap

The core of SWAT is intentionally minimal.

Future improvements may include:

- community feedback integration
- CI/CD improvements
- real-world project validation

---

## Contributing

Contributions, ideas and feedback are welcome.

Feel free to open issues or discussions to suggest improvements.

---

## Project status

SWAT is actively maintained and used as a foundation for real Symfony projects.
