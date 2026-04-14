# Donation Management System (DMS)

![App Logo](assets/images/Donation%20Logo.png)

A state-of-the-art **Donation Management System** built with **Flutter**, following the strictest principles of **Clean Architecture** and **Modular State Management**. This project is designed for nonprofit organizations to manage donors, track contributions, and oversee distributions with a high-performance, aesthetically pleasing dashboard.

---

## 🌟 Key Features

### 🏢 1. Intelligence Dashboard
The heart of DMS is its modular dashboard, which provides high-level insights using real-time data:
- **KPI Metrics**: Real-time cards showing Total Donations, Active Cases, New Donors, and Funds Distributed.
- **Dynamic Charts**: Interactive line charts powered by `fl_chart` to visualize donation trends by Week, Day, or Month.
- **Recent Activity Tracking**: Live table showing the latest donations with detailed donor information and categorical tagging.
- **Fund Distribution Overview**: Transparent view of where resources are being allocated.

### 👥 2. Donor & Case Management
- **Donor Database**: Complete registry of donors (Individual/Corporate) with search, pagination, and history.
- **Distribution Cases**: Track specific charitable cases requiring funding, including goals and current progress.
- **Categories & Employees**: Manage internal categories and staff roles within the organization.

### 🔐 3. Security & Auth
- **JWT Authentication**: Secure login system with encrypted token storage.
- **Protected Routes**: Navigation guards using `GoRouter` to ensure authorized access only.

---

## 🏗️ Architecture & Design Pattern

This project adheres to **Clean Architecture** to ensure maintenance-free scalability and independent testing.

### 층 Layered Architecture
1.  **Domain Layer (Core Logic)**:
    - **Entities**: Plain Dart objects representing the business models.
    - **Use Cases**: Encapsulates specific business logic (e.g., `GetDonationTrends`).
    - **Repository Interfaces**: Abstract definitions of data operations.
2.  **Data Layer (Infrastructure)**:
    - **Models**: Data Transfer Objects (DTOs) with JSON serialization.
    - **Repositories Implementation**: Concrete implementation of domain interfaces.
    - **Data Sources**: Remote (Dio) and Local (Secure Storage) data handling.
3.  **Presentation Layer (UI)**:
    - **Modular Cubits**: Each section of the screen has its own BLoC/Cubit to ensure atomic state updates.
    - **Clean UI Components**: Adheres to a strict rule of <100 lines per widget file for maximum readability.

---

## 🎨 UI/UX Excellence
- **Modern Design**: Vibrant HSL color palettes, glassmorphism elements, and premium typography (Inter/Outfit).
- **Interactive Feedback**: Shimmer placeholders for loading states and smooth transition animations using `animate_do`.
- **Responsive Layout**: Pixel-perfect scaling across Tablet and Desktop resolutions via `flutter_screenutil`.

---

## 🔧 Technical Stack
- **Framework**: Flutter (Stable)
- **State Management**: `flutter_bloc` (Modular Cubits)
- **Networking**: `Dio` + `InternetConnectionChecker` (with resilient failover)
- **Navigation**: `GoRouter` (Declarative routing)
- **Dependency Injection**: `GetIt` (Service Locator)
- **Charts**: `fl_chart`
- **Animations**: `animate_do`, `lottie`

---

## 📡 API Reference

Base URL: `http://donationdb.runasp.net/`

| Category  | Endpoint                        | Method | Description                     |
|-----------|---------------------------------|--------|---------------------------------|
| Auth      | `/api/Account/login`           | POST   | User authentication             |
| Dashboard | `api/Dashboard/kpis`           | GET    | Fetch KPI statistics            |
| Dashboard | `api/Dashboard/donationTrends` | GET    | Fetch chart data                |
| Dashboard | `api/Dashboard/lastDonations`  | GET    | List recent donor activities    |
| Dashboard | `api/Dashboard/lastDistributions`| GET  | List recent allocations         |
| Donors    | `api/Donors`                   | GET    | Paginated donor list            |
| Cases     | `api/Cases`                    | GET    | Charity cases registry          |

---

## 📂 Project Directory Structure
```bash
lib/
├── core/
│   ├── di/                 # GetIt registrations (injection_container.dart)
│   ├── network/            # Dio configuration, Interceptors, Connection checks
│   ├── theme/              # Colors, Typography, App Decoration
│   ├── utils/              # Base UseCase, formatters, extensions
│   ├── widgets/            # Global reusable UI (KPI Cards, Custom Buttons)
│   └── routes/             # GoRouter setup and route definitions
├── features/
│   ├── dashboard/          # Domain, Data, Presentation (Modular Sections)
│   ├── auth/               # Login & Splash logic
│   ├── donors/             # Donor management feature
│   └── ...                 # Other business modules
└── main.dart               # App entry point & Global Providers
```

---

## 🚀 Setup & Installation

1.  **Clone the Project**:
    ```bash
    git clone https://github.com/3AMI-Team/donation_management_system.git
    ```
2.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Configure Environment**:
    Ensure the `baseUrl` in `lib/core/network/api/api_endpoints.dart` points to your active server.
4.  **Run**:
    ```bash
    flutter run
    ```

---

## 🤝 Contribution Guidelines
This project is developed by the **3AMI Team**. For contributions:
1.  Follow the **Clean Architecture** patterns.
2.  Keep widget files between **60-100 lines**.
3.  Always use **Dependency Injection (sl)** for repository/cubit access.

---
© 2026 **3AMI-Team**. All Rights Reserved.
