import 'package:aaraadhya_temple_dashboard/core/exceptions/auth_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/auth/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    Future.delayed(const Duration(seconds: 1), () {
      listenToAuthState();
    });
    return AuthState();
  }

  void listenToAuthState() {
    final authRepository = ref.read(authRepositoryProvider);

    authRepository.authStateChanges().listen((user) {
      state = state.copyWith(isAuthenticating: false, user: user);
    });
  }

  Future<void> signOut() async {
    state = state.copyWith(isSigningOut: true, error: null);

    final authRepository = ref.read(authRepositoryProvider);
    try {
      await authRepository.signOut();
      state = state.copyWith(isSigningOut: false);
    } catch (e) {
      state = state.copyWith(
        isSigningOut: false,
        error: AuthException.unexpected(e.toString()),
      );
    }
  }
}
