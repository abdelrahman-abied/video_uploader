
# Flutter Video Upload Example with Retrofit & Dio

This repository contains the source code for the article "Mastering Video Uploads in Flutter with Retrofit and Dio". It demonstrates how to build a Flutter application that allows users to pick a video from their device gallery, preview it within the app, and upload it to a server using a `multipart/form-data` request.

The project showcases a clean architecture using modern libraries for networking, state management, and UI feedback.

![Demo GIF Placeholder](https://via.placeholder.com/350x650.gif?text=App+Demo+Here)
*(A GIF of the running application would be placed here)*

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

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You must have the Flutter SDK installed on your machine. For instructions, see the [official Flutter documentation](https://flutter.dev/docs/get-started/install).

### Installation & Setup

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/abdelrahman-abied/video_uploader.git
    cd flutter-video-upload-example
    ```

2.  **Install dependencies:**
    Run the following command to fetch all the required packages listed in `pubspec.yaml`.
    ```sh
    flutter pub get
    ```

3.  **Run the code generator:**
    This project uses `retrofit_generator` and `json_serializable` to generate necessary networking and model files. Run the `build_runner` to create these files (`.g.dart`).
    ```sh
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
    *Note: If you make any changes to the API client (`api_client.dart`) or response models (`response.dart`), you will need to run this command again.*

4.  **Run the application:**
    Connect a device or start an emulator and run the app.
    ```sh
    flutter run
    ```

## 📂 Project Structure

The project is organized into logical files to maintain clarity and separation of concerns.

```
lib/
├── api_client.dart       # Retrofit API client definition
├── api_client.g.dart     # Generated Retrofit client implementation
├── main.dart             # The main application entry point
├── response.dart         # The data model for the API response
├── response.g.dart       # Generated JSON serialization logic for the response model
└── video_upload_screen.dart # The main UI screen for picking and uploading videos
```

-   **`video_upload_screen.dart`**: Contains the `StatefulWidget` that manages the UI, state, and user interactions.
-   **`api_client.dart`**: Defines the abstract class for the Retrofit client, specifying the API endpoints and request methods.
-   **`response.dart`**: Defines the `FileResponse` class, which models the expected JSON response from the server upon a successful upload.

## 🌐 About the API

This example uses the free `platzi/fake-api-platzi` for demonstration purposes. The file upload endpoint is located at `https://api.escuelajs.co/api/v1/files/upload`. This is a public API meant for testing and may have usage limits or be subject to change. For a production application, you would replace the `baseUrl` in `api_client.dart` with your own server's URL.
