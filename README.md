# QuiZi App

QuiZi is a mobile application built with Flutter and Firebase, designed to cater to both quiz creators and participants. The app features two types of quizzes: static quizzes predefined by administrators and dynamic quizzes that users can create themselves.

## Tech Stack

- **Flutter:** Frontend framework for building native interfaces on Android and iOS platforms.
- **Firebase:** Backend services for authentication, real-time database, and cloud storage.

## User Roles and Features

### Quiz Creators

As a quiz creator, you have the ability to set up quizzes and manage quiz-related activities.

**Features:**
- **Create Static Quizzes:** Predefine quizzes with set questions and answers.
- **Create Dynamic Quizzes:** Design quizzes where questions can be added or modified by participants.
- **Manage Quizzes:** Edit existing quizzes, view participant responses, and monitor quiz progress.
- **Generate Quiz IDs:** Create unique quiz IDs and passwords for dynamic quizzes.

### Quiz Participants

Participants engage with quizzes created by others and join dynamic quizzes using unique identifiers.

**Features:**
- **Join Dynamic Quizzes:** Enter specific quiz IDs and passwords provided by creators to participate.
- **View Quiz Information:** Access details about upcoming quizzes, including topics and timings.
- **Submit Answers:** Answer quiz questions and view results upon completion.

## Getting Started

To run QuiZi locally or deploy it:

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```bash
   cd quizi-app
   ```
3. Set up Firebase project and obtain configuration files (`google-services.json` for Android or `GoogleService-Info.plist` for iOS).
4. Install dependencies:
   ```bash
   flutter pub get
   ```
5. Run the application:
   ```bash
   flutter run
   ```
6. Access the application on your emulator or connected device.

