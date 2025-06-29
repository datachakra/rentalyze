# Rentalyze

**Comprehensive Real Estate Portfolio Management App**

Rentalyze is a cross-platform Flutter application designed for property investors to track, manage, and optimize their rental property investments. The app provides complete portfolio oversight, financial analytics, tenant management, and automated reporting capabilities.

## Features

### 🏠 Property Management
- Add and manage multiple properties
- Track property details, photos, and documents
- Monitor property values and appreciation
- Property performance analytics

### 💰 Financial Tracking
- Record income and expenses
- Calculate ROI and cash flow
- Generate financial reports
- Tax calculation assistance

### 👥 Tenant Management
- Manage tenant information and leases
- Track rent payments and due dates
- Communication tools
- Lease renewal management

### 📊 Analytics & Reporting
- Portfolio performance dashboards
- Interactive charts and visualizations
- Custom report generation
- Market benchmarking

### 🔔 Smart Notifications
- Rent due reminders
- Maintenance notifications
- Lease expiry alerts
- Market updates

## Tech Stack

- **Frontend**: Flutter 3.32.4
- **Backend**: Firebase (Firestore, Auth, Storage, Functions)
- **State Management**: Riverpod
- **Architecture**: Clean Architecture
- **UI Framework**: Material Design 3
- **Navigation**: Go Router

## Getting Started

### Prerequisites
- Flutter SDK 3.32.4 or higher
- Dart 3.8.1 or higher
- Firebase project setup

### Installation

1. Clone the repository
```bash
git clone https://github.com/username/rentalyze.git
cd rentalyze
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase
- Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
- Update Firebase configuration

4. Run the app
```bash
flutter run
```

## Project Structure

```
lib/
├── core/              # Core utilities and constants
├── data/              # Data layer (repositories, models, services)
├── domain/            # Business logic (entities, use cases)
├── presentation/      # UI layer (screens, widgets, providers)
└── main.dart         # App entry point
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please open an issue on GitHub.