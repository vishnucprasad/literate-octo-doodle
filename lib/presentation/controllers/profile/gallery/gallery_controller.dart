import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/profile_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/gallery/gallery_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gallery_controller.g.dart';

@riverpod
class GalleryController extends _$GalleryController {
  @override
  GalleryState build() {
    Future.microtask(loadImages);
    return GalleryState();
  }

  Future<void> loadImages() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final profileRepository = ref.watch(profileRepositoryProvider);

    try {
      state = state.copyWith(isLoading: true, error: null);

      final user = authRepository.getCurrentUser();

      if (user != null) {
        final images = await profileRepository.getGalleryItems(user.uid);

        state = state.copyWith(
          images: images,
          selectedImages: List.generate(images.length, (index) => false),
        );
      }

      state = state.copyWith(isLoading: false, error: null);
    } on BaseException catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: DatabaseException.unexpected(e.toString()),
      );
    }
  }

  Future<void> uploadImageToGallery() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final profileRepository = ref.watch(profileRepositoryProvider);

    try {
      state = state.copyWith(isUploading: true, error: null);

      final user = authRepository.getCurrentUser();

      if (user != null) {
        final newItem = await profileRepository.uploadNewGalleryItem(user.uid);
        state = state.copyWith(
          images: [newItem, ...state.images],
          selectedImages: List.generate(
            state.images.length + 1,
            (index) => false,
          ),
        );
      }

      state = state.copyWith(isUploading: false);
    } on BaseException catch (e) {
      state = state.copyWith(isUploading: false, error: e);
    } catch (e) {
      state = state.copyWith(
        isUploading: false,
        error: DatabaseException.unexpected(e.toString()),
      );
    }
  }

  Future<void> deleteSelectedImages() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final profileRepository = ref.watch(profileRepositoryProvider);

    try {
      state = state.copyWith(isDeleting: true, error: null);

      final user = authRepository.getCurrentUser();

      if (user != null) {
        final futures =
            state.selectedImages
                .asMap()
                .entries
                .where((entry) => entry.value)
                .map(
                  (entry) => profileRepository.deleteGalleryItem(
                    user.uid,
                    state.images[entry.key],
                  ),
                )
                .toList();

        await Future.wait(futures);

        final images =
            state.images.where((image) {
              return !state.selectedImages[state.images.indexOf(image)];
            }).toList();

        state = state.copyWith(
          images: images,
          selectedImages: List.generate(images.length, (index) => false),
        );
      }

      state = state.copyWith(isDeleting: false);
    } on BaseException catch (e) {
      state = state.copyWith(isDeleting: false, error: e);
    } catch (e) {
      state = state.copyWith(
        isDeleting: false,
        error: DatabaseException.unexpected(e.toString()),
      );
    }
  }

  void selectImage(index) {
    state = state.copyWith(
      selectedImages:
          state.selectedImages.asMap().entries.map((entry) {
            if (entry.key == index) {
              return !entry.value;
            }
            return entry.value;
          }).toList(),
    );
  }

  void changeSelectMode(bool isActive) {
    state = state.copyWith(selectionModeActive: isActive);
  }

  bool get isAnySelected => state.selectedImages.any((value) => value == true);
}
