import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/booking/booking.dart';
import 'package:aaraadhya_temple_dashboard/data/models/booking/booked_pooja_details/booked_pooja_details.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja_schedule/pooja_schedule.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/booking_respository.dart';

class BookingRepositoryImpl implements BookingRespository {
  final DbDatasource _dbDatasource;

  BookingRepositoryImpl(this._dbDatasource);

  String _getDateOnlyFromISOString(String isoString) {
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
  Future<List<Booking>> getAllBookings(String userId, DateTime date) async {
    final docs = await _dbDatasource.queryCollection(
      'bookings',
      conditions: [
        QueryCondition(field: "templeId", operator: "==", value: userId),
        QueryCondition(
          field: "poojaDates",
          operator: "array-contains",
          value: _getDateOnlyFromISOString(date.toIso8601String()),
        ),
      ],
    );

    final bookings = await Future.wait(
      docs.map((doc) async {
        final poojasList = doc['poojas'];
        final List<dynamic> poojasRawList =
            poojasList != null ? (poojasList as List<dynamic>) : [];

        final poojaEntries =
            poojasRawList.map((item) {
              if (item is Map<String, dynamic>) {
                return item;
              }
              return <String, dynamic>{};
            }).toList();

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

        return Booking.fromJson({
          ...doc,
          'poojas':
              bookedPoojaDetailsList.map((pooja) => pooja.toJson()).toList(),
        });
      }),
    );

    return bookings;
  }
}
