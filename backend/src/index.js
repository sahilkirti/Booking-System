const express = require('express');
const cors = require('cors');
const bookingRoutes = require('./routes/bookingRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Root path handler
app.get('/', (req, res) => {
  res.json({
    status: 'success',
    message: 'Booking API is running',
    endpoints: {
      getAllBookings: '/api/bookings',
      getBookingById: '/api/bookings/:id',
      createBooking: 'POST /api/bookings',
      deleteBooking: 'DELETE /api/bookings/:id'
    }
  });
});

// Routes
app.use('/api/bookings', bookingRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    status: 'error',
    message: err.message || 'Something went wrong!'
  });
});

// Start server
// For local development:
if (process.env.NODE_ENV !== 'production') {
  app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });
}

// Export the Express API for Vercel serverless function
module.exports = app; 