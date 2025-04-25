# 📱 Pokédex (Clean Architecture)

A modern Pokédex application built with Flutter using Clean Architecture and Test-Driven Development principles.

## 🌟 About

This Pokédex app showcases the implementation of Clean Architecture in Flutter, providing a robust, maintainable, and testable codebase. The application fetches Pokémon data from an external API and presents it in a user-friendly interface with features like Pokémon listing, detailed information, and favorites management.

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a clear separation of concerns:

- **Domain Layer**: Contains business logic, entities, and use cases independent of any framework
- **Data Layer**: Implements repositories and handles data sources (API, local storage)
- **Presentation Layer**: Manages UI state and user interactions
- **UI Layer**: Contains all the Flutter widgets and screens
- **Main Layer**: Handles dependency injection and application setup

## 🛠️ Tech Stack

- **Flutter**: UI framework
- **Dart**: Programming language
- **HTTP**: Network requests
- **Hive**: Local storage for favorites
- **Equatable**: Value equality
- **Carousel Slider**: UI component for image galleries

## 🧪 Testing

The project follows Test-Driven Development (TDD) practices with:

- **Unit Tests**: Testing individual components in isolation
- **Integration Tests**: Testing component interactions
- **Mockito**: Mocking dependencies for testing
- **Faker**: Generating test data

## 🌟 Features

- Browse the complete Pokédex with pagination
- View detailed information about each Pokémon
- Add Pokémon to favorites
- View your favorite Pokémon list
- Clean and intuitive user interface

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=2.18.5 <3.0.0)
- Dart SDK
- Android Studio / VS Code
- Android/iOS emulator or physical device

### Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## 📂 Project Structure

```
lib/
├── data/           # Data layer implementation
│   ├── http/       # HTTP client implementation
│   ├── models/     # Data models
│   └── usecases/   # Use case implementations
├── domain/         # Business logic and entities
│   ├── entities/   # Domain entities
│   ├── helpers/    # Domain helper classes
│   └── usecases/   # Use case interfaces
├── infra/          # Infrastructure layer
├── main/           # Application entry point and factories
│   └── factories/  # Factory methods for dependency injection
├── presentation/   # Presentation layer
│   ├── helpers/    # Presentation helpers
│   └── presenters/ # Presenters for UI
└── ui/             # UI components and screens
```

## 🔍 Development Approach

This app is developed with a focus on:

- **Clean Code**: Following SOLID principles and clean coding practices
- **Testability**: Ensuring all components are easily testable
- **Maintainability**: Creating a codebase that's easy to maintain and extend
- **Native Implementation**: Minimizing external dependencies where possible
