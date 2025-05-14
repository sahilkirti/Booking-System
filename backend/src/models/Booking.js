const { v4: uuidv4 } = require('uuid');

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

    if (!booking.startTime) {
      errors.push('startTime is required');
    }

    if (!booking.endTime) {
      errors.push('endTime is required');
    }

    try {
      const startDate = new Date(booking.startTime);
      const endDate = new Date(booking.endTime);
      
      if (isNaN(startDate.getTime())) {
        errors.push('startTime must be a valid date');
      }
      
      if (isNaN(endDate.getTime())) {
        errors.push('endTime must be a valid date');
      }
      
      if (startDate >= endDate) {
        errors.push('startTime must be before endTime');
      }
    } catch (error) {
      errors.push('Invalid date format');
    }

    return errors;
  }
}

module.exports = Booking; 