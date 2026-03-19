# SWAT  
### Symfony Webpack Automation Toolkit

![PHP](https://img.shields.io/badge/PHP-8.2+-777BB4)
![Symfony](https://img.shields.io/badge/Symfony-7.x-000000)
![License](https://img.shields.io/badge/license-MIT-green)

A modern Symfony starter with CI/CD, automated deployments and built-in testing.

👉 Documentation: https://swat.depatin-florian.fr

---

## 🚀 Overview

SWAT is a **modern Symfony starter template** designed to bootstrap a production-ready application with:

- a clean architecture  
- automated CI/CD pipelines  
- integrated testing tools  
- a lightweight and maintainable frontend stack  

It gives you a **solid foundation out of the box**, without overengineering your project.

---

## 🎯 Philosophy

SWAT was created with a simple goal:

> Provide a clean, modern and production-ready Symfony foundation without unnecessary complexity.

Most starters either:
- include **too many tools and abstractions**
- or provide **almost no structure at all**

SWAT sits in between by offering:

- a **clean and scalable structure**
- **modern but minimal tooling**
- **automated workflows**
- **predictable developer experience**

Everything included solves a **real development need**.

---

## ✨ Core Features

### ⚙️ Modern Symfony stack
Built on the latest Symfony version with a production-ready configuration.

### 🎨 Lightweight frontend
Twig + Webpack Encore + TypeScript + Turbo + SCSS.

No heavy SPA frameworks — just fast and maintainable code.

### 🚀 Automated CI/CD
GitHub Actions pipelines handle:

- dependency installation  
- asset build  
- test execution  
- deployments  

### 🧪 Integrated testing & quality tools
Includes:

- PHPUnit (backend tests)  
- PHPStan (static analysis)  
- ESLint (frontend linting)  
- Vitest (frontend tests)  

### 🧠 Built-in diagnostics
The homepage acts as a **technical validation page** to confirm that:

- Symfony  
- Twig  
- Webpack Encore  
- Turbo  
- frontend assets  

are correctly running.

### 🗂️ Clean project structure
Organized to be **readable, maintainable and scalable** from day one.

### 📦 Template-ready
Designed to be used as a **GitHub template repository**.

---

## 🧱 Tech Stack

### Backend
- PHP 8.2+
- Symfony
- Doctrine ORM
- Twig
- Turbo

### Frontend
- Webpack Encore
- TypeScript
- SCSS

### Quality & Testing
- PHPUnit
- PHPStan
- ESLint
- Vitest

### DevOps
- GitHub Actions
- Automated deployments
- Preprod + production workflows

---

## ⚡ Getting Started

SWAT is intended to be used as a **GitHub template repository**.

### 1 — Create your project

Use the template on GitHub, then:

git clone https://github.com/your-username/your-project.git
cd your-project

---

### 2 — Install dependencies

composer install
npm install

---

### 3 — Build frontend assets

npm run dev

---

### 4 — Start the application

symfony serve

or

php -S localhost:8000 -t public

---

### 5 — Verify your setup

http://localhost:8000

The homepage confirms that your stack is working correctly.

---

## 🧹 Cleaning the template

SWAT includes example content used for demonstration and validation.

To start with a clean base:

Windows

.\scripts\cleanup\clean-example-files.ps1

Linux / macOS

./scripts/cleanup/clean-example-files.sh

---

## 🔄 CI/CD

SWAT includes GitHub Actions workflows providing:

- automated build  
- test execution  
- preproduction deployment  
- production deployment  

The pipelines are designed to be:

- simple  
- predictable  
- easily customizable  

---

## 🗄️ Database & Migrations

SWAT includes **Doctrine migration checks in CI** and **automatic migration execution during deployment**.

In CI, the pipeline validates the database setup by running test migrations, checking the Doctrine schema and ensuring that no migration diff is pending.

During preproduction and production deployments, SWAT can create the database if needed and execute Doctrine migrations automatically, keeping the database schema in sync with the application code.

Example command:

php bin/console doctrine:migrations:migrate --no-interaction

⚠️ Make sure your database configuration is correct and that the target environment can access the database before deployment.

---

## 📚 Documentation

The project includes a complete documentation website:

- setup guide  
- CI/CD  
- project structure  
- customization  
- FAQ  

👉 https://swat.depatin-florian.fr

---

## 📄 License

This project is released under the **MIT License**.

---

## 👨‍💻 Author

Florian Depatin

---

## 🛣️ Roadmap

SWAT is intentionally minimal.

Future improvements may include:

- real-world feedback integration  
- CI/CD enhancements  
- ecosystem extensions  

---

## 🤝 Contributing

Contributions, ideas and feedback are welcome.

Feel free to open issues or discussions.

---

## 📌 Project Status

SWAT is actively maintained and used as a base for real Symfony projects.
