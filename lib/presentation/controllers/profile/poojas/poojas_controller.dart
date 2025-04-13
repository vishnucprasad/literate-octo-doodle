import 'package:aaraadhya_temple_dashboard/core/enums/pooja_type.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/image_picker_exeception.dart';
import 'package:aaraadhya_temple_dashboard/core/utils/validators.dart';
import 'package:aaraadhya_temple_dashboard/data/models/common/validation_error.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/pooja_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/poojas/poojas_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'poojas_controller.g.dart';

@riverpod
class PoojasController extends _$PoojasController {
  @override
  PoojasState build() {
    Future.microtask(loadPoojas);
    return PoojasState.initial();
  }

  Future<void> loadPoojas() async {
    final poojaRepository = ref.watch(poojaRepositoryProvider);

    try {
      state = state.copyWith(isLoading: true, error: null);
      state = state.copyWith(poojas: await poojaRepository.getPoojas());
    } on BaseException catch (e) {
      state = state.copyWith(error: e);
    } catch (e) {
      state = state.copyWith(error: DatabaseException.unexpected(e.toString()));
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> pickPoojaImage() async {
    final poojaRepository = ref.read(poojaRepositoryProvider);

    try {
      final image = await poojaRepository.pickPoojaImage();

      state = state.copyWith(
        poojaImage: image,
        validationErrors: state.validationErrors.copyWith(
          poojaImage: Validators.validateNotNull(image),
        ),
      );
    } on BaseException catch (e) {
      state = state.copyWith(poojaImage: null, error: e);
    } catch (e) {
      state = state.copyWith(
        poojaImage: null,
        error: ImagePickerExeception.unexpected(e.toString()),
      );
    }
  }

  void updatePoojaName(String name) {
    state = state.copyWith(
      pooja: state.pooja.copyWith(name: name),
      validationErrors: state.validationErrors.copyWith(
        poojaName:
            state.poojas.any(
                  (pooja) => pooja.name.toLowerCase() == name.toLowerCase(),
                )
                ? ValidationError.duplicate()
                : Validators.validateName(name),
      ),
    );
  }

  void updatePoojaType(PoojaType type) {
    state = state.copyWith(
      pooja: state.pooja.copyWith(poojaType: type),
      validationErrors: state.validationErrors.copyWith(
        poojaType: Validators.validateNotNull(type),
      ),
    );
  }

  void updatePoojaPurpose(String purpose) {
    state = state.copyWith(pooja: state.pooja.copyWith(purpose: purpose));
  }

  void updatePoojaDescription(String description) {
    state = state.copyWith(
      pooja: state.pooja.copyWith(description: description),
      validationErrors: state.validationErrors.copyWith(
        poojaDescription: Validators.validateRequired(description),
      ),
    );
  }

  Future<dynamic> savePooja() async {
    if (!state.isValid) {
      return state = state.copyWith(
        validationErrors: state.validationErrors.copyWith(
          poojaName:
              state.poojas.any(
                    (pooja) =>
                        pooja.name.toLowerCase() ==
                        state.pooja.name.toLowerCase(),
                  )
                  ? ValidationError.duplicate()
                  : Validators.validateName(state.pooja.name),
          poojaType: Validators.validateNotNull(state.pooja.poojaType),
          poojaDescription: Validators.validateRequired(
            state.pooja.description,
          ),
          poojaImage: Validators.validateNotNull(state.poojaImage),
          showValidationErrors: true,
        ),
      );
    }

    final poojaRepository = ref.read(poojaRepositoryProvider);
    final authRepository = ref.read(authRepositoryProvider);

    try {
      state = state.copyWith(isSaving: true, error: null);

      final user = authRepository.getCurrentUser();

      if (user?.uid != null) {
        final pooja = await poojaRepository.addPooja(
          state.pooja.copyWith(createdBy: user!.uid),
          state.poojaImage!,
        );
        state = state.copyWith(
          isLoading: false,
          poojas: [pooja, ...state.poojas],
          pooja: Pooja.empty(),
        );
      }
    } on BaseException catch (e) {
      state = state.copyWith(error: e);
    } catch (e) {
      state = state.copyWith(error: DatabaseException.unexpected(e.toString()));
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}
