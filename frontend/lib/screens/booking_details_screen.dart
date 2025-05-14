import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';
import 'package:go_router/go_router.dart';

class BookingDetailsScreen extends StatefulWidget {
  final String bookingId;

  const BookingDetailsScreen({super.key, required this.bookingId});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final BookingService _bookingService = BookingService();
  bool _isLoading = true;
  Booking? _booking;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBookingDetails();
  }

  Future<void> _loadBookingDetails() async {
    setState(() => _isLoading = true);
    try {
      final booking = await _bookingService.getBookingById(widget.bookingId);
      setState(() {
        _booking = booking;
        _error = null;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        actions: [
          if (_booking != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: _confirmDelete,
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Future<void> _confirmDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
    
    if (confirm == true) {
      try {
        await _bookingService.deleteBooking(_booking!.id);
        if (!mounted) return;
        
        // Use GoRouter to navigate back to home
        context.go('/');
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking deleted successfully')),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting booking: $e')),
        );
      }
    }
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error', style: TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadBookingDetails,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_booking == null) {
      return const Center(child: Text('Booking not found'));
    }

    // Format dates nicely
    final dateFormat = '${_booking!.startTime.day}/${_booking!.startTime.month}/${_booking!.startTime.year}';
    final startTimeFormat = '${_booking!.startTime.hour}:${_booking!.startTime.minute.toString().padLeft(2, '0')}';
    final endTimeFormat = '${_booking!.endTime.hour}:${_booking!.endTime.minute.toString().padLeft(2, '0')}';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Booking Information',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Divider(),
              _infoRow('Booking ID', _booking!.id),
              _infoRow('Date', dateFormat),
              _infoRow('Time', '$startTimeFormat - $endTimeFormat'),
              _infoRow('Duration', _calculateDuration()),
              _infoRow('User ID', _booking!.userId),
              _infoRow('Created', '${_booking!.createdAt.day}/${_booking!.createdAt.month}/${_booking!.createdAt.year}'),
              const SizedBox(height: 24),
              Divider(),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: _confirmDelete,
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text('Delete Booking', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _calculateDuration() {
    final difference = _booking!.endTime.difference(_booking!.startTime);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    
    if (hours > 0) {
      return '$hours hr${hours > 1 ? 's' : ''} ${minutes > 0 ? '$minutes min' : ''}';
    } else {
      return '$minutes min';
    }
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 