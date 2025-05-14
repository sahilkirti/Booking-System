import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/booking.dart';

class BookingService {
  // Replace this with your actual deployed Vercel API URL
  // For example: static const String baseUrl = 'https://booking-api.vercel.app/api';
  // For local development, use: http://localhost:3000/api
  static const String baseUrl = 'https://booking-api.vercel.app/api';

  Future<List<Booking>> getAllBookings() async {
    final response = await http.get(Uri.parse('$baseUrl/bookings'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Booking.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  Future<Booking> getBookingById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/bookings/$id'));
    if (response.statusCode == 200) {
      return Booking.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load booking details');
    }
  }

  Future<Booking> createBooking(Booking booking) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(booking.toJson()),
    );

    if (response.statusCode == 201) {
      return Booking.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to create booking');
    }
  }

  Future<void> deleteBooking(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/bookings/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete booking');
    }
  }
} 