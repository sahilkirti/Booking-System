# Booking System Backend

The Node.js/Express backend for the Meeting Room Booking System.

## Setup

1. Install dependencies:
   ```
   npm install
   ```

2. Start the server:
   ```
   npm start
   ```
   
   For development with auto-reload:
   ```
   npm run dev
   ```

## API Endpoints

### Bookings

#### GET /api/bookings
Retrieves all bookings.

**Response:**
```json
{
  "status": "success",
  "data": [
    {
      "id": "booking-123",
      "userId": "user-123",
      "startTime": "2025-03-01T10:00:00Z",
      "endTime": "2025-03-01T11:00:00Z",
      "createdAt": "2023-05-01T12:00:00Z"
    }
  ]
}
```

#### GET /api/bookings/:id
Retrieves a specific booking by ID.

**Parameters:**
- `id`: The booking ID

**Response:**
```json
{
  "status": "success",
  "data": {
    "id": "booking-123",
    "userId": "user-123",
    "startTime": "2025-03-01T10:00:00Z",
    "endTime": "2025-03-01T11:00:00Z",
    "createdAt": "2023-05-01T12:00:00Z"
  }
}
```

#### POST /api/bookings
Creates a new booking.

**Request Body:**
```json
{
  "userId": "user-123",
  "startTime": "2025-03-01T10:00:00Z",
  "endTime": "2025-03-01T11:00:00Z"
}
```

**Response:**
```json
{
  "status": "success",
  "data": {
    "id": "booking-123",
    "userId": "user-123",
    "startTime": "2025-03-01T10:00:00Z",
    "endTime": "2025-03-01T11:00:00Z",
    "createdAt": "2023-05-01T12:00:00Z"
  }
}
```

#### DELETE /api/bookings/:id
Deletes a booking.

**Parameters:**
- `id`: The booking ID

**Response:**
```json
{
  "status": "success",
  "data": {
    "id": "booking-123",
    "userId": "user-123",
    "startTime": "2025-03-01T10:00:00Z",
    "endTime": "2025-03-01T11:00:00Z",
    "createdAt": "2023-05-01T12:00:00Z"
  }
}
```

## Error Handling

The API returns appropriate HTTP status codes and error messages:

**Example Error Response:**
```json
{
  "status": "error",
  "message": "Booking not found"
}
```

## Project Structure

- **controllers/** - Request handlers
- **services/** - Business logic
- **routes/** - API routes definition
- **models/** - Data models
- **utils/** - Utility functions

## Technologies Used

- Node.js
- Express.js
- Express Validator 