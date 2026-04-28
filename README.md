# 🕊️ Donation Management System (DMS)

[![Flutter Version](https://img.shields.io/badge/Flutter-3.11.0%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Web%20%7C%20Android%20%7C%20iOS-blue)](https://flutter.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-green)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A state-of-the-art **Donation Management System** built with **Flutter**, designed for nonprofit organizations to manage donors, track contributions, and oversee distributions with a high-performance, aesthetically pleasing dashboard.

---

## 🚀 Overview

DMS is an enterprise-grade solution that follows the strictest principles of **Clean Architecture** and **Modular State Management**. It provides real-time insights into charitable operations, ensuring transparency and efficiency in fund allocation.

---

## ✨ Key Features

### 📊 1. Intelligence Dashboard
The central hub of the system, offering high-level insights:
- **KPI Metrics**: Real-time tracking of Total Donations, Active Cases, New Donors, and Funds Distributed.
- **Interactive Analytics**: Line charts powered by `fl_chart` visualizing donation trends over different time periods.
- **Activity Feed**: Live monitoring of the latest donations and distributions with categorical tagging.

### 👥 2. Donor & Case Management
- **Comprehensive Registry**: Manage Individual and Corporate donors with advanced search and history.
- **Charity Cases**: Track specific beneficiaries/cases with goal-based progress tracking.
- **Fund Distribution**: Precise management of how and where donations are spent.

### 🏢 3. Organizational Management
- **Employee Roles**: Manage staff access and roles (Admin, Supervisor, etc.).
- **Categorization System**: Dynamic category management for logical grouping of donations and cases.

### 🔐 4. Security & Performance
- **JWT Authentication**: Secure session management with encrypted token storage via `flutter_secure_storage`.
- **Protected Routing**: Robust navigation guards using `GoRouter`.
- **Responsive Design**: Pixel-perfect scaling across Tablet and Desktop resolutions via `flutter_screenutil`.

---

## 🏗️ Architecture & Design Pattern

The project implements **Clean Architecture** to ensure the codebase is independent of frameworks, UI, and external agencies.

### 층 Layered Design
1.  **Domain Layer (Entities & UseCases)**: The business logic core. Contains pure Dart objects and business rules.
2.  **Data Layer (Repositories & Models)**: Handles data retrieval from remote (Dio) and local sources.
3.  **Presentation Layer (UI & BLoC/Cubit)**: Uses `flutter_bloc` for atomic state updates and modular UI components.

### 🧬 Dependency Injection
We use `GetIt` as a service locator for managing object lifecycles and decoupling components, initialized in `lib/core/di/injection_container.dart`.

---

## 🔧 Technical Stack

| Category           | Technology / Package                               |
|--------------------|----------------------------------------------------|
| **Framework**      | Flutter (Stable Channel)                           |
| **State Management**| `flutter_bloc` (Cubit Pattern)                     |
| **Networking**     | `Dio` + `ConnectivityPlus`                         |
| **Routing**        | `GoRouter`                                         |
| **DI**             | `GetIt`                                            |
| **Charts**         | `fl_chart`                                         |
| **Local Storage**  | `shared_preferences` + `flutter_secure_storage`    |
| **UI Components**  | `google_fonts`, `animate_do`, `lottie`, `shimmer`  |

---

## 📡 API Reference

Base URL: `http://donationdb.runasp.net/`

| Feature      | Endpoint                        | Method | Description                     |
|--------------|---------------------------------|--------|---------------------------------|
| **Auth**     | `/api/Account/login`           | POST   | User authentication             |
| **Dashboard**| `api/Dashboard/kpis`           | GET    | Fetch summary statistics        |
| **Dashboard**| `api/Dashboard/donationTrends` | GET    | Fetch chart data                |
| **Donations**| `api/Donations`                | GET    | Manage all donations            |
| **Donors**   | `api/Donors`                   | GET    | Paginated donor list            |
| **Cases**    | `api/Cases`                    | GET    | Charity cases registry          |
| **Employees**| `api/Employees`                | GET    | Staff management                |

---

## 🛠️ CI/CD & Deployment

The project includes an automated **GitHub Actions** workflow for continuous delivery:
- **Desktop Build**: Automatically compiles and archives Windows release builds on every push to `main`.
- **Artifacts**: Releases are published as ZIP archives for easy deployment.

Check [desktop_build.yml](.github/workflows/desktop_build.yml) for details.

---

## 📂 Folder Structure

```bash
lib/
├── core/
│   ├── di/                 # Dependency Injection setup
│   ├── network/            # API consumers & interceptors
│   ├── theme/              # Design tokens (Colors, Typography)
│   ├── routes/             # Navigation configuration
│   └── widgets/            # Reusable UI components
├── features/
│   ├── auth/               # Login & Authentication logic
│   ├── dashboard/          # Analytics & Overview
│   ├── donations/          # Donation tracking
│   ├── donors/             # Donor management
│   ├── cases/              # Beneficiary management
│   └── employees/          # Staff registry
└── main.dart               # App entry point
```

---

## 🚀 Getting Started

1.  **Clone**: `git clone https://github.com/3AMI-Team/donation_management_system.git`
2.  **Install**: `flutter pub get`
3.  **Run**: `flutter run -d windows` (or your preferred platform)

---

## 🤝 Contribution

1. Follow the **Clean Architecture** patterns.
2. Maintain widget files under **100 lines**.
3. Use **sl** (Service Locator) for all dependency access.

---
© 2026 **3AMI-Team**. All Rights Reserved.
