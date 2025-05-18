import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/booking/booking.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories_impl/booking_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_respository.g.dart';

abstract class BookingRespository {
  Future<List<Booking>> getAllBookings(String userId, DateTime date);
}

@riverpod
BookingRespository bookingRespository(Ref ref) {
  return BookingRepositoryImpl(ref.watch(dbDatasourceProvider));
}
