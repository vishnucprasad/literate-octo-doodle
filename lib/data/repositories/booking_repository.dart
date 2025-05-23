import 'package:aaraadhya_temple_dashboard/core/enums/booking_status.dart';
import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/booking/booking.dart';
import 'package:aaraadhya_temple_dashboard/data/models/payment/payment.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories_impl/booking_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_repository.g.dart';

abstract class BookingRepository {
  Future<List<Payment>> getPayments({
    required String userId,
    required DateTime date,
    BookingStatus? status,
  });
  Future<void> updateBookingStatus({
    required String bookingId,
    required BookingStatus status,
  });
  Future<List<Booking>> getAllBookings({
    required String userId,
    required DateTime date,
  });
  Future<void> updatePoojaCompletionStatus({
    required String id,
    required String bookingId,
    required bool value,
  });
}

@riverpod
BookingRepository bookingRepository(Ref ref) {
  return BookingRepositoryImpl(ref.watch(dbDatasourceProvider));
}
