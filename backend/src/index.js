const express = require('express');
const cors = require('cors');
const bookingRoutes = require('./routes/bookingRoutes');

const app = express();

// Middleware
app.use(cors({
  origin: ['https://booking-system-coral.vercel.app', 'https://booking-system-frontend.netlify.app', '*'],
  methods: ['GET', 'POST', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
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

// Local development server
if (process.env.NODE_ENV !== 'production') {
  const PORT = process.env.PORT || 3000;
  app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });
}

// Export the Express app for Vercel
module.exports = app; 