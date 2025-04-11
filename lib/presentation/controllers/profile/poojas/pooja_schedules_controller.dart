import 'package:aaraadhya_temple_dashboard/core/enums/pooja_time.dart';
import 'package:aaraadhya_temple_dashboard/core/enums/schedule_mode.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/utils/validators.dart';
import 'package:aaraadhya_temple_dashboard/data/models/common/validation_error.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja_schedule/pooja_schedule.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/validation_errors/pooja_schedule_validation_errors.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/pooja_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/poojas/pooja_schedules_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pooja_schedules_controller.g.dart';

@riverpod
class PoojaSchedulesController extends _$PoojaSchedulesController {
  @override
  PoojaSchedulesState build() {
    Future.microtask(loadSchedules);
    return PoojaSchedulesState.initial();
  }

  Future<void> loadSchedules() async {
    final poojaRepository = ref.watch(poojaRepositoryProvider);
    final authRepository = ref.watch(authRepositoryProvider);

    try {
      final user = authRepository.getCurrentUser();

      state = state.copyWith(isLoading: true, error: null);
      if (user != null) {
        state = state.copyWith(
          schedules: await poojaRepository.getPoojaSchedules(user.uid),
        );
      }
    } on BaseException catch (e) {
      state = state.copyWith(error: e);
    } catch (e) {
      state = state.copyWith(error: DatabaseException.unexpected(e.toString()));
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void selectPoojaForSchedule(Pooja pooja) {
    state = state.copyWith(schedule: state.schedule.copyWith(pooja: pooja));
  }

  void updateStatus(bool value) {
    state = state.copyWith(schedule: state.schedule.copyWith(isActive: value));
  }

  void updatePrice(String price) {
    state = state.copyWith(
      schedule: state.schedule.copyWith(price: price),
      validationErrors: state.validationErrors.copyWith(
        price: Validators.validateRequired(price),
      ),
    );
  }

  void updateDeityName(String deityName) {
    state = state.copyWith(
      schedule: state.schedule.copyWith(deityName: deityName),
      validationErrors: state.validationErrors.copyWith(
        deityName: Validators.validateRequired(deityName),
      ),
    );
  }

  void updateScheduleMode(ScheduleMode? scheduleMode) {
    state = state.copyWith(
      schedule: state.schedule.copyWith(scheduleMode: scheduleMode),
      validationErrors: state.validationErrors.copyWith(
        scheduleMode: Validators.validateNotNull(scheduleMode),
      ),
    );
  }

  void updatePoojaDays(List<bool>? days) {
    state = state.copyWith(
      schedule: state.schedule.copyWith(poojaDays: days),
      validationErrors: state.validationErrors.copyWith(
        poojaDays:
            state.schedule.scheduleMode == ScheduleMode.repeat && days != null
                ? !days.contains(true)
                    ? ValidationError.empty()
                    : null
                : ValidationError.empty(),
      ),
    );
  }

  void updatePoojaTime(PoojaTime? time) {
    state = state.copyWith(
      schedule: state.schedule.copyWith(poojaTime: time),
      validationErrors: state.validationErrors.copyWith(
        poojaTime:
            state.schedule.scheduleMode == ScheduleMode.repeat
                ? Validators.validateNotNull(time)
                : null,
      ),
    );
  }

  void updatePoojaDateTime(DateTime? date) {
    state = state.copyWith(
      schedule: state.schedule.copyWith(poojaDateAndTime: date),
      validationErrors: state.validationErrors.copyWith(
        poojaDateAndTime:
            state.schedule.scheduleMode == ScheduleMode.once
                ? Validators.validateNotNull(date)
                : null,
      ),
    );
  }

  void editSchedule(PoojaSchedule schedule) {
    state = state.copyWith(isEditing: true, schedule: schedule);
  }

  Future<void> changeStatus(bool status, String scheduleId) async {
    final poojaRepository = ref.read(poojaRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);

    try {
      final user = authRepository.getCurrentUser();

      if (user != null) {
        final schedule = state.schedules
            .singleWhere((doc) => doc.id == scheduleId)
            .copyWith(isActive: status);
        await poojaRepository.updatePoojaSchedule(user.uid, schedule);
        state = state.copyWith(
          schedules:
              state.schedules
                  .map((doc) => doc.id == schedule.id ? schedule : doc)
                  .toList(),
        );
      }
    } on BaseException catch (e) {
      state = state.copyWith(error: e);
    } catch (e) {
      state = state.copyWith(error: DatabaseException.unexpected(e.toString()));
    }
  }

  Future<dynamic> schedulePooja() async {
    if (!state.isValid) {
      return state = state.copyWith(
        validationErrors: state.validationErrors.copyWith(
          price: Validators.validateRequired(state.schedule.price),
          deityName: Validators.validateRequired(state.schedule.deityName),
          scheduleMode: Validators.validateNotNull(state.schedule.scheduleMode),
          poojaDays:
              state.schedule.scheduleMode == ScheduleMode.repeat &&
                      state.schedule.poojaDays != null
                  ? !state.schedule.poojaDays!.contains(true)
                      ? ValidationError.empty()
                      : null
                  : ValidationError.empty(),
          poojaTime:
              state.schedule.scheduleMode == ScheduleMode.repeat
                  ? Validators.validateNotNull(state.schedule.poojaTime)
                  : null,
          poojaDateAndTime:
              state.schedule.scheduleMode == ScheduleMode.once
                  ? Validators.validateNotNull(state.schedule.poojaDateAndTime)
                  : null,
          showValidationErrors: true,
        ),
      );
    }

    final poojaRepository = ref.read(poojaRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);

    try {
      final user = authRepository.getCurrentUser();

      state = state.copyWith(isSaving: true, error: null);

      if (user != null) {
        if (state.isEditing) {
          final schedule = await poojaRepository.updatePoojaSchedule(
            user.uid,
            state.schedule,
          );
          state = state.copyWith(
            isEditing: false,
            schedules:
                state.schedules
                    .map((doc) => doc.id == schedule.id ? schedule : doc)
                    .toList(),
          );
        } else {
          final schedule = await poojaRepository.addNewPoojaSchedule(
            user.uid,
            state.schedule,
          );
          state = state.copyWith(schedules: [schedule, ...state.schedules]);
        }
      }
    } on BaseException catch (e) {
      state = state.copyWith(error: e);
    } catch (e) {
      state = state.copyWith(error: DatabaseException.unexpected(e.toString()));
    } finally {
      state = state.copyWith(
        isSaving: false,
        schedule: PoojaSchedule.empty(),
        validationErrors: PoojaScheduleValidationErrors(),
      );
    }
  }
}
