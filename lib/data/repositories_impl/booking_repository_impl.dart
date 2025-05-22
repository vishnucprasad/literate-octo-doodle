import 'package:aaraadhya_temple_dashboard/core/enums/booking_status.dart';
import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/booking/booked_pooja_details/booked_pooja_details.dart';
import 'package:aaraadhya_temple_dashboard/data/models/booking/booking.dart';
import 'package:aaraadhya_temple_dashboard/data/models/core/query_condition.dart';
import 'package:aaraadhya_temple_dashboard/data/models/payment/payment.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja_schedule/pooja_schedule.dart';
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

  String getDateOnlyFromISOString(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString);
      // Format as YYYY-MM-DD only
      return "${dateTime.year.toString().padLeft(4, '0')}-"
          "${dateTime.month.toString().padLeft(2, '0')}-"
          "${dateTime.day.toString().padLeft(2, '0')}";
    } catch (e) {
      // If parsing fails, return the original string
      return isoString;
    }
  }

  @override
  Future<List<Booking>> getAllBookings({
    required String userId,
    required DateTime date,
  }) async {
    final docs = await _dbDatasource.queryCollection(
      'bookings',
      conditions: [
        QueryCondition(field: "templeId", operator: "==", value: userId),
        QueryCondition(
          field: "status",
          operator: "==",
          value: BookingStatus.confirmed.name,
        ),
        QueryCondition(
          field: "poojaDates",
          operator: "array-contains",
          value: getDateOnlyFromISOString(date.toIso8601String()),
        ),
      ],
    );

    final bookings = await Future.wait(
      docs.map((doc) async {
        final poojasList = doc['poojas'];
        final List<dynamic> poojasRawList =
            poojasList != null ? (poojasList as List<dynamic>) : [];

        final poojaEntries =
            poojasRawList
                .map((item) {
                  if (item is Map<String, dynamic>) {
                    return item;
                  }
                  return <String, dynamic>{};
                })
                .where(
                  (pooja) =>
                      getDateOnlyFromISOString(pooja['poojaDate']) ==
                      getDateOnlyFromISOString(date.toIso8601String()),
                )
                .toList();

        final List<BookedPoojaDetails> bookedPoojaDetailsList = [];

        for (final poojaEntry in poojaEntries) {
          final poojaId = poojaEntry['poojaId'];
          final scheduleId = poojaEntry['scheduleId'];
          if (poojaId == null || scheduleId == null) continue;

          final poojaDoc = await _dbDatasource.getDocument(
            'poojas',
            poojaId.toString(),
          );

          final scheduleDoc = await _dbDatasource.getDocument(
            'temple-poojas',
            scheduleId.toString(),
          );

          if (poojaDoc != null && scheduleDoc != null) {
            final schedule = PoojaSchedule.fromJson({
              ...scheduleDoc,
              'pooja': poojaDoc,
            });

            final bookedPoojaDetails = BookedPoojaDetails.fromJson({
              ...poojaEntry,
              'schedule': schedule.toJson(),
            });

            bookedPoojaDetailsList.add(bookedPoojaDetails);
          }
        }

        return {
          ...doc,
          'poojas':
              bookedPoojaDetailsList.map((pooja) => pooja.toJson()).toList(),
        };
      }),
    );

    return bookings.expand<Booking>((booking) {
      final List poojas = booking['poojas'];
      return poojas.map<Booking>((pooja) {
        return Booking.fromJson({...booking, 'pooja': pooja});
      });
    }).toList();
  }
}
