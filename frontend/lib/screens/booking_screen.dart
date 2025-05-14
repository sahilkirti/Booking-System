import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';
import 'package:go_router/go_router.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final BookingService _bookingService = BookingService();
  List<Booking> _bookings = [];
  DateTime _selectedDay = DateTime.now();
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now().add(const Duration(hours: 1));
  bool _isLoading = false;
  bool _isFirstLoad = true;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isFirstLoad) {
      _loadBookings();
    }
  }

  Future<void> _loadBookings() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    try {
      final bookings = await _bookingService.getAllBookings();
      setState(() {
        _bookings = bookings;
        _isFirstLoad = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading bookings: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _createBooking() async {
    try {
      final booking = Booking(
        id: '',
        userId: 'user-123', // In a real app, this would come from authentication
        startTime: _startTime,
        endTime: _endTime,
        createdAt: DateTime.now(),
      );

      await _bookingService.createBooking(booking);
      await _loadBookings();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking created successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating booking: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Room Booking'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TableCalendar(
                    firstDay: DateTime.now(),
                    lastDay: DateTime.now().add(const Duration(days: 365)),
                    focusedDay: _selectedDay,
                    selectedDayPredicate: (day) =>
                        isSameDay(_selectedDay, day),
                    calendarFormat: _calendarFormat,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                    },
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _startTime = DateTime(
                          selectedDay.year,
                          selectedDay.month,
                          selectedDay.day,
                          _startTime.hour,
                          _startTime.minute,
                        );
                        _endTime = DateTime(
                          selectedDay.year,
                          selectedDay.month,
                          selectedDay.day,
                          _endTime.hour,
                          _endTime.minute,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            DatePicker.showTimePicker(
                              context,
                              showSecondsColumn: false,
                              onConfirm: (time) {
                                setState(() => _startTime = time);
                              },
                            );
                          },
                          child: Text(
                            'Start: ${_startTime.hour}:${_startTime.minute.toString().padLeft(2, '0')}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            DatePicker.showTimePicker(
                              context,
                              showSecondsColumn: false,
                              onConfirm: (time) {
                                setState(() => _endTime = time);
                              },
                            );
                          },
                          child: Text(
                            'End: ${_endTime.hour}:${_endTime.minute.toString().padLeft(2, '0')}',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _createBooking,
                    child: const Text('Create Booking'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your Bookings:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _bookings.length,
                    itemBuilder: (context, index) {
                      final booking = _bookings[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          title: Text(
                            '${booking.startTime.hour}:${booking.startTime.minute.toString().padLeft(2, '0')} - ${booking.endTime.hour}:${booking.endTime.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                '${booking.startTime.day}/${booking.startTime.month}/${booking.startTime.year}',
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Tap to view details',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.info, color: Colors.blue),
                                onPressed: () async {
                                  context.push('/booking/${booking.id}');
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  try {
                                    await _bookingService.deleteBooking(booking.id);
                                    await _loadBookings();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Booking deleted successfully'),
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Error deleting booking: $e'),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          onTap: () async {
                            context.push('/booking/${booking.id}');
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
} 