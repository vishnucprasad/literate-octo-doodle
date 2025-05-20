import 'package:aaraadhya_temple_dashboard/core/enums/booking_status.dart';
import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/core/query_condition.dart';
import 'package:aaraadhya_temple_dashboard/data/models/payment/payment.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/booking_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingRepositoryImpl implements BookingRepository {
  final DbDatasource _dbDatasource;

  BookingRepositoryImpl(this._dbDatasource);

  @override
  Future<List<Payment>> getPayments({
    required String userId,
    required DateTime date,
    BookingStatus? status,
  }) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final docs = await _dbDatasource.queryCollection(
      'bookings',
      conditions: [
        QueryCondition(
          field: "createdAt",
          operator: '>=',
          value: Timestamp.fromDate(startOfDay),
        ),
        QueryCondition(
          field: "createdAt",
          operator: '<',
          value: Timestamp.fromDate(endOfDay),
        ),
        if (status != null) ...[
          QueryCondition(field: "status", operator: '==', value: status.name),
        ],
      ],
      orderBy: 'createdAt',
    );

    final payments = await Future.wait(
      docs.map((doc) async {
        final user = await _dbDatasource.getDocument('users', doc["userId"]);
        return {
          ...doc,
          "devotee": user,
          "createdAt":
              (doc['createdAt'] as Timestamp).toDate().toIso8601String(),
        };
      }),
    );

    return payments.map((payment) {
      return Payment.fromJson(payment);
    }).toList();
  }

  @override
  Future<void> updateBookingStatus({
    required String bookingId,
    required BookingStatus status,
  }) async {
    await _dbDatasource.updateDocument('bookings', bookingId, {
      "status": status.name,
    });
  }
}
