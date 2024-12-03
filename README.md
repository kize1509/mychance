
---


# MyChance Backend

This repository contains the **backend** code for the **MyChance** hybrid mobile application. The app is currently in its beta phase and is described as an "Investor TikTok," enabling seamless interaction between entrepreneurs and investors.

The backend is built using **Express.js**, providing a robust and scalable API for powering the application.

## **Features**

- **User Authentication**: Secure JWT-based authentication system (not yet available).
- **Video Upload and Management**: Handles video uploads, processing, and storage.
- **API for Data Operations**: Serves data to the Flutter-based frontend, including user profiles, video feeds, and interactions.
- **Scalability**: Designed to handle large-scale usage efficiently.

## **Getting Started**

### Prerequisites
- Node.js 18+ installed
- MySQL database
- A running instance of the [MyChance Frontend](https://github.com/kize1509/frontend-mychance.git)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/kize1509/backend-mychance.git

    Navigate to the project directory:

cd backend-mychance

Install dependencies:

npm install

Start the production server:

    npm start


---



# MyChance Frontend

This repository contains the **frontend** code for the **MyChance** hybrid mobile application. The app is currently in its beta phase and is described as an "Investor TikTok," designed to revolutionize the way entrepreneurs and investors connect.

The frontend is built using **Dart** with **Flutter**, ensuring seamless and responsive user experiences across both Android and iOS platforms.

## **Features**

- **User Registration and Authentication**: Allows users to sign up and log in securely.
- **Video Feed**: Swipeable video feed resembling TikTok for entrepreneurs to pitch their ideas and investors to discover opportunities.
- **Interactive UI**: Modern and intuitive design for effortless navigation.
- **Hybrid App Compatibility**: Works seamlessly on both Android and iOS platforms.

## **Getting Started**

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed
- Dart 2.12.0 or newer
- A running instance of the [MyChance Backend](https://github.com/kize1509/backend-mychance.git)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/kize1509/frontend-mychance.git

    Navigate to the project directory:

cd frontend-mychance

Install dependencies:

flutter pub get

Run the app:

    flutter run

Environment Configuration

Configure the API base URL and other constants in the lib/constants/ directory before running the application.

###  Home page, swipeable video feed
![image](https://github.com/user-attachments/assets/c79e0854-9111-493e-8bb9-110859405e5f)

###  Chat screen
![image](https://github.com/user-attachments/assets/da33197e-5022-4135-9e19-c680bf6fe7a7)

###  List of trending projects
![image](https://github.com/user-attachments/assets/aa8189aa-3cca-4d5e-85d4-e96fd5b6e745)

###  List of  currently most funded projects
![image](https://github.com/user-attachments/assets/da49a988-f31f-4688-a940-57372920081e)

### Project profie
![image](https://github.com/user-attachments/assets/238040d5-0391-4309-8372-548fdac062cf)

### Project upload screen
![image](https://github.com/user-attachments/assets/10ca2bf4-294c-4917-8521-fc4974b48059)




