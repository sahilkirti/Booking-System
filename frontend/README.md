# Booking System Frontend

Flutter frontend for the Meeting Room Booking System.

## Setup

1. Make sure Flutter is installed and set up on your system.

2. Install dependencies:
   ```
   flutter pub get
   ```

3. Run the app:
   ```
   flutter run -d chrome  # For web
   flutter run            # For default connected device
   ```

## Features

### Main Screen
- Calendar view for date selection
- Time pickers for start and end times
- Button to create new bookings
- List of all existing bookings

### Booking Details Screen
- Detailed view of a specific booking
- Information about date, time, duration
- Option to delete the booking

## Usage

1. **Create a Booking:**
   - Select a date from the calendar
   - Set start and end times using the time pickers
   - Click "Create Booking" button

2. **View Booking Details:**
   - Click on any booking in the list to view its details

3. **Delete a Booking:**
   - Click the delete icon on the booking list item, or
   - Go to the booking details screen and click the delete button

## Navigation

The app uses URL-based routing with go_router, which means:
- The home page is accessible at "/"
- Individual booking details are accessible at "/booking/:id"
- Browser navigation buttons (back/forward) work correctly

## Project Structure

- **lib/**
  - **main.dart** - Entry point and router configuration
  - **models/** - Data models
  - **screens/** - UI screens
  - **services/** - API service calls

## Technologies Used

- Flutter
- Dart
- HTTP package for API calls
- Table Calendar for calendar display
- Go Router for navigation
- Flutter DateTime Picker for time selection
