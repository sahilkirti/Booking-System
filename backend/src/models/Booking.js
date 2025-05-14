const { v4: uuidv4 } = require('uuid');
const moment = require('moment');

class Booking {
  constructor(userId, startTime, endTime) {
    this.id = uuidv4();
    this.userId = userId;
    this.startTime = startTime;
    this.endTime = endTime;
    this.createdAt = new Date().toISOString();
  }

  static validate(booking) {
    const errors = [];

    if (!booking.userId) {
      errors.push('userId is required');
    }

    if (!booking.startTime || !moment(booking.startTime).isValid()) {
      errors.push('Valid startTime is required');
    }

    if (!booking.endTime || !moment(booking.endTime).isValid()) {
      errors.push('Valid endTime is required');
    }

    if (moment(booking.startTime).isAfter(moment(booking.endTime))) {
      errors.push('startTime must be before endTime');
    }

    // Only check if the booking is not in the past
    if (moment(booking.startTime).isBefore(moment())) {
      errors.push('Cannot book in the past');
    }

    return errors;
  }
}

module.exports = Booking; 