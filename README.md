# inditab_task_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Instagram-like Story Feature in Flutter

## Overview

This Flutter application replicates the Instagram-like story feature, allowing users to view stories from various users fetched from a REST API. Users can navigate through stories, interact with them, and enjoy a seamless media experience.

## Features

- Fetches story data from an external API.
- Displays a list of users with their profile pictures.
- Allows users to view and interact with stories in a full-screen mode.
- Supports navigation through stories via swipe gestures like:
  - Tap Right: To play next story.
  - Tap Left: To play previous story.
  - Horizontal Drag: To change user.
  - Vertical Drag Down: To go back home. 
- Progress indicator showing the current story's playback status.

## Dependencies
- **http** - For making HTTP request and fetch data from API.
- **video_player** - For handling video playback.
- **google_fonts** - For changing fontfamily.
- **loading_indicator** - For showing loading indicator until the data is loaded.
- **flutter_cache_manager** - For storing and retriving data in cache memory.

## Implementation Details
1. **Data Models**: Defined classes to represent the structure of users and stories based on the API response.
2. **API Integration**: Implemented methods to fetch and parse data from the API.
3. **User List**: Created a horizontal ListView to display users' profile pictures.
4. **Story Display**: Developed a full-screen view for displaying stories with overlay text and descriptions.
5. **Navigation**: Enabled swipe gestures and tap interactions for seamless navigation between stories.

# Installation
1. Clone the repository:
```
git clone https://github.com/your-username/your-repo-name.git
```
2. Navigate to the Flutter project directory:
```
cd inditab_task_flutter
```
3. Install dependencies:
```
flutter pub get
```
4. Run the application:
```
flutter run
```

# License
This project is licensed under the MIT License. See the [LICENSE](https://opensource.org/license/mit) file for details.



# Screenshots:

https://github.com/user-attachments/assets/fa9d49c2-43f1-4cda-aa78-7623f7f961aa

![Screen_shot1](https://github.com/user-attachments/assets/167a62a1-1385-49a8-a462-e10e79fbe07c)

![Screen_shot2](https://github.com/user-attachments/assets/2b661209-a2d6-4b77-b2e7-70a5b7df2eb6)


