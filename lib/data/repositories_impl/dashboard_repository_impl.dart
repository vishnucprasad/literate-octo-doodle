import 'package:aaraadhya_temple_dashboard/data/models/dashboard/dashboard_data.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/booking_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/dashboard_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/pooja_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final BookingRepository _bookingRepository;
  final PoojaRepository _poojaRepository;

  DashboardRepositoryImpl(this._bookingRepository, this._poojaRepository);

  @override
  Future<DashboardData> loadDashboardData({required String userId}) async {
    try {
      final bookings = await _bookingRepository.getAllBookings(
        userId: userId,
        date: DateTime.now(),
        status: null,
      );
      final payments = await _bookingRepository.getPayments(
        userId: userId,
        date: DateTime.now(),
      );
      final poojas = await _poojaRepository.getPoojaSchedules(userId);

      return DashboardData(
        totalPayments: payments.fold<double>(
          0,
          (amount, payment) => amount + double.parse(payment.price),
        ),
        totalBookings: bookings.length,
        totalActivePoojas: poojas.where((pooja) => pooja.isActive).length,
        latestBookings: List.generate(
          bookings.length < 3 ? bookings.length : 3,
          (index) => bookings[index],
        ),
      );
    } catch (_) {
      rethrow;
    }
  }
}
