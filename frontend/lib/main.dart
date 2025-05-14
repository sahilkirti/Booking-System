import 'package:flutter/material.dart';
import 'screens/booking_screen.dart';
import 'screens/booking_details_screen.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const BookingScreen(),
        ),
        GoRoute(
          path: '/booking/:id',
          builder: (context, state) {
            final bookingId = state.pathParameters['id']!;
            return BookingDetailsScreen(bookingId: bookingId);
          },
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Booking System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
