import 'package:aaraadhya_temple_dashboard/data/models/dashboard/dashboard_data.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/booking_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/pooja_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories_impl/dashboard_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_repository.g.dart';

abstract class DashboardRepository {
  Future<DashboardData> loadDashboardData({required String userId});
}

@riverpod
DashboardRepository dashboardRepository(Ref ref) {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  final poojaRepository = ref.watch(poojaRepositoryProvider);

  return DashboardRepositoryImpl(bookingRepository, poojaRepository);
}
