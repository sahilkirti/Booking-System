# Meeting Room Booking System

A full-stack application for booking meeting rooms, built with Flutter for the frontend and Node.js/Express for the backend.

## Live Demo

- Live Application: [https://booking-system-coral.vercel.app](https://booking-system-coral.vercel.app)
- API Endpoint: [https://booking-system-coral.vercel.app/api/bookings](https://booking-system-coral.vercel.app/api/bookings)
- Deployment Date: May 14, 2024

## Features

- View calendar to select booking dates
- Book meeting rooms for specific time slots
- View all existing bookings
- See detailed information for individual bookings
- Delete bookings
- Conflict detection to prevent double bookings
- RESTful API with proper error handling

## Tech Stack

### Frontend
- Flutter (Dart)
- Flutter packages:
  - http: For API calls
  - table_calendar: For calendar UI
  - flutter_datetime_picker_plus: For time selection
  - go_router: For URL-based navigation
  - provider: For state management

### Backend
- Node.js
- Express.js
- Express Validator for input validation
- In-memory data storage

## Project Structure

```
├── backend/
│   ├── src/
│   │   ├── controllers/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── services/
│   │   ├── utils/
│   │   └── index.js
│   ├── package.json
│   └── ...
└── frontend/
    ├── lib/
    │   ├── models/
    │   ├── screens/
    │   ├── services/
    │   └── main.dart
    └── ...
```

## Setup Instructions

### Prerequisites
- Node.js (v14+)
- npm or yarn
- Flutter (latest stable version)
- Git

### Backend Setup

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/booking-system.git
   cd booking-system
   ```

2. Navigate to the backend directory and install dependencies:
   ```
   cd backend
   npm install
   ```

3. Start the backend server:
   ```
   npm start
   ```
   The server will run on http://localhost:3000 by default.

### Frontend Setup

1. Navigate to the frontend directory:
   ```
   cd ../frontend
   ```

2. Install Flutter dependencies:
   ```
   flutter pub get
   ```

3. Run the Flutter app:
   ```
   flutter run -d chrome
   ```
   For other platforms, replace "chrome" with the appropriate device ID.

## API Documentation

### Endpoints

#### Bookings

- **GET /api/bookings**
  - Description: Retrieve all bookings
  - Response: Array of booking objects
  
- **GET /api/bookings/:id**
  - Description: Retrieve booking by ID
  - Parameters: id - Booking ID
  - Response: Booking object
  
- **POST /api/bookings**
  - Description: Create a new booking
  - Request Body:
    ```json
    {
      "userId": "user-123",
      "startTime": "2025-03-01T10:00:00Z",
      "endTime": "2025-03-01T11:00:00Z"
    }
    ```
  - Response: Created booking object
  
- **DELETE /api/bookings/:id**
  - Description: Delete a booking
  - Parameters: id - Booking ID
  - Response: Deleted booking object

### Error Handling

The API returns appropriate HTTP status codes:
- 200: Success
- 201: Resource created
- 400: Bad request (invalid input)
- 404: Resource not found
- 409: Conflict (e.g., booking time conflict)
- 500: Server error

## Future Improvements

- User authentication and authorization
- Multiple meeting rooms support
- Recurring bookings
- Email notifications
- Mobile-responsive design improvements
- Persistent database storage
- Unit and integration tests

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Built as part of a coding assignment
- Thanks to the Flutter and Node.js communities for their excellent documentation 