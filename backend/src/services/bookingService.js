const Booking = require('../models/Booking');

// In a real application with a database, you would use that instead
// For this demo, we'll use a simple in-memory array with some sample data
const bookings = [
  {
    id: "booking-123",
    userId: "user-123",
    startTime: "2025-03-01T10:00:00Z",
    endTime: "2025-03-01T11:00:00Z",
    createdAt: "2023-05-01T12:00:00Z"
  },
  {
    id: "booking-456",
    userId: "user-456",
    startTime: "2025-03-02T14:00:00Z",
    endTime: "2025-03-02T16:00:00Z",
    createdAt: "2023-05-01T13:00:00Z"
  }
];

class BookingService {
  static getAllBookings() {
    return [...bookings];
  }

  static getBookingById(id) {
    return bookings.find(booking => booking.id === id);
  }

  static createBooking(bookingData) {
    const errors = Booking.validate(bookingData);
    if (errors.length > 0) {
      throw new Error(errors.join(', '));
    }

    const newBooking = new Booking(
      bookingData.userId,
      bookingData.startTime,
      bookingData.endTime
    );

    bookings.push(newBooking);
    return newBooking;
  }

  static deleteBooking(id) {
    const index = bookings.findIndex(booking => booking.id === id);
    if (index === -1) {
      throw new Error('Booking not found');
    }
    const deleted = bookings[index];
    bookings.splice(index, 1);
    return deleted;
  }
}

module.exports = BookingService; 