const Booking = require('../models/Booking');

// In-memory storage for bookings
let bookings = [];

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
    return bookings.splice(index, 1)[0];
  }
}

module.exports = BookingService; 