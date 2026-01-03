# CoTravel

A personalized, collaborative travel planning platform built with Flutter.

## Features

- **Authentication**: Login, signup, forgot password
- **Onboarding Quiz**: Personalized recommendations based on travel preferences
- **Trip Planning**: Create and manage multi-city trips
- **Itinerary Builder**: Add cities, activities, reorder items
- **Smart Suggestions**: Alternative activities when issues occur
- **Budget Tracking**: Cost breakdown with visual charts
- **Food & Transport**: Recommendations per city
- **Group Collaboration**: Invite friends with roles
- **Calendar/Timeline**: Drag-and-drop scheduling
- **Snap Memories**: Photo gallery with notes

## Architecture

```
lib/
├── core/
│   ├── theme/          # App theme and colors
│   ├── widgets/        # Reusable UI components
│   └── utils/          # Helper functions
├── features/
│   ├── auth/           # Authentication screens
│   ├── onboarding/     # Quiz and setup
│   ├── dashboard/      # Home screen
│   ├── trip/           # Trip management
│   ├── itinerary/      # Itinerary builder
│   ├── budget/         # Cost tracking
│   ├── food_transport/ # Recommendations
│   ├── collaboration/  # Group features
│   ├── memories/       # Photo features
│   └── profile/        # User settings
├── models/             # Data models
├── services/           # Mock services
├── routes/             # Navigation
└── main.dart
```

## Design System

- **Colors**: Primary (#4F46E5), Secondary (#22C55E), Accent (#F59E0B)
- **Typography**: Inter/Poppins with Material 3 text themes
- **Components**: Custom cards, buttons, form fields

## Personalization Logic

1. **Quiz Collection**: Travel type, budget, pace, interests, food preference
2. **Recommendation Engine**:
   - Cities: Match interests, filter by budget/cost index
   - Activities: Score by type match, cost fit, duration
   - Food: Filter by preference and cuisine
3. **Scoring**: Weighted algorithm for relevance

## Alternative Suggestion Algorithm

1. **Issue Detection**: User reports crowd/weather/unavailable
2. **Alternative Search**: Same city, similar type, better conditions
3. **Scoring**: Distance penalty, similarity bonus, issue-specific adjustments
4. **Presentation**: Clear reason explanation

## Getting Started

1. Install Flutter SDK
2. Clone repository
3. Run `flutter pub get`
4. Run `flutter run`

## Database

The app uses **Firebase** as the backend database:
- **Firebase Auth**: User authentication
- **Cloud Firestore**: Data storage
- **Firebase Storage**: File uploads (memories, images)

## Setup Firebase

1. Create a Firebase project at https://console.firebase.google.com/
2. Enable Authentication, Firestore, and Storage
3. Add Flutter app to Firebase project
4. Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
5. Place config files in respective platform directories
6. Run `flutterfire configure` to generate Firebase options

## Mock Data

For development/demo, mock data is used when Firebase is not configured. Services simulate API delays and responses.

## Hackathon Ready

- Clean, scalable architecture
- Responsive design
- Smooth animations
- Demo-friendly with sample data
- Easy to extend with real backend
