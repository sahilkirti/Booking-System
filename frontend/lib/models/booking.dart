class Booking {
  final String id;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime createdAt;

  Booking({
    required this.id,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['userId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }
} 