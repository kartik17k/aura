# Event Entry System for AURA-25 (Mobile App)

Welcome to the **Event Entry System** for AURA-25, a cutting-edge mobile solution built for KLS GIT's special event. Our goal is to enhance event security, improve efficiency, and provide real-time data insights for event organizers, all through a seamless mobile experience. This project leverages **Flutter** for cross-platform mobile development and **Firebase** for backend services.

## 🚀 Project Overview

Our mobile app aims to modernize event management by implementing an intuitive, secure, and efficient entry system for attendees, staff, and VIPs. With real-time tracking, enhanced security, and instant data analytics, this solution provides event organizers with the tools they need to run a successful event with ease.

## 🎯 Key Features

- **Digital Entry/Re-entry/Exit Management**
  - Contactless entry system using QR codes
  - Efficient handling of student, staff, and VIP access
  - Real-time tracking of entries, re-entries, and exits

- **Enhanced Security**
  - Unique code generation for each attendee
  - Advanced authentication to prevent fake or duplicate entries
  - Real-time monitoring and alerts for potential security threats

- **Real-time Data and Analytics**
  - Live event capacity tracking
  - Attendee flow analysis
  - Customizable data insights for event organizers

- **User-friendly Interfaces**
  - Intuitive and responsive mobile app for both Android and iOS
  - Easy-to-use mobile management console for event staff

## 🛠️ Technical Stack

- **Mobile App**: Flutter
- **Backend**: Firebase (Firestore, Authentication, Storage)

## 🎯 Project Goals

- Develop a robust and scalable mobile entry system prototype.
- Reduce entry processing time by 50% through seamless app performance.
- Improve overall event security by implementing multi-factor authentication.
- Provide real-time insights to event organizers, enhancing decision-making.


## 🛠️ Setup Instructions

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli) installed and configured
- A Firebase project with Firestore and Authentication enabled

### Step-by-Step Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/kartik17k/aura
   cd aura
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
   - Create a new Firebase project.
   - Enable Firestore and Authentication (Email/Password, Google Sign-In).
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files and place them in the respective platform folders.

4. **Run the App**
   ```bash
   flutter run
   ```

5. **Configure Firebase Firestore Rules**
   - Go to the Firebase console -> Firestore -> Rules and ensure you have the appropriate read/write permissions for your app.

## 👥 Authors

- **Kartik** - [GitHub](https://github.com/kartik17k)
- **Pralhad** - [GitHub](https://github.com/Pralha17)
- **Vinithkumar** - [GitHub](https://github.com/Vinith11)
- **Shreyas Huddar** - [GitHub](https://github.com/shreyashuddar29)


## 📚 Resources

- **Flutter Documentation**: [flutter.dev/docs](https://flutter.dev/docs)
---

## 🎉 Acknowledgements

- Special thanks to all contributors and testers who have helped improve this project.

