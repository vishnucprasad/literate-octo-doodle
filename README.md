# Aaradhya Temple Dashboard

Aaradhya Temple is a comprehensive dashboard application for temple management. It serves as an administrative interface for temples registered with the Aaradhya platform, allowing temple administrators to manage pooja bookings, services, events, and more.

## Features

- **Temple Profile Management**: Customize temple details, services, and information
- **Pooja Booking Management**: View, approve, and manage booking requests
- **Service Management**: Add, edit, and manage services offered by the temple
- **Event Management**: Create and manage temple events and celebrations
- **Donation Tracking**: Monitor and track donations received through the platform
- **Analytics Dashboard**: Get insights on bookings, services, and visitor engagement
- **Notification System**: Send updates and important information to devotees

## Getting Started

### Prerequisites

- Flutter SDK 3.19.0 or higher
- Dart SDK 3.3.0 or higher
- Firebase project with required services enabled
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
   ```
   git clone https://github.com/UncommonBrains/aaraadhya-temple-dashboard.git
   ```

2. Navigate to the project directory
   ```
   cd aaraadhya-temple-dashboard
   ```

3. Install dependencies
   ```
   flutter pub get
   ```

4. Configure Firebase
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android and iOS apps to the project
   - Download and place the configuration files (google-services.json for Android, GoogleService-Info.plist for iOS)
   - Follow Firebase setup instructions for Flutter

5. Run the app
   ```
   flutter run
   ```

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern:
- **Model**: Data layer representing the business logic and data sources
- **View**: UI components that display data and capture user interactions
- **ViewModel**: Bridge between Model and View, handling business logic and state

Riverpod is used for state management and dependency injection throughout the application.

## Tech Stack

- **Flutter**: UI framework
- **Firebase**: Backend services
  - Authentication
  - Firestore
  - Storage
  - Cloud Functions
  - Cloud Messaging
- **Riverpod**: State management and dependency injection
- **Go_Router**: Navigation
- **Dio**: Network requests
- **Flutter Hooks**: UI functionality reuse

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any queries or support, please contact us at:
- Email: contactus@aaraadhya.in
- Website: https://aaraadhya.in

## Acknowledgments

- All the temples and their administrators who provided valuable feedback
- The Aaradhya team for their continuous support
- Flutter and Firebase communities for their excellent resources
