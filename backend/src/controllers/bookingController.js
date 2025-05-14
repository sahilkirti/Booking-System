const BookingService = require('../services/bookingService');

class BookingController {
  static async getAllBookings(req, res) {
    try {
      const bookings = BookingService.getAllBookings();
      res.json({
        status: 'success',
        data: bookings
      });
    } catch (error) {
      res.status(500).json({
        status: 'error',
        message: error.message
      });
    }
  }

  static async getBookingById(req, res) {
    try {
      const booking = BookingService.getBookingById(req.params.id);
      if (!booking) {
        return res.status(404).json({
          status: 'error',
          message: 'Booking not found'
        });
      }
      res.json({
        status: 'success',
        data: booking
      });
    } catch (error) {
      res.status(500).json({
        status: 'error',
        message: error.message
      });
    }
  }

  static async createBooking(req, res) {
    try {
      const booking = BookingService.createBooking(req.body);
      res.status(201).json({
        status: 'success',
        data: booking
      });
    } catch (error) {
      res.status(400).json({
        status: 'error',
        message: error.message
      });
    }
  }

  static async deleteBooking(req, res) {
    try {
      const booking = BookingService.deleteBooking(req.params.id);
      res.json({
        status: 'success',
        data: booking
      });
    } catch (error) {
      if (error.message === 'Booking not found') {
        return res.status(404).json({
          status: 'error',
          message: error.message
        });
      }
      res.status(500).json({
        status: 'error',
        message: error.message
      });
    }
  }
}

module.exports = BookingController; 