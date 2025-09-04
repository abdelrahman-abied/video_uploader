# Video Uploader - Clean Architecture

A Flutter application that demonstrates clean architecture principles for video uploading functionality.

## Architecture Overview

This project follows Clean Architecture principles with clear separation of concerns across three main layers:

### 🎨 Presentation Layer (`lib/presentation/`)
- **Screens**: UI screens that handle user interactions
- **Widgets**: Reusable UI components
- **Providers**: State management using Riverpod StateNotifier

### 🧠 Domain Layer (`lib/domain/`)
- **Entities**: Core business objects (e.g., `VideoUploadResult`)
- **Repositories**: Abstract interfaces defining data operations
- **Use Cases**: Business logic and application rules

### 💾 Data Layer (`lib/data/`)
- **Models**: Data transfer objects (DTOs) for API responses
- **Data Sources**: Remote/local data access implementations
- **Repository Implementations**: Concrete implementations of domain repositories

## Project Structure

```
lib/
├── di/
│   └── providers.dart                      # Riverpod providers for DI
├── domain/
│   ├── entities/
│   │   └── video_upload_result.dart       # Core business entity
│   ├── repositories/
│   │   └── video_repository.dart          # Repository interface
│   └── usecases/
│       └── upload_video_usecase.dart      # Business logic
├── data/
│   ├── models/
│   │   └── file_response_model.dart       # API response model
│   ├── datasources/
│   │   └── video_remote_datasource.dart   # API client
│   └── repositories/
│       └── video_repository_impl.dart     # Repository implementation
├── presentation/
│   ├── screens/
│   │   └── video_upload_screen.dart      # Main UI screen
│   ├── widgets/
│   │   └── video_player_widget.dart      # Video player component
│   └── providers/
│       └── video_upload_notifier.dart     # Riverpod StateNotifier
└── main.dart                              # App entry point
```

## Key Features

- **Clean Architecture**: Clear separation between presentation, domain, and data layers
- **Dependency Injection**: Riverpod providers for centralized dependency management
- **Error Handling**: Comprehensive error handling across all layers
- **State Management**: Riverpod StateNotifier for reactive UI updates
- **Video Upload**: Upload videos to external API with progress tracking
- **Video Preview**: Display selected video with preview functionality

## Dependencies

- `dio`: HTTP client for API communication
- `retrofit`: Type-safe HTTP client generation
- `image_picker`: Video selection from device gallery
- `video_player`: Video playback functionality
- `flutter_riverpod`: State management and dependency injection
- `json_annotation`: JSON serialization

## Clean Architecture Benefits

### ✅ **Testability**
- Business logic is isolated in use cases
- Dependencies are injected, making mocking easier
- Each layer can be tested independently

### ✅ **Maintainability**
- Clear separation of concerns
- Single responsibility principle
- Easy to modify or extend functionality

### ✅ **Scalability**
- New features can be added without affecting existing code
- Repository pattern allows easy data source switching
- Use cases can be composed for complex operations

### ✅ **Independence**
- Domain layer is independent of external frameworks
- Business rules are not tied to UI or data implementation
- Easy to change UI framework or data sources

## Usage Example

```dart
// Riverpod provider usage
final videoUploadState = ref.watch(videoUploadNotifierProvider);
final videoUploadNotifier = ref.read(videoUploadNotifierProvider.notifier);

// Trigger actions
await videoUploadNotifier.pickVideo();
await videoUploadNotifier.uploadVideo();

// Access state
if (videoUploadState.hasVideo) {
  // Handle video selection
}
```

## API Integration

The app integrates with the EscuelaJS API for video uploads:
- **Base URL**: `https://api.escuelajs.co/api/v1`
- **Endpoint**: `/files/upload`
- **Method**: POST with multipart form data

## Contributing

When adding new features:
1. Start with domain entities and use cases
2. Implement repository interfaces
3. Create data layer implementations
4. Build UI components
5. Create Riverpod providers for DI and state management


## ✨ Features

-   **Pick Video**: Select a video from the device's gallery using `image_picker`.
-   **Video Preview**: Display the selected video with playback controls using `video_player`.
-   **Multipart Upload**: Upload the video file using a type-safe API client built with `Retrofit` and `Dio`.
-   **UI State Management**: The UI dynamically updates based on the current state (e.g., no video selected, uploading, success, error).
-   **User Feedback**: Provides clear status messages and a progress bar during the upload process.
-   **Error Handling**: Gracefully handles network and server errors, displaying informative messages to the user.

## 🛠️ Technology Stack

-   **Framework**: [Flutter](https://flutter.dev/)
-   **Networking**:
    -   [Dio](https://pub.dev/packages/dio): A powerful HTTP client for making requests.
    -   [Retrofit](https://pub.dev/packages/retrofit): A type-safe HTTP client generator for Dio.
-   **Code Generation**:
    -   [build_runner](https://pub.dev/packages/build_runner): A tool to generate Dart files.
    -   [json_serializable](https://pub.dev/packages/json_serializable): For automatic JSON serialization/deserialization.
-   **UI & Utilities**:
    -   [image_picker](https://pub.dev/packages/image_picker): For picking files from the gallery.
    -   [video_player](https://pub.dev/packages/video_player): For displaying and controlling video playback.


## License

This project is licensed under the MIT License.
The project showcases a clean architecture using modern libraries for networking, state management, and UI feedback.

