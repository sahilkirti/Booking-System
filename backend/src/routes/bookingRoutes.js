const express = require('express');
const router = express.Router();
const BookingController = require('../controllers/bookingController');
const { body } = require('express-validator');

// Validation middleware
const validateBooking = [
  body('userId').notEmpty().withMessage('userId is required'),
  body('startTime').isISO8601().withMessage('Valid startTime is required'),
  body('endTime').isISO8601().withMessage('Valid endTime is required')
];

// Routes
router.get('/', BookingController.getAllBookings);
router.get('/:id', BookingController.getBookingById);
router.post('/', validateBooking, BookingController.createBooking);
router.delete('/:id', BookingController.deleteBooking);

module.exports = router; 