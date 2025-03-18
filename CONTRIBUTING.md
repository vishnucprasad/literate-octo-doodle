# Contributing to Aaradhya Temple Dashboard

First off, thank you for considering contributing to Aaradhya Temple! It's people like you that make Aaradhya Temple such a great tool for temple administrators.

## Development Environment

### Requirements
- Flutter SDK 3.19.0 or higher
- Dart SDK 3.3.0 or higher
- Android Studio / VS Code with Flutter extensions
- Firebase CLI tools

### Setup
1. Fork the repository
2. Clone your fork
3. Run `flutter pub get` to install dependencies
4. Set up Firebase configuration for local development

## Architecture Guidelines

Aaradhya Temple follows the MVVM (Model-View-ViewModel) architecture pattern:

### Directory Structure
```
lib/
├── app/
│   ├── app.dart                    # Root application widget
│   ├── app_config.dart             # Application configuration
│   └── routes/                     # Application routing
│       ├── app_router.dart         # Router setup with GoRouter
│       └── route_names.dart        # Route name constants
│
├── core/
│   ├── constants/                  # Application constants
│   │   ├── api_constants.dart
│   │   ├── app_constants.dart
│   │   └── asset_constants.dart
│   ├── enums/                      # Enumerations
│   ├── exceptions/                 # Custom exceptions
│   │   ├── app_exception.dart
│   │   ├── network_exception.dart
│   │   └── auth_exception.dart
│   ├── extensions/                 # Extension methods
│   ├── mixins/                     # Reusable mixins
│   ├── theme/                      # Application theming
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   └── app_text_styles.dart
│   └── utils/                      # Utility classes
│       ├── validators.dart
│       └── network_utils.dart
│
├── di/                             # Dependency injection
│   └── providers.dart              # Global provider definitions utilities
│
├── data/
│   ├── datasources/                # Data sources interfaces
│   │   ├── local/                  # Local data source interfaces
│   │   │   ├── local_storage_datasource.dart
│   │   │   └── secure_storage_datasource.dart
│   │   └── remote/                 # Remote data source interfaces
│   │       ├── auth_datasource.dart
│   │       └── temple_datasource.dart
│   │
│   ├── datasources_impl/           # Data sources implementations
│   │   ├── local/                  # Local data source implementations
│   │   │   ├── hive_storage_impl.dart
│   │   │   └── secure_storage_impl.dart
│   │   └── remote/                 # Remote data source implementations
│   │       ├── auth_datasource_impl.dart
│   │       └── temple_datasource_impl.dart
│   │
│   ├── models/                     # Data models (Model in MVVM)
│   │   ├── auth/
│   │   │   ├── user_model.dart
│   │   │   └── auth_response_model.dart
│   │   ├── temple/
│   │   │   ├── temple_model.dart
│   │   │   ├── pooja_model.dart
│   │   │   └── booking_model.dart
│   │   └── api/
│   │       ├── api_response.dart
│   │       └── pagination_model.dart
│   │
│   ├── repositories/               # Repository interfaces
│   │   ├── auth_repository.dart
│   │   ├── temple_repository.dart
│   │   └── booking_repository.dart
│   │
│   └── repositories_impl/          # Repository implementations
│       ├── auth_repository_impl.dart
│       ├── temple_repository_impl.dart
│       └── booking_repository_impl.dart
│
├── services/                       # Service interfaces
│   ├── auth_service.dart
│   ├── navigation_service.dart
│   ├── storage_service.dart
│   ├── analytics_service.dart
│   └── notification_service.dart
│
├── services_impl/                  # Service implementations
│   ├── auth_service_impl.dart
│   ├── navigation_service_impl.dart
│   ├── storage_service_impl.dart
│   ├── firebase_analytics_service_impl.dart
│   └── firebase_messaging_service_impl.dart
│
├── presentation/
│   ├── common/                     # Common UI components
│   │   ├── widgets/                # Reusable widgets
│   │   │   ├── app_button.dart
│   │   │   ├── app_text_field.dart
│   │   │   └── loading_indicator.dart
│   │   └── dialogs/                # Common dialogs
│   │       ├── error_dialog.dart
│   │       └── confirmation_dialog.dart
│   │
│   ├── controllers/                # ViewModels/Controllers
│   │   ├── auth/
│   │   │   ├── auth_controller.dart        # ViewModel using Riverpod
│   │   │   └── auth_state.dart             # State class for the ViewModel
│   │   ├── temple/
│   │   │   ├── temple_controller.dart      # ViewModel using Riverpod
│   │   │   └── temple_state.dart           # State class for the ViewModel
│   │   └── booking/
│   │       ├── booking_controller.dart     # ViewModel using Riverpod
│   │       └── booking_state.dart          # State class for the ViewModel
│   │
│   └── screens/                    # UI screens (View in MVVM)
│       ├── auth/
│       │   ├── login/
│       │   │   ├── login_screen.dart
│       │   │   └── widgets/              # Screen-specific widgets
│       │   └── register/
│       │       ├── register_screen.dart
│       │       └── widgets/              # Screen-specific widgets
│       ├── dashboard/
│       │   ├── dashboard_screen.dart
│       │   └── widgets/                  # Dashboard widgets
│       │       ├── dashboard_stats_card.dart
│       │       └── recent_bookings_list.dart
│       └── temple/
│           ├── profile/
│           │   ├── temple_profile_screen.dart
│           │   └── widgets/              # Profile-specific widgets
│           └── poojas/
│               ├── pooja_list_screen.dart
│               └── pooja_detail_screen.dart
│
└── main.dart                       # Application entry point
```

### Dependency Injection with Riverpod
The architecture uses Riverpod for dependency injection with a clean approach:

1. Define interfaces for repositories and services
2. Implement concrete classes for these interfaces
3. Use Riverpod providers to instantiate and inject dependencies
4. Use `ref.watch()` or `ref.read()` to access dependencies in controllers and other providers

Global Provider Example:
```dart
// lib/di/providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

// Network client provider
@riverpod
Dio dioClient(DioClientRef ref) {
  final dio = Dio();

  // Configure dio options
  dio.options.baseUrl = ApiConstants.baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);

  // Add interceptors
  dio.interceptors.add(LogInterceptor(
    request: true,
    responseBody: true,
    requestBody: true,
    error: true,
  ));

  return dio;
}

// Local storage provider
@riverpod
LocalStorageDataSource localStorageDataSource(LocalStorageDataSourceRef ref) {
  return HiveStorageImpl();
}

// Firebase instances
@riverpod
FirebaseFirestore firestore(FirestoreRef ref) {
  return FirebaseFirestore.instance;
}

// Higher-level dependencies can depend on lower-level ones
@riverpod
TempleDataSource templeDataSource(TempleDataSourceRef ref) {
  final dio = ref.watch(dioClientProvider);
  return TempleDataSourceImpl(dio);
}
```

## Coding Standards

### Dart & Flutter Style Guide

We follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style) and [Flutter Style Guide](https://github.com/flutter/flutter/blob/master/docs/contributing/Style-guide-for-Flutter-repo.md).

#### Naming Conventions
- Classes, enums, typedefs, and extensions: `UpperCamelCase`
- Libraries, packages, directories, and source files: `snake_case`
- Variables, constants, parameters, and named parameters: `lowerCamelCase`
- Private identifiers: prefix with underscore (`_privateMember`)

#### Formatting
- Use 2 spaces for indentation
- Maximum line length of 80 characters
- Use trailing commas for multi-line parameter lists
- Run `flutter format .` before committing

#### Best Practices
- Prefer const constructors when possible
- Use the `required` keyword for mandatory named parameters
- Organize imports in three sections: dart imports, package imports, and relative imports
- Add documentation comments (`///`) for public APIs
- Use functional programming where appropriate (e.g., map, filter, reduce)

### Widget Structure
- Keep widgets focused and small
- Extract reusable widgets to separate files
- Use StatelessWidget when possible
- Follow a consistent order for widget properties and methods

## Git Workflow

### Branch Structure
- `main`: Production-ready code
- `develop`: Integration branch for ongoing development
- `feature/feature-name`: For new features
- `bugfix/bug-description`: For bug fixes
- `release/version-number`: For release preparation
- `hotfix/issue-description`: For urgent fixes to production

### Commit Message Structure
Follow the conventional commit format:
```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or modifying tests
- `chore`: Changes to the build process, dependencies, etc.

Example:
```
feat(auth): implement biometric authentication

Add fingerprint and face ID authentication options.

Closes #123
```

### Pull Request Process

1. Create a new branch from `develop` following the branch naming convention
2. Make your changes
3. Ensure tests pass and code is properly formatted
4. Update documentation if necessary
5. Submit a PR against the `develop` branch
6. Request review from at least one maintainer

#### Pull Request Template

```markdown
## Description
[Provide a brief description of the changes introduced by this PR]

## Related Issues
[Link to any related issues or tickets]

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update
- [ ] Code refactoring
- [ ] Performance improvement

## Checklist
- [ ] My code follows the project's coding standards
- [ ] I have updated the documentation accordingly
- [ ] I have added tests to cover my changes
- [ ] All new and existing tests passed
- [ ] My changes don't introduce any new warnings or errors
- [ ] I have checked for potential conflicts with other PRs

## Screenshots (if applicable)
[Add screenshots here if UI changes were made]

## Additional Notes
[Any additional information that might be helpful]
```

## Documentation

- Update README.md for major changes
- Document all public APIs with dartdoc comments
- Include examples for complex functionality
- Keep documentation in sync with code changes

Thank you for contributing to Aaradhya Temple! 🙏
